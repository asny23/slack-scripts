#!/bin/sh
# requirements: sips command

# original file
SOURCE=''

# devided emojis filename will be DEST-n-m.DEST_EXT
DEST=''
DEST_EXT='png'

# size of devided emoji
CELL=128

# devided emojis for slack message
EMOJICODE=''

# for x in [1 129 257 385 513 641 769 897]
for x in 0 1 2 3 4 5 6 7
do
  OFFSET_X=$(expr $CELL \* $x + 1)
  # for y in [1 129 257 385 513 641 769 897]
  for y in 0 1 2 3 4 5 6 7
  do
    OFFSET_Y=$(expr $CELL \* $y + 1)
    # echo "OFFSET: $OFFSET_X $OFFSET_Y"
    sips -c $CELL $CELL --cropOffset $OFFSET_X $OFFSET_Y $SOURCE -o "$DEST-$(expr $x + 1)-$(expr $y + 1).$DEST_EXT"
    EMOJICODE=$EMOJICODE":$DEST-$(expr $x + 1)-$(expr $y + 1):"
  done
  EMOJICODE=$EMOJICODE"\n"
done

echo 'emoji code'
echo $EMOJICODE
