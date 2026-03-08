# peleg-notify

A **premium, modern, and unique** notification system for FiveM. Designed with a sleek glassmorphism aesthetic, smooth animations, and complete framework compatibility.

For support join this [Discord server](https://discord.gg/qHnZqNbWkx) and open a ticket.

---

## ✨ Preview

<img width="396" height="710" alt="peleg-notify preview" src="https://github.com/user-attachments/assets/0119d259-3908-4134-a7f4-ed6b3e5a4dae" />

---

## 🚀 Features

- **🎨 Premium Glassmorphism UI** - Modern frosted glass effect with backdrop blur
- **✨ Smooth Animations** - Professional entrance/exit animations with bounce effects
- **🔊 Sound Support** - Optional notification sounds with toggle button
- **🌍 RTL Support** - Full right-to-left text support for Arabic, Hebrew, and more
- **🎭 Custom Notifications** - Create unique notifications with custom colors and icons
- **📍 7 Position Options** - Place notifications anywhere on screen
- **⚡ Framework Agnostic** - Works with QBCore, ESX, and any custom framework
- **📱 Mobile Responsive** - Looks great on all screen sizes
- **🎯 Click to Dismiss** - Click any notification to close it instantly
- **💾 Persistent Settings** - Sound preference saved locally

---

## 📦 Installation

### 1. Download the Resource
Clone or download the `peleg-notify` repository into your FiveM resources folder.

### 2. Add to server.cfg
```
ensure peleg-notify
```

### 3. Framework Integration

#### QBCore Server-Side (qb-core/server/functions.lua)
Replace the existing `QBCore.Functions.Notify`:
```lua
function QBCore.Functions.Notify(source, text, type, length)
    TriggerClientEvent("peleg-notify:client:showNotification", source, text, "Notification", type, length, false)
end
```

#### QBCore Client-Side (qb-core/client/functions.lua)
Replace the existing `QBCore.Functions.Notify`:
```lua
function QBCore.Functions.Notify(text, texttype, length, custom_icon)
    local _type = texttype or "info"
    local title = "Notification"
    local darkMode = false
    if type(text) == "table" then
        local message = text.text
        local duration = length or 5000
        exports["peleg-notify"]:notify(message, title, _type, duration, darkMode, false, "top-right")
    else
        local message = text
        local duration = length or 5000
        exports["peleg-notify"]:notify(message, title, _type, duration, darkMode, false, "top-right")
    end
end
```

---

## 📝 Usage

### Standard Notifications

#### Using Export (Recommended)
```lua
exports["peleg-notify"]:notify(
    "This is a description",     -- Message text
    "Custom Title",              -- Title (optional, default: "Notification")
    "success",                   -- Type: success, error, warning, info
    7000,                        -- Duration in ms (optional, default: 5000)
    true,                        -- Dark mode (optional, default: true)
    false,                       -- RTL text (optional, default: false)
    "top-right"                  -- Position (optional, default: "top-right")
)
```

#### Using Event
```lua
TriggerEvent("peleg-notify:client:showNotification", 
    "This is a description", 
    "Custom Title", 
    "error", 
    5000, 
    false, 
    false, 
    "bottom-left"
)
```

### Custom Notifications

Create unique notifications with your own colors and icons:

#### Using Export
```lua
exports["peleg-notify"]:notifyCustom(
    "POLICE: Backup needed!",           -- Message
    "POLICE ALERT",                      -- Title
    "#2563eb",                          -- Custom color (hex)
    "fa-solid fa-shield-halved",        -- FontAwesome icon
    6000,                               -- Duration
    true,                               -- Dark mode
    false,                              -- RTL
    "top-center"                        -- Position
)
```

#### Using Event
```lua
TriggerEvent("peleg-notify:client:showCustomNotification", 
    "Server restart in 10 minutes", 
    "SERVER NOTICE", 
    "#8b5cf6", 
    "fa-solid fa-bullhorn", 
    7000, 
    true, 
    false, 
    "center"
)
```

---

## 📋 Parameter Reference

### Standard Notification Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `description` | string | **Required** | Main message text |
| `title` | string | `"Notification"` | Notification title |
| `type` | string | `"info"` | Notification type: `success`, `error`, `warning`, `info` |
| `duration` | number | `5000` | Duration in milliseconds |
| `darkMode` | boolean | `true` | Enable dark mode styling |
| `rtl` | boolean | `false` | Right-to-left text direction |
| `position` | string | `"top-right"` | Screen position (see below) |

### Custom Notification Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `description` | string | **Required** | Main message text |
| `title` | string | `"Notification"` | Notification title |
| `customColor` | string | **Required** | Hex color code (e.g., `"#2563eb"`) |
| `customIcon` | string | **Required** | FontAwesome icon class |
| `duration` | number | `5000` | Duration in milliseconds |
| `darkMode` | boolean | `true` | Enable dark mode styling |
| `rtl` | boolean | `false` | Right-to-left text direction |
| `position` | string | `"top-right"` | Screen position |

---

## 🎨 Notification Types

| Type | Color | Icon | Use Case |
|------|-------|------|----------|
| `success` | 🟢 Green | Check Circle | Success messages |
| `error` | 🔴 Red | Times Circle | Error messages |
| `warning` | 🟠 Orange | Exclamation Triangle | Warning messages |
| `info` | 🔵 Blue | Info Circle | Information |
| `custom` | 🎨 Any | Any | Custom alerts |

---

## 📍 Available Positions

- `"top-right"` - Top right corner (default)
- `"top-left"` - Top left corner
- `"top-center"` - Top center
- `"bottom-right"` - Bottom right corner
- `"bottom-left"` - Bottom left corner
- `"bottom-center"` - Bottom center
- `"center"` - Center of screen

---

## 💡 Examples

### Success Notification
```lua
exports["peleg-notify"]:notify("Item purchased successfully!", "Success", "success", 5000)
```

### Error Notification
```lua
exports["peleg-notify"]:notify("Insufficient funds!", "Error", "error", 8000, true)
```

### Warning Notification
```lua
exports["peleg-notify"]:notify("Low fuel!", "Warning", "warning", 4000)
```

### RTL Support (Hebrew/Arabic)
```lua
exports["peleg-notify"]:notify("הפעולה הושלמה בהצלחה!", "התראה", "success", 6000, true, true)
```

### Police Alert
```lua
exports["peleg-notify"]:notifyCustom(
    "All units respond to 10-31", 
    "POLICE DISPATCH", 
    "#3b82f6", 
    "fa-solid fa-shield-alt", 
    8000, 
    true, 
    false, 
    "top-center"
)
```

### Server Announcement
```lua
exports["peleg-notify"]:notifyCustom(
    "Server restart in 15 minutes", 
    "SERVER NOTICE", 
    "#8b5cf6", 
    "fa-solid fa-bullhorn", 
    10000, 
    true, 
    false, 
    "center"
)
```

### Different Positions
```lua
-- Top center
exports["peleg-notify"]:notify("Top center message", "Info", "info", 5000, true, false, "top-center")

-- Bottom left
exports["peleg-notify"]:notify("Bottom left message", "Warning", "warning", 5000, true, false, "bottom-left")

-- Center of screen
exports["peleg-notify"]:notify("Center message", "Alert", "error", 5000, true, false, "center")
```

---

## 🎯 FontAwesome Icons

Use any FontAwesome 6 icon for custom notifications:

| Icon | Class | Use Case |
|------|-------|----------|
| 🛡️ | `fa-solid fa-shield-alt` | Police/Security |
| 📢 | `fa-solid fa-bullhorn` | Announcements |
| 🚗 | `fa-solid fa-car` | Vehicles |
| 🏠 | `fa-solid fa-home` | Property |
| 💰 | `fa-solid fa-money-bill` | Money |
| ⭐ | `fa-solid fa-star` | VIP/Special |
| 🔧 | `fa-solid fa-wrench` | Mechanic |
| 🏥 | `fa-solid fa-hospital` | Medical |

Find more icons at [FontAwesome](https://fontawesome.com/icons)

---

## 🔧 Client Exports

```lua
-- Standard notification
exports['peleg-notify']:notify(description, title, type, duration, darkMode, rtl, position)
exports['peleg-notify']:Notify(description, title, type, duration, darkMode, rtl, position)

-- Custom notification
exports['peleg-notify']:notifyCustom(description, title, color, icon, duration, darkMode, rtl, position)
exports['peleg-notify']:NotifyCustom(description, title, color, icon, duration, darkMode, rtl, position)
```

---

## 📜 License

This resource is open-source and available under the GPL license.

---

## 🙏 Credits

Created by **Peleg** - A modern notification system designed for the FiveM community.
