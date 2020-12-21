#Get to the shared folder
cd /datasets
#Download csv files
wget https://storage.googleapis.com/deepmind-media/Datasets/kinetics400.tar.gz
tar -zxvf kinetics400.tar.gz

#Extract first lines and replace spaces for underlines
python extract_csv_header.py kinetics400/train.csv 20
python extract_csv_header.py kinetics400/test.csv 5
python extract_csv_header.py kinetics400/validate.csv 10

#Download the videos
mkdir kinetics
git clone https://github.com/gabrielsluz/kinetics-downloader.git
cd kinetics-downloader
pip install -r requirements.txt
python download.py ../kinetics400/trainhead.csv ../kinetics --trim
python download.py ../kinetics400/validatehead.csv ../kinetics --trim
python download.py ../kinetics400/testhead.csv ../kinetics --trim

#Modifies the videos according to SlowFast guidelines
cd ..
python sf_kinetics_setup.py
