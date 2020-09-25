#!/bin/bash
export SXHKD_SHELL='/usr/bin/sh'
sxhkd &
exec bspwm &
picom --config $HOME/.config/bspwm/picom.conf &
