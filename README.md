# 실시간 폭력탐지 시스템
final project of Kosa's Big data Education

코드 설명

Colab으로 struct model and train model폴더의 violence_detection.ipynb를 
를 통해 아이스 하키 영상을 기반으로 학습된 폭력탐지 모델을 얻을 수 있습니다. 
(폴더안의 download.py또한 세션에 업로드 하여야 import구문에서 오류가 발생하지 않습니다.)

violence_detection_client폴더안의 모델 weitght파일(.h5)과 구조 정보 파일(.json)은 
AI Hub 데이터세트를 이용하여 학습한 정보 입니다.

violence_detection_client폴더안의 violence_detection.py가 클라이언트 실행 파일입니다.


--------------------------------------------------------------------------------------------------------------
# 영수증파싱부분 추가
ReceiptVision- spring version 폴더에는 spring으로 네이버 ocr api로 텍스트 이미지 추출할 때 필요한 실행파일입니다.
json parsing 폴더에는 spring으로 돌린 json파일을 html형태로 나열을 하였습니다. 
다음으로 원하는 정보만 parsing하기 위해 코드를 짜서 날짜, 위치, 가격 정보를 추출할 수 있게한 결과물입니다. 
(실시간 폭력탐지 시스템 프로젝트에서는 이 부분을 제외시켰습니다.)
