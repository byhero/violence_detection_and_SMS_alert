import os
from multiprocessing import Process, Queue, Manager
from realtime_image_processing import *

if __name__ == "__main__" :
    queue = Queue(maxsize = 20) #pipe for exchanging data between processes
    manager = Manager()  #shared memory among multi processes

    violence_judgement_array = manager.list([])
    #print(violence_judgement_array)

    cam_read_proc = Process(target = cam_read, args = (queue ,))
    get_transition_value_proc = Process(target = get_transition_value, args =(queue, violence_judgement_array))
    determine_violence_make_request = Process(target = determine_violence_make_request, args = (violence_judgement_array,))

    cam_read_proc.start()
    get_transition_value_proc.start()
    determine_violence_make_request.start()

    queue.close()
    queue.join_thread()

    cam_read_proc.join()
    get_transition_value_proc.terminate()
    get_transition_value_proc.join()
    determine_violence_make_request.terminate()
    determine_violence_make_request.join()
