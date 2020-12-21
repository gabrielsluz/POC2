import sys

#Picks the first num_lines lines in the csv file.
#Replaces spaces with underlines
#extract_header("kinetics400/train.csv", 20)
#extract_header("kinetics400/train.csv", -1) for replacing all spaces with underlines
def extract_header(filename, num_lines):
  out_f = open(filename[:-4] + "head.csv" , "w")
  f = open(filename, "r")
  i = 0
  for line in f:
    if i == num_lines:
      break
    i += 1

    out_f.write(line.replace(" ", "_"))

  out_f.close()
  f.close()


filename = sys.argv[1]
num_lines = sys.argv[2]
extract_header(filename, num_lines)