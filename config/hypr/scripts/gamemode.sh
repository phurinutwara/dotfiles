#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
  hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword general:col.active_border rgb(11111C);\
        keyword general:col.inactive_border rgb(11111C);\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1;
        keyword decoration:inactive_opacity 1;
        "
  exit
fi
hyprctl reload
