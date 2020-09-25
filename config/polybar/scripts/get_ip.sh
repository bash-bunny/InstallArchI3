#!/bin/sh

iface=$(ip link show | grep 'state UP' | awk '{print $2}' | tr -d :)
ip=$(ip a show $iface | grep -w inet | awk '{print $2}' | cut -d / -f1)
echo "%{F#2495e7} %{F#e2ee6a}$ip"
