import os


path = "no/"


for i , file in enumerate(os.listdir(path)):
    os.rename(path + file, path + 'no_' + str(i + 2500) + '.avi')
