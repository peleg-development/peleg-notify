local defaultTitle = "Notification"
local defaultType = "info"
local defaultDarkMode = true
local defaultDuration = 5000

RegisterNetEvent("peleg-notify:client:showNotification", function(description, title, type, duration, darkMode)
    SendNUIMessage({
        action = "showNotification",
        title = title or defaultTitle,
        type = type or defaultType,
        description = description,
        duration = duration or defaultDuration,
        darkMode = darkMode or defaultDarkMode
    })
end)

exports("notify", function(description, title, type, duration, darkMode)
    if not description then
        print("^1[Error]: Description is required for the notification^0")
        return
    end
    TriggerEvent("peleg-notify:client:showNotification", description, title, type, duration, darkMode)
end)

exports("Notify", function(description, title, type, duration, darkMode)
    if not description then
        print("^1[Error]: Description is required for the notification^0")
        return
    end
    TriggerEvent("peleg-notify:client:showNotification", description, title, type, duration, darkMode)
end)

-- Available notification types:
-- "success" - with check icon
-- "error" - with X icon
-- "warning" - with exclamation triangle icon
-- "info" - with info circle icon
