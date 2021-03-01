## How to run this code ?
Use a Singularity Container :)
Building the container:
- In the machine which has singularity,
- Intalling all through the Singularity file was running out of memory, so it needs to installled in the sandbox mode. However, if enough memory is available use: 

- Plenty of memory:
git clone https://github.com/gabrielsluz/POC2.git
mkdir train_sf
cd train_sf
sudo singularity build --sandbox -F train_sf ../POC2/FullSingularity

sudo singularity shell --writable train_sf
git clone https://github.com/gabrielsluz/SlowFast.git
export PYTHONPATH=/home/gabrielsluz/SlowFast/slowfast:$PYTHONPATH
cd SlowFast
python3 setup.py build develop

- Low memory:
git clone https://github.com/gabrielsluz/POC2.git
mkdir train_sf
cd train_sf
sudo singularity build --sandbox -F train_sf ../POC2/Singularity
chmod +x ../POC2/packages_setup.sh

sudo singularity shell --writable train_sf
./POC2/packages_setup.sh 

git clone https://github.com/gabrielsluz/SlowFast.git
export PYTHONPATH=/home/gabrielsluz/SlowFast/slowfast:$PYTHONPATH
cd SlowFast
python3 setup.py build develop

SlowFast should be working now.

## How to setup the Kinetics dataset
The kinetics_setup does it all.
The script install some packages, therefore it is advisable to use inside the
singularity machine: 

sudo singularity shell -B shared_dir:/datasets train_sf/
git clone https://github.com/gabrielsluz/POC2.git
chmod +x POC2/kinetics_setup/k400_setup.sh
cd POC2/kinetics_setup
./k400_setup.sh


## Test the installation:
sudo singularity shell -B shared_dir:/datasets train_sf/

cd SlowFast

python3 tools/run_net.py \
  --cfg configs/Kinetics/C2D_8x8_R50.yaml \
  DATA.PATH_TO_DATA_DIR /datasets/kinetics/ \
  NUM_GPUS 0 \
  TRAIN.BATCH_SIZE 2 \
  SOLVER.MAX_EPOCH 1

Linear model:

rm ./checkpoints/checkpoint_epoch_00001.pyth #Remove checkpoint

python3 tools/run_net.py \
  --cfg configs/demo/linear.yaml \
  DATA.PATH_TO_DATA_DIR /datasets/kinetics/ \
  NUM_GPUS 0 \
  TRAIN.BATCH_SIZE 2 \
  SOLVER.MAX_EPOCH 1

### Test Clevrer Frames dataset

python3 clevrer_dev/test_dataset.py \
  --cfg clevrer_dev/clevrer_frame.yaml \
  DATA.PATH_TO_DATA_DIR /datasets/clevrer_dummy \
  DATA.PATH_PREFIX /datasets/clevrer_dummy \
  NUM_GPUS 0 \
  TRAIN.BATCH_SIZE 3 \
  SOLVER.MAX_EPOCH 1

### Run on MONet on Clevrer Frames
python3 clevrer_dev/monet/run_net.py \
  --cfg clevrer_dev/monet/monet.yaml \
  DATA.PATH_TO_DATA_DIR /datasets/clevrer \
  DATA.PATH_PREFIX /datasets/clevrer \
  NUM_GPUS 1 \
  TRAIN.BATCH_SIZE 3 \
  SOLVER.MAX_EPOCH 1


## Training

### Training on server

singularity shell -B /srv/storage/datasets/gabrielsluz/:/datasets/ --nv /srv/storage/singularity/forge/gabrielsluz/train_sf/train_sf
ulimit -v <value>

Temporary: 
export PYTHONPATH=/home/gabrielsluz/SlowFast/slowfast:$PYTHONPATH
cd /usr/local/lib/python3.6/dist-packages/
find . -type f -name "*.pyc"
find . -name "*.pyc" -type f -delete


### Train MONet on Clevrer Frames

python3 clevrer_dev/monet/run_net.py \
  --cfg clevrer_dev/monet/monet.yaml \
  DATA.PATH_TO_DATA_DIR /datasets/clevrer \
  DATA.PATH_PREFIX /datasets/clevrer \
  NUM_GPUS 1 \
  LOG_PERIOD 50 \
  TRAIN.BATCH_SIZE 32 \
  TRAIN.EVAL_PERIOD 20 \
  TRAIN.CHECKPOINT_PERIOD 20 \
  TRAIN.CHECKPOINT_FILE_PATH ./monet_checkpoints/checkpoint_epoch_00140.pyth \
  SOLVER.MAX_EPOCH 200



### Train Clevrer 

python3 clevrer_dev/clevrer/run_net.py \
  --cfg clevrer_dev/clevrer/clevrer.yaml \
  DATA.PATH_TO_DATA_DIR /datasets/clevrer_dummy \
  DATA.PATH_PREFIX /datasets/clevrer_dummy \
  MONET.CHECKPOINT_LOAD /datasets/checkpoint_epoch_00020.pyth \
  NUM_GPUS 0 \
  LOG_PERIOD 1 \
  TRAIN.BATCH_SIZE 4 \
  TRAIN.EVAL_PERIOD 1 \
  TRAIN.CHECKPOINT_PERIOD 1 \
  SOLVER.MAX_EPOCH 1


### Errors on the server
ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
detectron2 0.3 requires pycocotools>=2.0.2, but you have pycocotools 2.0 which is incompatible.
*Ignored

NVIDIA CUDA:

UserWarning: CUDA initialization: The NVIDIA driver on your system is too old (found version 9010). Please update your GPU driver by downloading and installing a new version from the URL: http://www.nvidia.com/Download/index.aspx Alternatively, go to: https://pytorch.org to install a PyTorch version that has been compiled with your version of the CUDA driver. (Triggered internally at  /pytorch/c10/cuda/CUDAFunctions.cpp:100.)

nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2019 NVIDIA Corporation
Built on Sun_Jul_28_19:07:16_PDT_2019
Cuda compilation tools, release 10.1, V10.1.243
Singularity train_sf:~/SlowFast> 

https://docs.nvidia.com/deploy/cuda-compatibility/index.html

Driver of the GPU is too old for CUDA
Needs CUDA 9.0 (9.0.76) at max
However, POC1 used the same cuda: Bootstrap: docker
From: nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
Maybe it is proc2 GPU that is outdated

It is a pytorch version problem => let's downgrade it