Bootstrap: docker
From: nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

%post
    apt-get update && apt-get install -y --no-install-recommends \
    python3.6 \
    python3-pip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

    pip3 install --upgrade pip

    apt-get update -y
    apt-get install -y git

    python3 -m pip install torchvision==0.8.1+cu101
    python3 -m pip install torch==1.7.0+cu101
    
    python3 -m pip install 'git+https://github.com/facebookresearch/fvcore'
    python3 -m pip install simplejson
    python3 -m pip install av
    python3 -m pip install psutil
    python3 -m pip install opencv-python
    python3 -m pip install tensorboard
    python3 -m pip install moviepy

    python3 -m pip install -U cython
    python3 -m pip install -U 'git+https://github.com/facebookresearch/fvcore.git' 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
    git clone https://github.com/facebookresearch/detectron2 detectron2_repo
    python3 -m pip install -e detectron2_repo

    mkdir -p datasets