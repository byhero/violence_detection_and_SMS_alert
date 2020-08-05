

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

ns_df = pd.read_excel('1.xlsx') #1데이터

ns_df.head()

ns_df.shape

ns_df.describe()
ns_df.rename(columns={"NS Shop+ 2019.01.01~12.31"	:"time","Unnamed: 1":"playtime","Unnamed: 2":"code","Unnamed: 3":"productcode","Unnamed: 4":"name","Unnamed: 5":"category","Unnamed: 6":"price","Unnamed: 7":"output"},inplace=True)
ns_df.drop([0], inplace=True)

ns_df2=ns_df

ns_df['time']=pd.to_datetime(ns_df['time'])
ns_df.head()


watch = pd.read_excel('watch.xlsx')      #2데이터

watch=watch.T
watch.head()


watch_list=watch.values.tolist()

watch_list=np.array(watch_list)        #watch데이터 프레임 리스트로 변경



np.sum(watch_list[a,b:c])       # 함수 만들어야 됨 a 날짜,b시작시간~c끝시간
