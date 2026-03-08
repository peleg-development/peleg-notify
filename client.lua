local defaults = {
    title = 'Notification',
    type = 'info',
    duration = 5000,
    darkMode = true,
    rtl = false,
    position = 'top-right',
}

local validTypes = {
    success = true,
    error = true,
    warning = true,
    info = true,
}

local validPositions = {
    ['top-right'] = true,
    ['top-left'] = true,
    ['top-center'] = true,
    ['bottom-right'] = true,
    ['bottom-left'] = true,
    ['bottom-center'] = true,
    center = true,
}

local function warn(message)
    print(('[%s] %s'):format(GetCurrentResourceName(), message))
end

local function trim(value)
    if type(value) ~= 'string' then
        return nil
    end

    local result = value:gsub('^%s+', ''):gsub('%s+$', '')
    return result ~= '' and result or nil
end

local function getType(value)
    if type(value) ~= 'string' then
        return defaults.type
    end

    value = value:lower()
    return validTypes[value] and value or defaults.type
end

local function getPosition(value)
    if type(value) ~= 'string' then
        return defaults.position
    end

    value = value:lower()
    return validPositions[value] and value or defaults.position
end

local function getDuration(value)
    value = tonumber(value)

    if not value then
        return defaults.duration
    end

    value = math.floor(value)

    if value < 500 then
        return 500
    end

    if value > 60000 then
        return 60000
    end

    return value
end

local function getBoolean(value, fallback)
    if type(value) == 'boolean' then
        return value
    end

    return fallback
end

local function isHexColor(value)
    if type(value) ~= 'string' then
        return false
    end

    return value:match('^#%x%x%x$') ~= nil
        or value:match('^#%x%x%x%x%x%x$') ~= nil
        or value:match('^#%x%x%x%x%x%x%x%x$') ~= nil
end

local function sendNotification(data)
    local description = trim(data.description)

    if not description then
        warn('description is required for the notification')
        return false
    end

    SendNUIMessage({
        action = data.action,
        title = trim(data.title) or defaults.title,
        type = data.type,
        description = description,
        duration = getDuration(data.duration),
        darkMode = getBoolean(data.darkMode, defaults.darkMode),
        rtl = getBoolean(data.rtl, defaults.rtl),
        position = getPosition(data.position),
        customColor = data.customColor,
        customIcon = data.customIcon,
    })

    return true
end

local function showNotification(description, title, notificationType, duration, darkMode, rtl, position)
    return sendNotification({
        action = 'showNotification',
        description = description,
        title = title,
        type = getType(notificationType),
        duration = duration,
        darkMode = darkMode,
        rtl = rtl,
        position = position,
    })
end

local function showCustomNotification(description, title, customColor, customIcon, duration, darkMode, rtl, position)
    customColor = trim(customColor)
    customIcon = trim(customIcon)

    if not customColor or not isHexColor(customColor) then
        warn('customColor must be a valid hex color')
        return false
    end

    if not customIcon then
        warn('customIcon is required for custom notifications')
        return false
    end

    return sendNotification({
        action = 'showCustomNotification',
        description = description,
        title = title,
        type = 'custom',
        duration = duration,
        darkMode = darkMode,
        rtl = rtl,
        position = position,
        customColor = customColor,
        customIcon = customIcon,
    })
end

RegisterNetEvent('peleg-notify:client:showNotification', function(description, title, notificationType, duration, darkMode, rtl, position)
    showNotification(description, title, notificationType, duration, darkMode, rtl, position)
end)

RegisterNetEvent('peleg-notify:client:showCustomNotification', function(description, title, customColor, customIcon, duration, darkMode, rtl, position)
    showCustomNotification(description, title, customColor, customIcon, duration, darkMode, rtl, position)
end)

exports('notify', showNotification)
exports('Notify', showNotification)
exports('notifyCustom', showCustomNotification)
exports('NotifyCustom', showCustomNotification)
