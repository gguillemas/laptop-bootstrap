#!/bin/bash
xwd | xwdtopnm | pnmtopng > ~/pictures/windowshot_$(date +%Y%m%d_%H%M%S).png
