local hoverEnabled = false
local hoverAmount = 0.0
local altitude
local lastToggle = 0

local function notify(message, kind)
    if Config.ShowNotification and GetResourceState('qb-core') == 'started' then
        TriggerEvent('QBCore:Notify', message, kind or 'primary')
    end
end

local function isPilotInHelicopter()
    local ped = PlayerPedId()
    if not IsPedInAnyHeli(ped) then return false, 0 end

    local heli = GetVehiclePedIsIn(ped, false)
    if heli == 0 or GetPedInVehicleSeat(heli, -1) ~= ped then
        return false, heli
    end
    return true, heli
end

local function setHover(enabled, heli)
    hoverEnabled = enabled
    if enabled then
        altitude = GetEntityCoords(heli).z
        notify('Hover mode activating...', 'success')
    else
        altitude = nil
        notify('Hover mode disabled.', 'primary')
    end
end

local function updateHoverAmount(delta)
    local duration = hoverEnabled and Config.ActivationTime or Config.ReleaseTime
    local step = delta / math.max(duration, 1)
    if hoverEnabled then
        hoverAmount = math.min(1.0, hoverAmount + step)
    else
        hoverAmount = math.max(0.0, hoverAmount - step)
    end
end

local function applyHover(heli, delta)
    local position = GetEntityCoords(heli)
    local velocity = GetEntityVelocity(heli)
    local damping = Config.HorizontalDamping * hoverAmount
    local vx = velocity.x * math.max(0.0, 1.0 - damping)
    local vy = velocity.y * math.max(0.0, 1.0 - damping)
    local vz = velocity.z

    if Config.AltitudeHold and altitude then
        local error = altitude - position.z
        local correction = math.max(-Config.MaxVerticalCorrection,
            math.min(Config.MaxVerticalCorrection, error * Config.VerticalStrength))
        vz = vz + correction * hoverAmount
    end

    SetEntityVelocity(heli, vx, vy, vz)
    SetVehicleForwardSpeed(heli, GetEntitySpeed(heli) * (1.0 - hoverAmount))

    if Config.DisableMovementControls and hoverAmount > 0.05 then
        DisableControlAction(0, 32, true)  -- W
        DisableControlAction(0, 33, true)  -- S
        DisableControlAction(0, 34, true)  -- A
        DisableControlAction(0, 35, true)  -- D
        DisableControlAction(0, 111, true) -- helicopter descend
        DisableControlAction(0, 112, true) -- helicopter ascend
    end

    if Config.Debug and math.floor(GetGameTimer() / 1000) % 2 == 0 then
        print(('[heli_hover_mode] assist %.2f altitude %.2f'):format(hoverAmount, altitude or 0.0))
    end
end

CreateThread(function()
    while true do
        local wait = 250
        local pilot, heli = isPilotInHelicopter()

        if pilot then
            wait = 0
            local togglePressed = IsControlJustPressed(0, Config.Toggle.key)
                or IsDisabledControlJustPressed(0, Config.Toggle.key)
            if IsControlPressed(0, Config.Toggle.modifier)
                and togglePressed
                and GetGameTimer() - lastToggle > 500 then
                lastToggle = GetGameTimer()
                setHover(not hoverEnabled, heli)
            end

            updateHoverAmount(GetFrameTime() * 1000)
            if hoverAmount > 0.0 then
                applyHover(heli, GetFrameTime() * 1000)
            end
        elseif hoverEnabled or hoverAmount > 0.0 then
            hoverEnabled = false
            altitude = nil
            updateHoverAmount(GetFrameTime() * 1000)
        end

        Wait(wait)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    hoverEnabled = false
    hoverAmount = 0.0
    altitude = nil
end)
