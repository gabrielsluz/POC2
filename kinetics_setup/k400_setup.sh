#Get to the shared folder
FOLDER_PATH="/datasets"
#Download csv files
wget https://storage.googleapis.com/deepmind-media/Datasets/kinetics400.tar.gz
tar -zxvf kinetics400.tar.gz

#Extract first lines and replace spaces for underlines
python extract_csv_header.py $FOLLDER_PATH/kinetics400/train.csv 20
python extract_csv_header.py $FOLLDER_PATH/kinetics400/test.csv 5
python extract_csv_header.py $FOLLDER_PATH/kinetics400/validate.csv 10

#Download the videos
mkdir $FOLLDER_PATH/kinetics
git clone https://github.com/gabrielsluz/kinetics-downloader.git
cd kinetics-downloader
pip install -r requirements.txt
python download.py $FOLLDER_PATH/kinetics400/trainhead.csv $FOLLDER_PATH/kinetics --trim
python download.py $FOLLDER_PATH/kinetics400/validatehead.csv $FOLLDER_PATH/kinetics --trim
python download.py $FOLLDER_PATH/kinetics400/testhead.csv $FOLLDER_PATH/kinetics --trim

#Modifies the videos according to SlowFast guidelines
cd ..
python sf_kinetics_setup.py
