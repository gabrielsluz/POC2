### How to run this code ?
Use a Singularity Container :)
Building the container:
- In the machine which has singularity,
- Intalling all through the Singularity file was running out of memory, so it needs to installled in the sandbox mode

git clone https://github.com/gabrielsluz/POC2.git
mkdir train_sf
cd train_sf
sudo singularity build --sandbox train_sf ../POC2/Singularity
chmod +x POC2/packages_setup.sh

sudo singularity shell --writable train_sf
./POC2/packages_setup.sh 

git clone https://github.com/gabrielsluz/SlowFast.git
export PYTHONPATH=/SlowFast/slowfast:$PYTHONPATH
cd SlowFast
python3 setup.py build develop

SlowFast should be working now.

### How to setup the Kinetics dataset
The kinetics_setup does it all.
The script install some packages, therefore it is advisable to use inside the
singularity machine: 

sudo singularity shell -B shared_dir:/datasets train_sf/
git clone https://github.com/gabrielsluz/POC2.git
chmod +x POC2/kinetics_setup/k400_setup.sh
cd POC2/kinetics_setup
./k400_setup.sh


### Test the installation:
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
  DATA.PATH_TO_DATA_DIR /datasets/clevrer_dummy \
  DATA.PATH_PREFIX /datasets/clevrer_dummy \
  NUM_GPUS 0 \
  TRAIN.BATCH_SIZE 3 \
  SOLVER.MAX_EPOCH 1