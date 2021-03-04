#!/bin/bash

sudo modprobe -r v4l2loopback
sudo modprobe v4l2loopback devices=1 video_nr=20 card_label="v4l2loopback" exclusive_caps=1

docker run  \
	--rm \
  --name=fakecam \
  -p 8080:8080 \
  -u 1000:39 \
  $(find /dev -name 'video*' -printf "--device %p ") \
  fakecam

