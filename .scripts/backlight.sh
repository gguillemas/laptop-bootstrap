#!/bin/sh

BC=$(which bc)
BRIGHTNESS_PATH=$(ls /sys/class/backlight/*/brightness)
MAX_BRIGHTNESS_PATH=$(ls /sys/class/backlight/*/max_brightness)

usage () {
  echo "\
Usage: backlight.sh [options]
Options:
  =<percentage>  Set backlight brightness to percentage.
  +<percentage>  Increase backlight brightness by percentage.
  -<percentage>  Decrease backlight brightness by percentage.
  -get           Get current backlight brightness.\
"
}

percent () {
  echo "scale=1; $1/$(cat ${MAX_BRIGHTNESS_PATH})*100" | bc
}

absolute () {
  echo "scale=1; $1*$(cat ${MAX_BRIGHTNESS_PATH})/100" | bc
}

truncate () {
  printf %.0f $1
}

if [ $# -eq 0 ]; then
  usage
  exit 1
fi

for i in "$@"; do
  case $i in
    -h|--help)
      usage
      exit 0
      ;;
    -get)
      truncate $(percent $(cat ${BRIGHTNESS_PATH}))
      echo
      shift
      ;;
    =*)
      truncate $(absolute ${i#=}) > ${BRIGHTNESS_PATH}
      shift
      ;;
    +*)
      truncate $(echo $(cat ${BRIGHTNESS_PATH})+$(absolute ${i#+}) | ${BC}) > ${BRIGHTNESS_PATH}
      shift
      ;;
    -*)
      truncate $(echo $(cat ${BRIGHTNESS_PATH})-$(absolute ${i#-}) | ${BC}) > ${BRIGHTNESS_PATH}
      shift
      ;;
    *)	
      usage
      exit 1
  esac
done
