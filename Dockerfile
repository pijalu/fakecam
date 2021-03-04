FROM tensorflow/tensorflow
ARG VIDEOPATH
ENV VIDEOPATH=/dev/video1

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -y \
	`# opencv requirements` \
  libsm6 libxext6 libxrender-dev \
  `# opencv video opening requirements` \
	libv4l-dev

RUN pip install --upgrade pip

# install our requirements
WORKDIR /

# install pyfakewebcam via pip
COPY requirements.txt /src/

RUN pip install --no-cache-dir -r /src/requirements.txt

# copy in the virtual background
COPY data/*.jpg /data/
COPY models/*.h5 /models/
# run our fake camera script (with unbuffered output for easier debug)

COPY fake.py /src/

ENTRYPOINT python -u /src/fake.py
