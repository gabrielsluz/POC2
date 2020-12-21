import subprocess
import os
import sys

#Modified from: https://github.com/facebookresearch/video-nonlocal-net/blob/master/process_data/kinetics/downscale_video_joblib.py
def downscale_clip(video_path):
  status = False
  inname = '"' + video_path + '"'
  outname = '"'+ video_path[:-4] + 'out.mp4"'
  command = "ffmpeg  -loglevel panic -i {} -filter:v scale=\"trunc(oh*a/2)*2:256\" -q:v 1 -c:a copy {}".format( inname, outname)
  try:
    print("Starting -- " + video_path)
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    output = subprocess.check_output("mv {} {}".format(outname, inname), shell=True, stderr=subprocess.STDOUT)
    print("Done -- " + video_path)
  except subprocess.CalledProcessError as err:
    print("Erro --" + str(err))
    return status, err.output

  status = True
  return status, 'Downscaled'

#SlowFast requires the labels to be integeres. Therefore, we need to store the labels and the integers
#Generates a dictionary of label to int
#Input => List of files in the Kinetics format
#It returns a dictionary containing and writes on a file
def gen_label_file(file_list, output_file):
  label_dict = {}
  cnt = 0
  for file_path in file_list:
    f = open(file_path, "r")
    for line in f:
      line_split = line.split(',')
      if line_split[0] == 'label':
        continue
      label = line_split[0]
      if not label in label_dict:
        label_dict[label] = str(cnt)
        cnt += 1
    f.close()

  output_file = open(output_file, "w")
  for key in label_dict.keys():
    output_file.write(key + " " + label_dict[key] + "\n")
  output_file.close()
  return label_dict

#Modifies the videos and generates the csv files from the old ones
def prepare_dataset(dataset_path, csv_file, out_file, label_dict):
  input_file = open(csv_file, "r")
  output_file = open(out_file, "w")
  for line in input_file:
    line_split = line.split(',')
    if line_split[0] == 'label':
      continue
    label = line_split[0]
    video_id = line_split[1]
    start_time = line_split[2]
    duration = str(int(line_split[3]) - int(start_time))

    video_path = dataset_path + "/" + label + "/" + video_id + "_"+start_time+"_"+duration+".mp4"
    label_sf = label.replace(' ', '_')

    downscaled, log = downscale_clip(video_path)
    if downscaled == True:
      output_file.write(video_path + " " + label_dict[label_sf] +'\n')
    
  input_file.close()
  output_file.close()

base_path = sys.argv[1]
out_path = base_path + '/kinetics'
in_path = base_path + "/kinetics400"

file_list = [in_path+'/trainhead.csv', in_path+'/validatehead.csv', in_path+'/testhead.csv']
label_dict = gen_label_file(file_list, out_path+'/labels.csv')
prepare_dataset(out_path, in_path+'/trainhead.csv', out_path+'/train.csv', label_dict)
prepare_dataset(out_path, in_path+'/validatehead.csv', out_path+'/val.csv', label_dict)
prepare_dataset(out_path, in_path+'/testhead.csv', out_path+'/test.csv', label_dict)