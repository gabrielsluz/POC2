### How to run this code ?
Use a Singularity Container :)
Building the container:
- In the machine which has singularity,

git clone https://github.com/gabrielsluz/POC2.git
mkdir train_sf
cd train_sf
sudo singularity build --sandbox train_sf ../POC2/Singularity

sudo singularity shell --writable train_sf

git clone https://github.com/gabrielsluz/SlowFast.git
export PYTHONPATH=/content/SlowFast:$PYTHONPATH
cd SlowFast
python3 setup.py build develop

SlowFast should be working now.

### How to setup the Kinetics dataset
The k400_setup.sh script does it all.
The script install some packages, therefore it is advisable to use inside the
singularity machine: 

sudo singularity shell -B shared_dir:/datasets train_sf/
git clone https://github.com/gabrielsluz/POC2.git
chmod +x /POC2/

