# peleg-notify
A clean and customizable notification system for FiveM, compatible with all frameworks. Includes sound support and a detailed guide for QBCore installation.

For support join this [Discord server](https://discord.gg/qHnZqNbWkx) and open a ticket.

---

## Features
- **Clean UI:** Designed for clarity and simplicity.
- **Framework Compatibility:** Works with any FiveM framework.
- **Sounds:** Play sounds for each notification type.
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
3. Replace it with the following code to use `peleg-notify`:
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
The resource provides a client export and an event to trigger notifications. 

### Examples

#### Trigger Notification with Export
```lua
exports["peleg-notify"]:notify("This is a description", "Custom Title", "success", 7000, true)
```

#### Trigger Notification with Event
```lua
TriggerEvent("peleg-notify:client:showNotification", "This is a description", "Custom Title", "error", 5000, false)
```

### Parameters
| Parameter      | Type    | Default       | Description                                              |
|----------------|---------|---------------|----------------------------------------------------------|
| `description`  | string  | **Required**  | The main text of the notification.                      |
| `title`        | string  | `"Notification"` | The title of the notification. Optional.               |
| `type`         | string  | `"info"`      | The type of notification (`success`, `error`, `info`, `warning`). |
| `duration`     | number  | `5000`        | Duration in milliseconds before the notification disappears. |
| `darkMode`     | boolean | `false`       | Whether the notification should use dark mode styling.   |

---

## Examples

### Example 1: Success Notification
```lua
exports["peleg-notify"]:notify("Your action was successful!", "Success", "success", 5000, false)
```

### Example 2: Error Notification in Dark Mode
```lua
TriggerEvent("peleg-notify:client:showNotification", "Something went wrong!", "Error", "error", 8000, true)
```

### Example 3: Warning Notification
```lua
exports["peleg-notify"]:notify("This is a warning!", nil, "warning", 4000, false)
```

---

## Preview
![image](https://github.com/user-attachments/assets/cb0daf8d-f14e-4731-869e-f657a3809dda)
![image](https://github.com/user-attachments/assets/20c17a4e-3b70-47a4-950e-a7665311de4c)

---

## License
This resource is open-source and available under the MIT license.
