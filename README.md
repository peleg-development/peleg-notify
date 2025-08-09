# peleg-notify
A clean and customizable notification system for FiveM, compatible with all frameworks. Includes sound support, RTL text support, custom notifications, and a detailed guide for QBCore installation.

For support join this [Discord server](https://discord.gg/qHnZqNbWkx) and open a ticket.

---

## Preview
<img width="396" height="710" alt="image" src="https://github.com/user-attachments/assets/0119d259-3908-4134-a7f4-ed6b3e5a4dae" />

---

## Features
- **Clean UI:** Designed for clarity and simplicity.
- **Framework Compatibility:** Works with any FiveM framework.
- **Sounds:** Play sounds for each notification type.
- **RTL Support:** Right-to-left text support for languages like Arabic and Hebrew.
- **Custom Notifications:** Create notifications with custom colors and icons.
- **Customization:** Customize title, type, duration, and dark mode for each notification.

---

## Installation
1. **Download the Resource**
   - Clone or download the `peleg-notify` repository.

2. **Add to Your Server**
   - Place the `peleg-notify` folder in your FiveM `resources` directory.

3. **Add to `server.cfg`**
   - Add the following line to your `server.cfg`:
     ```
     ensure peleg-notify
     ```

4. **QBCore Installation**

### Server-Side Changes
1. Navigate to the file:
   ```
   qb-core\server\functions.lua
   ```
2. Look for the following function:
   ```lua
   function QBCore.Functions.Notify(source, text, type, length)
       TriggerClientEvent('QBCore:Notify', source, text, type, length)
   end
   ```
3. Replace it with the following code to use `peleg-notify` note if u want the defualt title put nil insted of "Notification":
   ```lua
   function QBCore.Functions.Notify(source, text, type, length)
       TriggerClientEvent("peleg-notify:client:showNotification", source, text, "Notification", type, length, false)
   end
   ```

### Client-Side Changes
1. Navigate to the file:
   ```
   qb-core\client\functions.lua
   ```
2. Look for the following function:
   ```lua
   function QBCore.Functions.Notify(text, texttype, length, icon)
          local message = {
           action = 'notify',
           type = texttype or 'primary',
           length = length or 5000,
       }

       if type(text) == 'table' then
           message.text = text.text or 'Placeholder'
           message.caption = text.caption or 'Placeholder'
       else
           message.text = text
       end

       if icon then
           message.icon = icon
       end

       SendNUIMessage(message)
   end
   ```
   
3. Replace it with the following code to use `peleg-notify`:
   ```lua
   function QBCore.Functions.Notify(text, texttype, length, custom_icon)
       local type = texttype or "info"
       local title = "Notification"
       local darkMode = false
       if type(text) == "table" then
           local message = text.text
           local duration = length or 5000
           exports["peleg-notify"]:notify(message, title, type, duration, darkMode)
       else
           local message = text
           local duration = length or 5000
           exports["peleg-notify"]:notify(message, title, type, duration, darkMode)
       end
   end
   ```

---

## Usage
The resource provides client exports and events to trigger notifications.

### Standard Notifications

#### Trigger Notification with Export
```lua
exports["peleg-notify"]:notify("This is a description", "Custom Title", "success", 7000, true, false)
-- or
exports["peleg-notify"]:Notify("This is a description", "Custom Title", "success", 7000, true, false)
```

#### Trigger Notification with Event
```lua
TriggerEvent("peleg-notify:client:showNotification", "This is a description", "Custom Title", "error", 5000, false, false)
```

### Custom Notifications

#### Trigger Custom Notification with Export
```lua
exports["peleg-notify"]:notifyCustom("POLICE: Something bad is happening", "POLICE ALERT", "#2563eb", "fa-solid fa-shield-halved", 6000, true, false)
-- or
exports["peleg-notify"]:NotifyCustom("POLICE: Something bad is happening", "POLICE ALERT", "#2563eb", "fa-solid fa-shield-halved", 6000, true, false)
```

#### Trigger Custom Notification with Event
```lua
TriggerEvent("peleg-notify:client:showCustomNotification", "Server restart in 10 minutes", "SERVER NOTICE", "#8b5cf6", "fa-solid fa-bullhorn", 7000, true, false)
```

### Standard Notification Parameters
| Parameter      | Type    | Default         | Description                                              |
|----------------|---------|-----------------|----------------------------------------------------------|
| `description`  | string  | **Required**    | The main text of the notification.                      |
| `title`        | string  | `"Notification"`| The title of the notification. Optional.               |
| `type`         | string  | `"info"`        | The type of notification (`success`, `error`, `info`, `warning`). |
| `duration`     | number  | `5000`          | Duration in milliseconds before the notification disappears. |
| `darkMode`     | boolean | `true`          | Whether the notification should use dark mode styling.   |
| `rtl`          | boolean | `false`         | Whether the notification should use right-to-left text direction. |

### Custom Notification Parameters
| Parameter      | Type    | Default         | Description                                              |
|----------------|---------|-----------------|----------------------------------------------------------|
| `description`  | string  | **Required**    | The main text of the notification.                      |
| `title`        | string  | `"Notification"`| The title of the notification. Optional.               |
| `customColor`  | string  | **Required**    | Hex color code for the notification (e.g., "#2563eb"). |
| `customIcon`   | string  | **Required**    | FontAwesome icon class (e.g., "fa-solid fa-shield-halved"). |
| `duration`     | number  | `5000`          | Duration in milliseconds before the notification disappears. |
| `darkMode`     | boolean | `true`          | Whether the notification should use dark mode styling.   |
| `rtl`          | boolean | `false`         | Whether the notification should use right-to-left text direction. |

---

## Examples

### Example 1: Success Notification
```lua
exports["peleg-notify"]:notify("Your action was successful!", "Success", "success", 5000, false, false)
```

### Example 2: Error Notification in Dark Mode
```lua
TriggerEvent("peleg-notify:client:showNotification", "Something went wrong!", "Error", "error", 8000, true, false)
```

### Example 3: Warning Notification
```lua
exports["peleg-notify"]:notify("This is a warning!", nil, "warning", 4000, false, false)
```

### Example 4: RTL Support (Hebrew/Arabic)
```lua
exports["peleg-notify"]:notify("וואלק אנחנו תומכים גם בעברית", "התראה", "info", 6000, true, true)
```

### Example 5: Custom Police Alert
```lua
exports["peleg-notify"]:notifyCustom("POLICE: Something bad is happening", "POLICE ALERT", "#2563eb", "fa-solid fa-shield-halved", 6000, true, false)
```

### Example 6: Custom Server Notice
```lua
TriggerEvent("peleg-notify:client:showCustomNotification", "Server restart in 10 minutes", "SERVER NOTICE", "#8b5cf6", "fa-solid fa-bullhorn", 7000, true, false)
```

---

## Available Notification Types
- `"success"` - Green notification with check icon
- `"error"` - Red notification with X icon  
- `"warning"` - Orange notification with exclamation triangle icon
- `"info"` - Blue notification with info circle icon
- `"custom"` - Custom color and icon (only available with custom notification functions)

---

## FontAwesome Icons
For custom notifications, you can use any FontAwesome icon. Examples:
- `"fa-solid fa-shield-halved"` - Police/Security
- `"fa-solid fa-bullhorn"` - Announcements
- `"fa-solid fa-car"` - Vehicle related
- `"fa-solid fa-home"` - Property related
- `"fa-solid fa-money-bill"` - Money related

---

## License
This resource is open-source and available under the MIT license.
