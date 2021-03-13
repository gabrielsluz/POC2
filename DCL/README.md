## How to run this code ?
Use a Singularity Container :)
Building the container:
- In the machine that has singularity,
- Installing all through the Singularity file was running out of memory, so it needs to installled in the sandbox mode. However, if enough memory is available use: 

- Plenty of memory:
git clone https://github.com/gabrielsluz/POC2.git
mkdir dcl
cd dcl
sudo singularity build --sandbox -F train_dcl ../POC2/DCL/Singularity


#Installation is done => go to the part in which we execute

- In vagrant:
sudo singularity shell -B shared_dir:/datasets train_dcl/
cd /datasets
git clone https://github.com/vacancy/Jacinle --recursive
export PATH=/datasets/Jacinle/bin:$PATH
git clone https://github.com/zfchenUnique/DCL-Release-Private.git --recursive

- In server:
singularity shell -B /srv/storage/datasets/gabrielsluz/:/datasets/ --nv /srv/storage/singularity/forge/gabrielsluz/dcl/train_dcl
git clone https://github.com/vacancy/Jacinle --recursive
export PATH=/home/gabrielsluz/Jacinle/bin:$PATH
git clone https://github.com/gabrielsluz/DCL-Release.git --recursive


## Test the installation:
python3
    import torch
    torch.cuda.get_device_name(0)

## Fast eval on server
git clone https://github.com/zfchenUnique/clevrer_dynamic_propnet.git
=> This repository does not exist

python3 scripts/script_gen_tube_proposals.py \
    --start_index 10000 \
    --end_index 15000 \
    --attr_w 0.6 \
    --match_thre 0.7 \
    --version 2 \
    --visualize_flag 0 \
    --tube_folder_path ../clevrer/tubeProposalsRelease \
    --use_attr_flag 0 \



# Reported errors:

- Coco must be sued from Jscinle, and it requires Cython for proper installation