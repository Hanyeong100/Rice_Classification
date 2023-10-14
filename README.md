# 분석 소개


# 프로젝트 멤버
백한영: 팀장, 프로젝트 관리, Clustering, Mean Test 담당
노찬용: 팀원, Regression 담당
이정인: 팀원, PCA 담당
조승현: 팀원, FA 담당

# Rice_Classification

## 1. 서론
본 연구는 쌀의 종류(Species)를 분류하기 위해 통계적 기법 및 머신러닝 기법을 활용하는 것이다. 쌀 이미지 특징 데이터로부터 추출된 변수를 분석하고, 통계적 기법 및 머신러닝 기법으로 쌀 종류 분류모델을 개발하는 데 초점을 맞추고 있다. 이전에는 농업 전문가가 직접 쌀의 형태를 확인해 품종을 분류하였기 때문에 시간이 오래 소요되었으며, 객관적 기준 없이 품질 평가 전문가의 주관에 의존하게 되어 전문가 간 평가 프로세스의 차이가 발생하였다.[1] 따라서, 본 연구의 목적은 통계적 기법 및 머신러닝 기법을 활용한 분류모델을 통해 쌀의 품종 분류를 자동화한다면 분류에 드는 비용과 시간을 절약할 수 있을 것이며, 전문가의 주관으로 인한 편향 문제를 해결함에 있다.

## 2. 데이터 소개
본 연구에서는 쌀알 이미지 파일로부터 쌀알의 면적, 둘레, 등가 지름 등의 정보를 수치화하여 생성한 Cinar와 Koklu의 Rice MSC Dataset[2]을 선택하였다. 

## 3. 분석 방법 및 결과
### 3.1 분석 방향
이번 분석에서, 우리는 쌀 종류 분류에 주요한 영향을 끼치는 변수를 확인하고자 한다. 먼저, Mean Test를 통해 쌀 종류와 변수 간의 차이가 있는지 검정한다. 그 후, 쌀알 종류에 주요한 영향을 끼치는 요인을 확인하기 위해 Factor Analysis, PCA를 실시한다. 요인 확인 후, Logistic Regression, LDA, QDA, Random Forest, K-Means Clustering 모델을 통해 쌀 종류를 잘 분류할 수 있는 최적의 모델을 탐색한다. 


## 4. 분석 결과
이번 연구에서 사용된 분류 모델에서, 표준화를 거친 Logistic Regression이 약 97.7%의 설명력을 가지고 있어 분류 모델 중 가장 좋은 성능을 보였다. 

그러나, 각 모델 별 사용된 데이터는 모형 및 데이터셋 별 비교를 위한 원본 데이터 사용으로 데이터가 등분산성과 정규성을 만족하지 못한다는 한계가 존재한다. 또한, 자원과 시간 문제로 인해 비교적 이상치에 둔감한 DNN(Deep Neural Network)이나 쌀알 이미지를 활용하여 이미지 데이터 분석에 활용되는 CNN(Convolutional Neural Network), LSTM(Long short-term memory), Transformer 등 더 다양한 모델을 적용하지 못한 것을 개선해볼 사항으로 남겨두었다. 추후 자원과 시간 문제가 해결된다면, 딥러닝 모델을 쌀알 이미지 데이터를 통해 딥러닝을 실시함으로써 쌀알을 더 효과적으로 분류하는 모델을 찾아 쌀알 분류에 소모되는 비용과 시간을 절약할 수 있을 것이라 기대한다.


[1] Patrício, D. I., & Rieder, R. (2018). Computer vision and artificial intelligence in precision agriculture for grain crops: A systematic review. Computers and electronics in agriculture, 153, 69-81.
[2] Cinar, I., & Koklu, M. (2019). Classification of rice varieties using artificial intelligence methods. International Journal of Intelligent Systems and Applications in Engineering, 7(3), 188-194.
