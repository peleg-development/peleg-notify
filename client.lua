local defaultTitle = "Notification"
local defaultType = "info"
local defaultDarkMode = true
local defaultDuration = 5000
local defaultRtl = false

RegisterNetEvent("peleg-notify:client:showNotification", function(description, title, type, duration, darkMode, rtl)
    print(rtl)
    SendNUIMessage({
        action = "showNotification",
        title = title or defaultTitle,
        type = type or defaultType,
        description = description,
        duration = duration or defaultDuration,
        darkMode = darkMode or defaultDarkMode,
        rtl = rtl or defaultRtl
    })
end)

exports("notify", function(description, title, type, duration, darkMode, rtl)
    if not description then
        print("^1[Error]: Description is required for the notification^0")
        return
    end
    TriggerEvent("peleg-notify:client:showNotification", description, title, type, duration, darkMode, rtl)
end)

exports("Notify", function(description, title, type, duration, darkMode, rtl)
    if not description then
        print("^1[Error]: Description is required for the notification^0")
        return
    end
    TriggerEvent("peleg-notify:client:showNotification", description, title, type, duration, darkMode, rtl)
end)

RegisterNetEvent("peleg-notify:client:showCustomNotification", function(description, title, customColor, customIcon, duration, darkMode, rtl)
    SendNUIMessage({
        action = "showCustomNotification",
        title = title or defaultTitle,
        type = "custom",
        description = description,
        duration = duration or defaultDuration,
        darkMode = darkMode or defaultDarkMode,
        rtl = rtl or defaultRtl,
        customColor = customColor,
        customIcon = customIcon
    })
end)

exports("notifyCustom", function(description, title, customColor, customIcon, duration, darkMode, rtl)
    if not description then
        print("^1[Error]: Description is required for the notification^0")
        return
    end
    TriggerEvent("peleg-notify:client:showCustomNotification", description, title, customColor, customIcon, duration, darkMode, rtl)
end)

exports("NotifyCustom", function(description, title, customColor, customIcon, duration, darkMode, rtl)
    if not description then
        print("^1[Error]: Description is required for the notification^0")
        return
    end
    TriggerEvent("peleg-notify:client:showCustomNotification", description, title, customColor, customIcon, duration, darkMode, rtl)
end)

-- Available notification types:
-- "success" - with check icon
-- "error" - with X icon
-- "warning" - with exclamation triangle icon
-- "info" - with info circle icon

-- RegisterCommand("notifytest", function()
--     TriggerEvent("peleg-notify:client:showNotification", "What ever you did just worked good for you.", "Success", "success", 5000, true, false)
--     TriggerEvent("peleg-notify:client:showNotification", "Dame you got an error", "Error", "error", 5000, true, false)
--     TriggerEvent("peleg-notify:client:showNotification", "Nah bro you doing something risky", "Warning", "warning", 5000, true, false)
--     TriggerEvent("peleg-notify:client:showNotification", "Here is some useful information", "Information", "info", 5000, true, false)

--     TriggerEvent("peleg-notify:client:showNotification", "וואלק אנחנו תומכים גם בעברית", "התראה", "info", 6000, true, true)

--     TriggerEvent(
--         "peleg-notify:client:showCustomNotification",
--         "POLICE: Something bad is happening",
--         "POLICE ALERT",
--         "#2563eb",
--         "fa-solid fa-shield-halved",
--         6000,
--         true,
--         false
--     )

--     TriggerEvent(
--         "peleg-notify:client:showCustomNotification",
--         "Server restart in 10 minutes. Fuck You boy",
--         "SERVER NOTICE",
--         "#8b5cf6",
--         "fa-solid fa-bullhorn",
--         7000,
--         true,
--         false
--     )
-- end, false)
