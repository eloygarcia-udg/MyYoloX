# FROM nvidia/cuda:12.0.0-devel-ubuntu22.04
FROM nvidia/cuda:13.1.0-devel-ubuntu24.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
# RUN apt-get install -y tzdata
LABEL authors="eloygarcia"

# ENTRYPOINT ["top", "-b"]
RUN set -ex
RUN apt-get update
RUN apt-get install -y g++ curl libzmq3-dev wget git
RUN apt-get install -y libx11-dev libxt-dev xserver-xorg-dev xorg-dev
RUN apt-get install -y ffmpeg libsm6 libxext6
RUN apt-get install -y libgl1-mesa-dev libssl-dev

RUN apt-get install -y software-properties-common

RUN apt-get install -y python3-pip
#RUN apt-get -y install libopenjp2-7-dev libopenjp2-tools openslide-tools libpixman-1-dev # | tail -n 1
#RUN pip install histoencoder | tail -n 1
#RUN pip install git+https://github.com/TissueImageAnalytics/tiatoolbox.git@develop #  | tail -n 1
#RUN echo "Installation is done."

RUN apt-get install -y libjpeg-dev
# RUN apt install -y  pipx
RUN python3 -m pip config set global.break-system-packages true

# TensorRT
# https://pypi.org/project/tensorrt/
# Metapackage for NVIDIA TensorRT, which is an SDK that facilitates high-performance machine learning inference. It is designed to work in a complementary fashion with training frameworks such as TensorFlow, PyTorch, and MXNet. It focuses specifically on running an already-trained network quickly and efficiently on NVIDIA hardware.
# If the dependencies of this package cannot be correctly installed from PyPI for any reason, you can try using the NVIDIA package index instead:
# RUN export NVIDIA_TENSORRT_DISABLE_INTERNAL_PIP=0
RUN pip install tensorrt
RUN pip install pandas

COPY requirements.txt ./home/
RUN pip install -r ./home/requirements.txt

# Torch2trt
RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt.git ./home/torch2trt
RUN python3 ./home/torch2trt/setup.py install

# YOLOX dependencies
# RUN git clone https://github.com/Megvii-BaseDetection/YOLOX.git ./home/YOLOX
# RUN pip install -v -e .  # or 
# RUN python3 ./home/YOLOX/setup.py develop

