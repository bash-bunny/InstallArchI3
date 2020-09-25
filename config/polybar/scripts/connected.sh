#!/usr/bin/sh

wifi=$(nmcli | grep -i connected | cut -d ' ' -f4-)

if [ ! -z "$wifi" ]
then
    echo "%{F#cc0433} $wifi%{F#e2ee6a}"
else
    echo "%{F#07dbcd} %{F#e2ee6a}"
fi
