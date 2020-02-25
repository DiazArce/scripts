#!/bin/bash

if [ -z $1 ]
then
	echo "Enter version yolo: yolov3 or tiny"
else

	git clone https://github.com/AlexeyAB/darknet.git
	git clone https://github.com/DiazArce/data.git
	cp -r ~/data/* ~/darknet/data/
	cd ~/darknet
	gpu=1
	opencv=1
	sed -i -e "s/\(GPU=\).*/\1$gpu/" \-e "s/\(OPENCV=\).*/\1$opencv/" ~/darknet/Makefile
	sudo ldconfig
	make
	if [ $1 = "yolov3" ]
	then
  		wget https://pjreddie.com/media/files/darknet53.conv.74
  		./darknet detector train data/obj.data yolo-obj.cfg darknet53.conv.74 -dont_show
	else
  		wget https://pjreddie.com/media/files/yolov3-tiny.weights
  		./darknet partial cfg/yolov3-tiny.cfg yolov3-tiny.weights yolov3-tiny.conv.15 15
  		./darknet detector train data/obj.data data/yolov3-tiny-obj.cfg yolov3-tiny.conv.15 -dont_show
	fi
fi



