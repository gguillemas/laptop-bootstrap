#!/bin/bash
xwd -root | xwdtopnm | pnmtopng > ~/pictures/screenshot_$(date +%Y%m%d_%H%M%S).png
