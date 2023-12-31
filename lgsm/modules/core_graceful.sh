#!/bin/bash
# LinuxGSM core_steamcmd.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Core modules for SteamCMD

moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"

# Send Notifications

send_dc_notification() {
    # Check if a message and action are provided

    WEBHOOK_URL="https://discord.com/api/webhooks/1182881544373801041/vDOsAffFfjVQJWW_muvjj5aakHwUI2EkBcUhnSpsBMLCBseVig_EdXDr5dzlOQ61WKq5"
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

case "$ACTION" in
    "update")
        send_dc_notification "**🚀The Front Server has an Update available!🚀**\n\n⚠️Please stop any action and go to a safe place. The Server will be updated and restarted in **15 minutes.**⚠️\n\n📝Note: the servers savegame might lag 10 min behind, best if you go **NOW**, log out and come back in 15 min."
        sleep 300
        send_dc_notification "⚠️**Server Restart in 10 minutes!**⚠️"
        sleep 300
        send_dc_notification "⚠️**Server Restart in 5 minutes!**⚠️"
        sleep 240
        send_dc_notification "⚠️**Server Restart in 1 minute!**⚠️"
        sleep 60
        ;;
    "restart")
        send_dc_notification "**🚀A Restart for The Front Server is scheduled!🚀**\n\n⚠️Please stop any action and go to a safe place. The Server will be restarted in **15 minutes.**⚠️\n\n📝Note: the servers savegame might lag 10 min behind, best if you go **NOW**, log out and come back in 15 min."
        sleep 300
        send_dc_notification "⚠️**Server Restart in 10 minutes!**⚠️"
        sleep 300
        send_dc_notification "⚠️**Server Restart in 5 minutes!**⚠️"
        sleep 240
        send_dc_notification "⚠️**Server Restart in 1 minute!**⚠️"
        sleep 60
        ;;
    *)
        echo "Unknown action: $ACTION"
        return 1
        ;;
esac

