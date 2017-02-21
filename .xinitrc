xset -b
wmname LG3D
setxkbmap es
dual-screen.sh
~/.fehbg

while true; do
	TIME=$(date)
	TEMPERATURE="$(acpi -t | tail -1 | cut -d ' ' -f4,6)"
	BATTERY="$(acpi -b | head -1 | awk '{ print $4 " " $5 " " $3 }' | tr -d ',' | tr [a-z] [A-Z])"
	VOLUME="$(amixer get Master | tail -1 | cut -d ' ' -f7,8 | tr -d '[]' | tr [a-z] [A-Z])"
	xsetroot -name "TEMPERATURE: $TEMPERATURE | BATTERY: $BATTERY | VOLUME: $VOLUME | $TIME"
	sleep 10s
done &

while true; do
	dwm > /dev/null 2>&1
done
