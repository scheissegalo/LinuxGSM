#!/bin/bash
# LinuxGSM core_steamcmd.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Core modules for SteamCMD

moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"

# Send Notifications

send_dc_notification() {
    if [ "${shortname}" == "tf" ]; then
        #The front https://discord.com/api/webhooks/1182881544373801041/vDOsAffFfjVQJWW_muvjj5aakHwUI2EkBcUhnSpsBMLCBseVig_EdXDr5dzlOQ61WKq5
        WEBHOOK_URL="https://discord.com/api/webhooks/1182881544373801041/vDOsAffFfjVQJWW_muvjj5aakHwUI2EkBcUhnSpsBMLCBseVig_EdXDr5dzlOQ61WKq5"
    elif [ "${shortname}" == "sf" ]; then
        #Satisfactory
        WEBHOOK_URL="https://discord.com/api/webhooks/1196185066297102488/ZDVbiTBW2yc7FuzOsBzIj4NprfcCMVFZ-RszdjDtoaCPvkHY_FQvDYgiX3jL_p-Ps0ZL"
    fi
    # Check if a message and action are provided https://discord.com/api/webhooks/1191518298504970362/_LzRHOxyHns2zVXRYcTdsOCb0nGsJyvLX32PWcRMkbAbo8Sdn8gQSoxqCM7z8CvCoiy9
    #TestHook
    #WEBHOOK_URL="https://discord.com/api/webhooks/1191518298504970362/_LzRHOxyHns2zVXRYcTdsOCb0nGsJyvLX32PWcRMkbAbo8Sdn8gQSoxqCM7z8CvCoiy9"
    #LiveHook
    #WEBHOOK_URL="https://discord.com/api/webhooks/1182881544373801041/vDOsAffFfjVQJWW_muvjj5aakHwUI2EkBcUhnSpsBMLCBseVig_EdXDr5dzlOQ61WKq5"
    MESSAGE="$1"

    # Customize the bot's username and avatar
    BOT_USERNAME="NI-Server"
    BOT_AVATAR_URL="https://raw.githubusercontent.com/scheissegalo/LinuxGSM/master/lgsm/data/alert_discord_logo.png"

    # Send the formatted message to Discord
    curl -X POST -H "Content-Type: application/json" -d '{
        "content": "'"${MESSAGE}"'",
        "username": "'"${BOT_USERNAME}"'",
        "avatar_url": "'"${BOT_AVATAR_URL}"'"
    }' "$WEBHOOK_URL"

}

#send_dc_notification "The Front Server has an Update available!" "update"