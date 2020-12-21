#Get to the shared folder
FOLDER_PATH="/datasets"
#Download csv files
apt-get install wget
wget -P $FOLDER_PATH https://storage.googleapis.com/deepmind-media/Datasets/kinetics400.tar.gz
tar -zxvf $FOLDER_PATH/kinetics400.tar.gz

#Extract first lines and replace spaces for underlines
python3 extract_csv_header.py $FOLDER_PATH/kinetics400/train.csv 20
python3 extract_csv_header.py $FOLDER_PATH/kinetics400/test.csv 5
python3 extract_csv_header.py $FOLDER_PATH/kinetics400/validate.csv 10

#Download the videos
mkdir $FOLDER_PATH/kinetics
git clone https://github.com/gabrielsluz/kinetics-downloader.git
cd kinetics-downloader
python3 -m pip install -r requirements.txt
python3 download.py $FOLDER_PATH/kinetics400/trainhead.csv $FOLDER_PATH/kinetics --trim
python3 download.py $FOLDER_PATH/kinetics400/validatehead.csv $FOLDER_PATH/kinetics --trim
python3 download.py $FOLDER_PATH/kinetics400/testhead.csv $FOLDER_PATH/kinetics --trim

#Modifies the videos according to SlowFast guidelines
cd ..
python3 sf_kinetics_setup.py $FOLDER_PATH
