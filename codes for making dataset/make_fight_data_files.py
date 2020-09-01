import cv2
from xml.etree.ElementTree import parse
import math
import os
import sys
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip
from moviepy.editor import *
from moviepy.video.fx.resize import resize



path = "outsidedoor_02"

video_xml_paths = []
video_file_paths = []
video_file_names = []


for folder in os.listdir(path):
    for file in os.listdir(os.path.join(path, folder)):
        if file[-3:] == 'mp4':
            video_file_paths.append(os.path.join(path, folder, file))
            video_file_names.append(file[:-4])
        else:
            video_xml_paths.append(os.path.join(path, folder, file))


for video_xml_path, video_file_path , video_file_name in zip(video_xml_paths, video_file_paths, video_file_names):

    tree = parse(video_xml_path)
    root = tree.getroot()

    root.find("header").find("fps").text

    objects = root.findall("object")
    people_actions = []
    actions_time = []
    time = []

    for object in objects:
        people_actions.append(object.findall("action"))


    for person_actions in people_actions:
        for action in person_actions:
            for one_personal_action in action.findall('frame'):
                time.append(math.ceil(int(one_personal_action.find('start').text)/int(root.find("header").find("fps").text)))
                time.append(math.trunc(int(one_personal_action.find('end').text)/int(root.find("header").find("fps").text)))
                actions_time.append(time)
                time = []


    my_clip = VideoFileClip(video_file_path)
    # my_clip = VideoFileClip("sample.mp4").resize(width=360, height=288)

    duration = int(my_clip.duration)

    if not os.path.exists('encoding_yet_fight'):
            os.makedirs('encoding_yet_fight')

    _path = 'encoding_yet_fight/'+video_file_name

    os.mkdir(_path)


    start_offsets = []
    end_offsets = []

    for i in range(len(actions_time)):
        start_offsets.append(actions_time[i][0])

    for i in range(len(actions_time)):
        end_offsets.append(actions_time[i][1])

    for i in range(len(start_offsets)):
        t = end_offsets[i] - start_offsets[i]
        if t == 0:
            continue
        for j in range(t):
            ffmpeg_extract_subclip(video_file_path, start_offsets[i] + j, start_offsets[i] + 1 + j, targetname=os.path.join(_path , video_file_name +"_"+ str(i) + "_" + str(j) + ".mp4"))

    # os.system("mpg123 -w audio.wav cut + str(i) + .mp4")
    #
