xset -b
wmname LG3D
setxkbmap es
screen-auto.sh
~/.fehbg

while true; do
	TIME=$(date)
	TEMP="$(acpi -t | tail -1 | cut -d ' ' -f4,6)"
	BAT="$(acpi -b | head -1 | awk '{ print $4 " " $5 " " $3 }' | tr -d ',' | tr [a-z] [A-Z])"
	VOL="$(amixer get Master | tail -1 | cut -d ' ' -f7,8 | tr -d '[]' | tr [a-z] [A-Z])"
	xsetroot -name "TEMP: $TEMP | BAT: $BAT | VOL: $VOL | $TIME"
	sleep 10s
done &

# Sync clipboard contents to primary selection.
autocutsel -s CLIPBOARD -f

while true; do
	dwm > /dev/null 2>&1
done
