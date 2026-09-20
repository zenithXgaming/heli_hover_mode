# 🚁 FiveM Helicopter Hover Mode
A lightweight and configurable **FiveM helicopter hover-assist resource** that allows helicopter pilots to activate a hover mode with altitude holding and movement damping.

## ✨ Features
* 🚁 Helicopter pilot-only hover mode
* ⌨️ Configurable activation key
* 🔄 Toggle hover mode on/off
* 📈 Gradual hover activation
* 📉 Smooth hover release
* 📏 Altitude hold
* ↔️ Horizontal movement damping
* 🛑 Optional movement-control restriction
* 🔔 Optional notifications
* ⚙️ Fully configurable
* 🧩 No required framework
* 🪶 Lightweight client-side resource

## 📦 Installation
1. Download or clone this repository.
2. Place the resource inside your FiveM resources folder:
```text
resources/[local]/heli_hover_mode
```
3. Add the following line to your `server.cfg`:
```cfg
ensure heli_hover_mode
```
4. Restart the resource or restart your FiveM server.

## 🎮 Controls
The default hover toggle is:
```text
LEFT SHIFT + A
```
Press the same key combination again to disable hover mode.
The key combination can be changed in `config.lua`.

## ⚙️ Configuration
All major settings can be configured through `config.lua`.
Example:
```lua
Config.Toggle = {
    modifier = 21, -- Left Shift
    key = 34,      -- A
}
Config.ActivationTime = 2500
Config.ReleaseTime = 1200
Config.AltitudeHold = true
Config.VerticalStrength = 0.35
Config.MaxVerticalCorrection = 2.5
Config.HorizontalDamping = 0.12
Config.DisableMovementControls = true
Config.ShowNotification = true
Config.Debug = false
```

## 🛠️ How It Works
When the helicopter pilot activates hover mode:
1. The current helicopter altitude is recorded.
2. The script gradually activates the hover system.
3. The helicopter attempts to maintain the recorded altitude.
4. Horizontal movement is reduced using configurable damping.
5. The pilot can disable hover mode at any time.
6. Hover mode automatically disables when the pilot leaves the helicopter.
The gradual activation and release are designed to provide a smoother transition instead of instantly locking the helicopter in place.

## 🚁 Supported Vehicles
The script is designed for GTA V helicopters and can be used with custom helicopter vehicles as long as they are recognized by FiveM/GTA V as helicopters.
Vehicle handling and flight characteristics may vary between helicopter models.

## 📋 Requirements
* FiveM
* GTA V
* Lua support

### Framework
No framework is required.
The resource can run independently on a standalone FiveM server.

## 🐛 Debugging
If you experience unexpected behavior, enable debug mode in `config.lua`:
```lua
Config.Debug = true
```
Test the resource with different helicopter models because flight behavior can differ depending on the vehicle's handling configuration.

## 🔄 Updating
To update the resource:
1. Replace the existing resource files with the latest version.
2. Restart the resource:
```text
restart heli_hover_mode
```
Or restart the complete FiveM server.

## ⚠️ Compatibility
This resource modifies helicopter movement while hover mode is active.
Other helicopter handling, flight, or physics resources may interfere with the hover system.
If you experience conflicts, test the resource without other helicopter-control scripts enabled.

## 📜 License
Copyright © 2026 Zenith Gaming.
Permission is granted to use this resource on FiveM servers.
Redistribution, resale, rebranding, or claiming this resource as your own is not permitted without permission from the author.

## 💡 Support
If you find a bug or have a feature request, please open an **Issue** in this repository.
When reporting a bug, include:
* FiveM server version
* Helicopter model
* Error message from the console/F8
* Description of the issue
* Steps to reproduce the problem

## ⭐ Credits
Created for the FiveM community by **Zenith Gaming**.
If you find this resource useful, consider giving the repository a ⭐.
