
FROM buildpack-deps:jessie

MAINTAINER rowellpica rowellpica@gmail.com

# working directory
WORKDIR /root

# addons
RUN \
	apt-get install -y \
	wget

# build repo
RUN \
	git clone https://github.com/pjreddie/darknet && \
	cd darknet && \
	make

# download weights full (accurate most) and tiny (faster , less accurate) models
# darknet rnns
RUN \ 
	wget http://pjreddie.com/media/files/yolo.weights >/dev/null 2>&1 && \
	wget http://pjreddie.com/media/files/tiny-yolo-voc.weights >/dev/null 2>&1
	
# test executable
RUN \	
	cd darknet/ && \
	./darknet && \
# test yolo
	./darknet detector test cfg/coco.data cfg/yolo.cfg /root/yolo.weights data/dog.jpg

# defaults command
CMD ["bash"]