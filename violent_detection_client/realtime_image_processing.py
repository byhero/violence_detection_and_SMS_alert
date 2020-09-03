import cv2
import numpy as np
from tensorflow.compat.v2.keras.models import model_from_json
from preprocess_frames_and_get_transition_value import *
from multiprocessing import Lock
import requests

# 전경만을 분리하기 위한 전역변수
#fgbg = cv2.createBackgroundSubtractorMOG2(detectShadows = False)
#kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(3,3))

#Load trained violence_detection_model

# 접속 url
url = 'http://192.168.1.146/poew/connect';

##json file open, read, close
json_file = open("violence_detection_model.json", "r")
loaded_model_json = json_file.read()
json_file.close()

##load model from json
loaded_model = model_from_json(loaded_model_json)

##add weights to loaded_model
loaded_model.load_weights("violence_detection_model.h5")

#complie loaded_model
loaded_model.compile(loss='mean_squared_error', optimizer='adam',metrics=['accuracy'])


def get_transition_value(queue, violence_judgement_array):

    camera_frames = []

    try:
        while True:
            camera_frames.append(queue.get())
            if len(camera_frames) == 20 :
                prepredict_value = get_transfer_values(camera_frames).reshape((1, 20, 4096))
                violence_or_not = loaded_model.predict(prepredict_value)
                if(violence_or_not[0][0] > 0.5):
                    print('violence')
                    #print(violence_or_not)
                    violence_judgement_array.append('violence')
                else:
                    print('no')
                    #print(violence_or_not)
                    violence_judgement_array.append('no')
                del camera_frames[:]
    except KeyboardInterrupt:
        pass


def cam_read(queue):

    cap = cv2.VideoCapture(1)

    if cap.isOpened():
        fps = cap.get(cv2.CAP_PROP_FPS)
        delay = int(1000/fps)
        while True:
            ret, img = cap.read()

            if ret:
                cv2.imshow('camera', img)

                if queue.full():
                    while not queue.empty():
                        cv2.imshow('camera', cap.read()[1])
                        if cv2.waitKey(delay) != -1:
                            break
                else:
                    #img = fgbg.apply(img)
                    #img = cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)
                    queue.put(img)

                if cv2.waitKey(delay) != -1:
                    break
            else:
                print('no frame')
                break
    else:
        print("can't open camera.")

    cap.release()
    cv2.destroyAllWindows()


def determine_violence_make_request(violence_judgement_array):

    lock = Lock()
    determinant = 0

    try:
        while True:
            lock.acquire()
            if len(violence_judgement_array) == 5:
                for each_judgement in violence_judgement_array:
                    if each_judgement == 'violence':
                        determinant = determinant + 1
                if determinant >= 3:
                    print("post request Occur")
                    with requests.Session() as session:
                        with session.get(url, params = {'location': 'police hospital'}) as response:
                            print("response status_code - " + str(response.status_code));
                            print("response text - " + str(response.text));
                determinant = 0
                del violence_judgement_array[:]
            lock.release()
    except KeyboardInterrupt:
        pass
