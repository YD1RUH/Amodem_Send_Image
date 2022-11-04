clear
ls -la /dev/ttyUSB*
echo ""
read -p "choose port COM detected                 : " port
read -p "input BITRATE will be used (2,4,8,or 16) : " bit
xterm -e "rigctld -m 1 -p $port -t 4532 -P RTS -vvvvv" &
xterm -e "sleep 0.5; rigctl -m 2 -r localhost:4532 T 1" &
export BITRATE=$bit
while true
do
	read -p "Drag n Drop the image to this terminal: " img
	cat $img | ./amodem send -o img.pcm
	sox --type=raw --bits=16 --channels=1 --encoding=signed-integer --rate=8000 --endian=little img.pcm img.wav
	rigctl -m 2 -r localhost:4532 T 0
	play img.wav
	rigctl -m 2 -r localhost:4532 T 1
	rm img.*
done
