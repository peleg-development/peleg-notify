fx_version 'cerulean'

game 'gta5'
author 'Peleg'
description 'Modern FiveM Notification System'
version '2.0.0'

ui_page 'Nui/index.html'

files {
    'Nui/index.html',
    'Nui/styles.css',
    'Nui/app.js',
    'Nui/sound.mp3'
}

client_scripts {
    'client.lua'
}

export 'notify'
export 'Notify'
export 'notifyCustom'
export 'NotifyCustom'
