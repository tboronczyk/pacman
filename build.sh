#! /bin/bash

set -e

ORIG="Pac-Man (USA) (Namco).nes"
ROM="pacman-eo.nes"
IPS="pacman-eo.ips"
FLIPS="wine /opt/floating/flips.exe"

echo "GENERATING ROM AND IPS FROM $ORIG..."
cp "$ORIG" "$ROM"

# thank you Her-Saki
$FLIPS -a pacman-es.ips "$ORIG" "$ROM"

echo "Updating PRG..."
dd if=prg/header2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x03C0))
dd if=prg/character.bin of="$ROM" conv=notrunc bs=1 seek=$((0x06AB))
dd if=prg/bashful.bin of="$ROM" conv=notrunc bs=1 seek=$((0x06EE))
dd if=prg/10pts.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0717))
dd if=prg/50pts.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0722))
dd if=prg/header1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x34B0))
dd if=prg/player1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x34C8))
dd if=prg/player2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x34D4))
dd if=prg/licensed.bin of="$ROM" conv=notrunc bs=1 seek=$((0x3515))
dd if=prg/hiscore.bin of="$ROM" conv=notrunc bs=1 seek=$((0x254C))
dd if=prg/p1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x1114))
dd if=prg/p1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x255B))
dd if=prg/p2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x111D))
dd if=prg/p2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x2561))
dd if=prg/ready.bin of="$ROM" conv=notrunc bs=1 seek=$((0x3550))
dd if=prg/gameover.bin of="$ROM" conv=notrunc bs=1 seek=$((0x3580))
dd if=prg/spacefix.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0EF9))
dd if=prg/playeronetwo.bin of="$ROM" conv=notrunc bs=1 seek=$((0x3557))
dd if=prg/playeronetwo.bin of="$ROM" conv=notrunc bs=1 seek=$((0x3588))

# PAUSE -> PAUxZITA
# length counters
dd if=prg/0B23.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0B23)) # LDX #$06
dd if=prg/0B3A.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0B3A)) # CPY #$06
dd if=prg/0B32.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0B32)) # LDA pausetxt, X
dd if=prg/pausetxt.bin of="$ROM" conv=notrunc bs=1 seek=$((0x35B0))

echo "Updating CHR..."
dd if=chr/ux.bin of="$ROM" conv=notrunc bs=1 seek=$((0x4520))
dd if=chr/titletext1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x4B10))
dd if=chr/titletext2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x4C10))
dd if=chr/blank.bin of="$ROM" conv=notrunc bs=1 seek=$((0x4ED0))
dd if=chr/gametext.bin of="$ROM" conv=notrunc bs=1 seek=$((0x5B10))

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
