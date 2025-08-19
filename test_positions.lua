-- Test file to demonstrate notification positions
-- Uncomment the lines below to test different positions

-- Test different positions
-- exports['peleg-notify']:notify("This is a top-right notification", "Top Right", "success", 5000, true, false, "top-right")
-- exports['peleg-notify']:notify("This is a top-left notification", "Top Left", "error", 5000, true, false, "top-left")
-- exports['peleg-notify']:notify("This is a top-center notification", "Top Center", "warning", 5000, true, false, "top-center")
-- exports['peleg-notify']:notify("This is a bottom-right notification", "Bottom Right", "info", 5000, true, false, "bottom-right")
-- exports['peleg-notify']:notify("This is a bottom-left notification", "Bottom Left", "success", 5000, true, false, "bottom-left")
-- exports['peleg-notify']:notify("This is a bottom-center notification", "Bottom Center", "error", 5000, true, false, "bottom-center")
-- exports['peleg-notify']:notify("This is a center notification", "Center", "warning", 5000, true, false, "center")

-- Test custom notifications with positions
-- exports['peleg-notify']:notifyCustom("Custom notification in top-center", "Custom", "#ff6b6b", "fa-solid fa-star", 5000, true, false, "top-center")
-- exports['peleg-notify']:notifyCustom("Custom notification in bottom-left", "Custom", "#4ecdc4", "fa-solid fa-heart", 5000, true, false, "bottom-left")

-- Available positions:
-- "top-right" (default)
-- "top-left"
-- "top-center"
-- "bottom-right"
-- "bottom-left"
-- "bottom-center"
-- "center"

-- Usage examples:
-- exports['peleg-notify']:notify(description, title, type, duration, darkMode, rtl, position)
-- exports['peleg-notify']:notifyCustom(description, title, customColor, customIcon, duration, darkMode, rtl, position)
