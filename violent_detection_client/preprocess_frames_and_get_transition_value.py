import cv2
import numpy as np
from keras.applications import VGG16
from keras.models import Model, Sequential
from keras.layers import Input
from keras import backend as K

frames_per_batch = 20
img_size = 224
img_size_touple = (img_size, img_size)

#load pre-trained Model : VGG16
image_model = VGG16(include_top=True, weights='imagenet')

#get VGG15(fc2) layer
transfer_layer = image_model.get_layer('fc2')

#get renovated VGG16(1~15)
image_model_transfer = Model(inputs=image_model.input,
                             outputs=transfer_layer.output)

#set variable with VGG15(fc2)'s output size
transfer_values_size = K.int_shape(transfer_layer.output)[1]


#preprocess camera frames to input for renovated VGG16
def get_preprocessed_camera_frames(camera_frames):

    preprocessed_camera_frames = []

    for camera_frame in camera_frames:
        #RGB_camera_frame = cv2.cvtColor(camera_frame, cv2.COLOR_GRAY2RGB)
        RGB_camera_frame = cv2.cvtColor(camera_frame, cv2.COLOR_BGR2RGB)
        preprocessed_camera_frame = cv2.resize(RGB_camera_frame, dsize=(img_size, img_size),
                                                interpolation=cv2.INTER_CUBIC)

        preprocessed_camera_frames.append(preprocessed_camera_frame)

    preprocessed_camera_frames_numpyArr = np.array(preprocessed_camera_frames)
    preprocessed_camera_frames_numpyArr = (preprocessed_camera_frames_numpyArr / 255.).astype(np.float16)

    #return value's shape is (camera_frames' size, img_size, img_size, 3)
    return preprocessed_camera_frames_numpyArr;



#get transfer_values from preprocess_camera_frames_numpyArr
def get_transfer_values(camera_frames):

    # Pre-allocate input-batch-array for camera frames.
    # shape == (20, 224, 224, 3)
    shape = (frames_per_batch,) + img_size_touple + (3,)

    # image_batch의 shape == (20, 224, 224, 3)
    image_batch = np.zeros(shape=shape, dtype=np.float16)
    image_batch = get_preprocessed_camera_frames(camera_frames)

    # Pre-allocate output-array for transfer-values.
    # Note that we use 16-bit floating-points to save memory.

    # shape는 (20, 4096)
    shape = (frames_per_batch, transfer_values_size)
    # transfer_values의 shape == (20, 4096)
    transfer_values = np.zeros(shape=shape, dtype=np.float16)

    transfer_values = \
            image_model_transfer.predict(image_batch)

    return transfer_values
