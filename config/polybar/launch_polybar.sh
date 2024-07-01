if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload pwarch &
  done
else
  polybar --reload pwarch &
fi
