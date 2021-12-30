import os, subprocess
from corrLib import readdata
directory = r'D:\BaiduNetdiskDownload'
l = readdata(directory, 'heic')

for num, i in l.iterrows():
    print('Converting {}...'.format(i.Dir))
    dest = i.Dir.replace("heic", "jpg")
    subprocess.run("magick {0} {1}".format(i.Dir, dest))

"""
A wrapper of ImageMagick.
"""
