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

    python3 -m pip install torch
    python3 -m pip install torchvision

    python3 -m pip install setuptools