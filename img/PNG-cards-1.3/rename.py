import glob, re, os

for filename in glob.glob('/PNG-cards-1.3'):
  new_name = re.sub(r'_of_', '-', filename)
  os.rename(filename, new_name)