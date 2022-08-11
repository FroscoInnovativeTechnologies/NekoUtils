#!usr/bin/sh

. "${HOME}/.Neko_Var"

rm -f /tmp/*_scrot*.png

scrot -sfbe 'mv -f $f /tmp/' -l style=dash,width=3,color="#2be491"

for CURRENT in /tmp/*_scrot*.png; do
        CURRENT="$(echo "$CURRENT" | grep -oP '/tmp/\K[^.png]+')"
done

convert "/tmp/${CURRENT}.png" \( +clone -alpha extract -draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
\( +clone -flip \) -compose Multiply -composite \( +clone -flop \) -compose Multiply -composite \) -alpha off \
-compose CopyOpacity -composite "/tmp/${CURRENT}-rounded.png" && rm -f "/tmp/${CURRENT}.png"
convert "/tmp/${CURRENT}-rounded.png" \( +clone -background black \
-shadow "${FRAMED_SHADOW_OPACITY:-25}x${FRAME_PADDING:-10}+0+$((${FRAME_PADDING:-10}-5))" \) +swap \
-background none -layers merge +repage "/tmp/${CURRENT}-shadow.png" && rm -f "/tmp/${CURRENT}-rounded.png"
convert "/tmp/${CURRENT}-shadow.png" -bordercolor "$FRAME_COLOR" \
-border 5 "/tmp/${CURRENT}.png" && rm -f "/tmp/${CURRENT}-shadow.png"

xclip -selection clipboard -target image/png -i "/tmp/${CURRENT}.png"

mv -f "/tmp/${CURRENT}.png" "${HOME}/Pictures/scrot/"
