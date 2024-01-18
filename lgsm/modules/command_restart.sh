#!/bin/bash
# LinuxGSM command_restart.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Restarts the server.

commandname="RESTART"
commandaction="Restarting"
moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"
fn_firstcommand_set
core_graceful.sh

if [ "${shortname}" == "tf" ]; then
    send_dc_notification "**🚀A Restart for The Front Server is scheduled!🚀**\n\n⚠️Please stop any action and go to a safe place. The Server will be restarted in **15 minutes.**⚠️\n\n📝Note: the servers savegame might lag 10 min behind, best if you go **NOW**, log out and come back in 15 min."
    sleep 300
    send_dc_notification "⚠️**Server Restart in 10 minutes!**⚠️"
    sleep 300
    send_dc_notification "⚠️**Server Restart in 5 minutes!**⚠️"
    sleep 240
    send_dc_notification "⚠️**Server Restart in 1 minute!**⚠️"
    sleep 60
elif [ "${shortname}" == "sf" ]; then
    send_dc_notification "**🚀A Restart for The Satisfactory Server is scheduled!🚀**\n\n⚠️Please stop any action and go to a safe place. The Server will be restarted in **30 sec.**⚠️"
    sleep 30
fi
info_game.sh
exitbypass=1
command_stop.sh
command_start.sh
fn_firstcommand_reset
core_exit.sh
