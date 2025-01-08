local defaultTitle = "Notification"
local defaultType = "info"
local defaultDarkMode = false
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
