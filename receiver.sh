clear
read -p "input bitrate: " bit
export BITRATE=$bit
while true
do
	clear
	./amodem recv -vv -o recv.png
        tgl=$(date "+%Y-%m-%d_%T")
	mv recv.png $tgl.png
	chk=$(wc -c < $tgl.png)
	if [ $chk = "0" ]
		then
			rm $tgl.png
	fi
	mv $tgl.png recv/
done
