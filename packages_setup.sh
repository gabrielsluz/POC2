python3 -m pip install 'git+https://github.com/facebookresearch/fvcore'
python3 -m pip install simplejson
python3 -m pip install av
python3 -m pip install psutil
python3 -m pip install opencv-python
python3 -m pip install tensorboard
python3 -m pip install moviepy
python3 -m pip install matplotlib
python3 -m pip install -U cython
apt-get -y install python3-dev

python3 -m pip install -U 'git+https://github.com/facebookresearch/fvcore.git' 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
git clone https://github.com/facebookresearch/detectron2 detectron2_repo
python3 -m pip install -e detectron2_repo
python3 -m pip install scipy==1.4.1

apt -y install libgl1-mesa-glx
apt-get -y install libglib2.0-0

mkdir -p /datasets
