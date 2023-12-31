#!/bin/bash
# LinuxGSM update_steamcmd.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Handles updating using SteamCMD.

moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"

# init steamcmd functions
core_steamcmd.sh

# The location where the builds are checked and downloaded.
remotelocation="SteamCMD"
check.sh
core_graceful.sh

fn_print_dots "${remotelocation}"

if [ "${forceupdate}" == "1" ]; then
	# forceupdate bypasses update checks.
	if [ "${status}" != "0" ] && [ -v "${status}" ]; then
		send_dc_notification "**🚀The Front Server has an Update available!🚀**\n\n⚠️Please stop any action and go to a safe place. The Server will be updated and restarted in **15 minutes.**⚠️\n\n📝Note: the servers savegame might lag 10 min behind, best if you go **NOW**, log out and come back in 15 min."
		sleep 300
        send_dc_notification "⚠️**Server Restart in 10 minutes!**⚠️"
        sleep 300
        send_dc_notification "⚠️**Server Restart in 5 minutes!**⚠️"
        sleep 240
        send_dc_notification "⚠️**Server Restart in 1 minute!**⚠️"
        sleep 60
		fn_print_restart_warning
		exitbypass=1
		command_stop.sh
		fn_firstcommand_reset
		date '+%s' > "${lockdir:?}/update.lock"
		fn_dl_steamcmd
		date +%s > "${lockdir}/last-updated.lock"
		exitbypass=1
		command_start.sh
		fn_firstcommand_reset
	else
		fn_dl_steamcmd
		date +%s > "${lockdir}/last-updated.lock"
	fi
else
	fn_update_steamcmd_localbuild
	fn_update_steamcmd_remotebuild
	fn_update_steamcmd_compare
fi
