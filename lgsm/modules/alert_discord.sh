#!/bin/bash
# LinuxGSM alert_discord.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Sends Discord alert.

moduleselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"

jsoninfo=$(
	cat << EOF
{
    "username": "NI-Server",
    "avatar_url": "https://raw.githubusercontent.com/${githubuser}/${githubrepo}/${githubbranch}/lgsm/data/alert_discord_logo.png",
    "file": "content",
    "embeds": [
        {
            "author": {
                "name": "NI-Server Alert",
                "url": "",
                "icon_url": "https://raw.githubusercontent.com/${githubuser}/${githubrepo}/${githubbranch}/lgsm/data/alert_discord_logo.png"
            },
            "title": "${alerttitle}",
            "url": "",
            "description": "",
            "color": "${alertcolourdec}",
            "type": "content",
            "thumbnail": {
                "url": "${alerticon}"
            },
            "fields": [
				{
					"name": "Server Name",
					"value": "${servername}"
				},
				{
					"name": "Information",
					"value": "${alertmessage}"
				},
                {
                    "name": "Game",
                    "value": "${gamename}",
                    "inline": true
                },
                {
                    "name": "Server IP",
                    "value": "\`${alertip}:${port}\`",
                    "inline": true
                },
                {
                    "name": "Hostname",
                    "value": "${HOSTNAME}",
                    "inline": true
                },
				{
					"name": "More info",
					"value": "${alerturl}",
					"inline": true
				},
                {
                    "name": "Server Time",
                    "value": "$(date)",
                    "inline": true
                }
            ],
            "footer": {
				"icon_url": "https://raw.githubusercontent.com/${githubuser}/${githubrepo}/${githubbranch}/lgsm/data/alert_discord_logo.png",
                "text": "Sent by NI-Server ${version}"
            }
        }
    ]
}
EOF
)

jsonnoinfo=$(
	cat << EOF
{
    "username": "NI-Server",
    "avatar_url": "https://raw.githubusercontent.com/${githubuser}/${githubrepo}/${githubbranch}/lgsm/data/alert_discord_logo.png",
    "file": "content",
    "embeds": [
        {
            "author": {
                "name": "NI-Server Alert",
                "url": "",
                "icon_url": "https://raw.githubusercontent.com/${githubuser}/${githubrepo}/${githubbranch}/lgsm/data/alert_discord_logo.png"
            },
            "title": "${alerttitle}",
            "url": "",
            "description": "",
            "color": "${alertcolourdec}",
            "type": "content",
            "thumbnail": {
                "url": "${alerticon}"
            },
            "fields": [
				{
					"name": "Server Name",
					"value": "${servername}"
				},
				{
					"name": "Information",
					"value": "${alertmessage}"
				},
                {
                    "name": "Game",
                    "value": "${gamename}",
                    "inline": true
                },
                {
                    "name": "Server IP",
                    "value": "\`${alertip}:${port}\`",
                    "inline": true
                },
                {
                    "name": "Hostname",
                    "value": "${HOSTNAME}",
                    "inline": true
                },
                {
                    "name": "Server Time",
                    "value": "$(date)",
                    "inline": true
                }
            ],
            "footer": {
				"icon_url": "https://raw.githubusercontent.com/${githubuser}/${githubrepo}/${githubbranch}/lgsm/data/alert_discord_logo.png",
                "text": "Sent by NI-Server ${version}"
            }
        }
    ]
}
EOF
)

fn_print_dots "Sending Discord alert"

if [ -z "${alerturl}" ]; then
	json="${jsonnoinfo}"
else
	json="${jsoninfo}"
fi

discordsend=$(curl --connect-timeout 10 -sSL -H "Content-Type: application/json" -X POST -d "$(echo -n "${json}" | jq -c .)" "${discordwebhook}")

if [ -n "${discordsend}" ]; then
	fn_print_fail_nl "Sending Discord alert: ${discordsend}"
	fn_script_log_fail "Sending Discord alert: ${discordsend}"
else
	fn_print_ok_nl "Sending Discord alert"
	fn_script_log_pass "Sending Discord alert"
fi
