# peleg-notify
A clean and customizable notification system for FiveM, compatible with all frameworks. Includes sound support and a detailed guide for QBCore installation.
for support join this (discord server)[https://discord.gg/qHnZqNbWkx] and open a ticket

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
   - For QBCore, ensure the resource is properly integrated by using the examples below.

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
