# 다변량프로젝트_인자분석_2

# <변수이름 정리>
# 1.) 영역(Area): 빈 영역의 면적과 경계 내 픽셀 수.
# 2.) 둘레(Perimeter ): 콩 둘레는 콩 둘레의 경계 길이
# 3.) 장축 길이(Major axis length): 콩에서 끌어낼 수 있는가장 긴 선의 끝 사이의 거리
# 4.) 단축 길이(Minor axis length ): 주축에 수직으로 선 상태에서 빈에서 그릴 수 있는 가장 긴
# 5.) 종횡비(Aspect ratio): L과 L 사이의 관계를 정의합니다.
# 6.) 편심률(Eccentricity): 영역과 모멘트가 같은 타원의 편심률.
# 7.) 볼록한 면적 (Convex area) : 콩 씨앗의 면적을 포함할 수 있는 가장 작은 
# 볼록 다각형의 픽셀 수.
# 8.) 등가 지름(Equivalent diameter ): 콩 종자 면적과 면적이 같은 원의 지름. 
# 9.) 범위(Extent): 빈 영역에 대한 경계 상자의 픽셀 비율입니다.
# 10.) 견고도(Solidity ): 볼록도라고도 한다. 볼록 껍질의 픽셀과 콩에서 발견되는 픽셀의 비율입니다.
# 11.) Roundness : (4piA)/(P^2) 식으로 계산한다
# 12.) 컴팩트도(Compactness ): 물체의 원도를 측정한다: Ed/L
# 13.) 형상 인자 1(ShapeFactor1)
# 14.) 형상인자2(ShapeFactor2)
# 15.) 형상인자3(ShapeFactor3)
# 16.) 형상인자4(ShapeFactor4)
# 17.) 클래스(CLASS): (세커, 바르부냐, 봄베이, 칼리, 더모산, 호로스, 시라)

###########################################################################
# 1. 주성분인자법을 이용한 인자분석

# 자료읽기 및 요약통계량
setwd("C:/3-1/다변량/프로젝트")
data = read.csv('Rice_preprocess.csv')
head(data) 
summary(data)
# => 범주형변수 "CLASS"는 인자분석에 불필요하다고 판단. 

# 인자분석에 불필요한 변수제거
data = data[,-which(names(data) %in% c("X","CLASS"))]
head(data)
colnames(data)

# 상관행렬 구한 후, Bartlett's 구형성 검정실시
# (귀무가설 : 변수들간의 상관관계가 없다.)
# (대립가설: 변수들간의 상관관계가 있다.)

corMat = cor(data)
library(psych)
cortest.bartlett(R=corMat, n = nrow(data)) # #Bartlett's 구형성 검정
# => p-vlaue가 0.05보다 작으므로 귀무가설을 기각하여 
# 변수들의 상관관계가 있으므로 인자분석을 진행하기에 적절하다.

# 초기 인자분석 실행하기(회전은 하지 않은 상태)
install.packages('GPArotation')
library(GPArotation)

fa = principal(data, rotate = 'none')
names(fa)

fa$values

sum(fa$values > 1)
# => 고윳값을 살펴보면 , 1이상인 것이 3개이다.

plot(fa$values, type = 'b', pch = 19)
abline(a=1, b= 0)
# 스크리 그림에서도 마찬가지로 세 번째 인자 다음부터 기울기가 
# 완만해지는 것을 볼 수 있다. 
# 따라서 , 유효한 인자의 수는 3개로 생각할 수 있다.

# nScree 함수를 이용한 인자개수 결정
install.packages('nFactors')
library(nFactors)
nScree(data) # 2개 또는 3개가 적절해보임


# 인자회전
# (이번 분석에서는 직교회전의 varimax와 사각회전의 oblimin을 이용)

# varimax 회전결과

fa_pc_varimax = principal(data, nfactors = 3, rotate = 'varimax',
                         scores = T, method =  'regression')
fa_pc_varimax
# => 모든 변수의 공통성(h2)이 높으므로 변수를 제거할 필요는 없다.
# 각 인자가 설명하는 총분산의 비율(Proportion Var)은 
# 첫번째인자가 47%, 두번쨰인자 35% , 세번쨰인자 12%

# 인자와 변수간의 관련성 시각화 - 회전방법: varimax
install.packages("gplots")
library(gplots)
library(RColorBrewer)
?heatmap.2

dev.new()
heatmap.2(abs(fa_pc_varimax$loadings), col = brewer.pal(9, 'Blues'),
          trace = 'none', key = FALSE,
          cexCol = 1.2, main = 'fa_pc_varimax$loadings', cexRow = 0.5 )

# => 첫번째인자는 ECCENTRICITY(편심률),ASPECT_RATIO(종횡비)
# ,ROUNDNESS(원마도?둥글둥글함),COMPACTNESS(빽빽함,조밀함),SHAPEFACTOR_3 
# 에서 높은 값을 가진다. 
# 두번째인자는 AREA(면적),PERIMETER(둘레),EQDIASQ(등가지름),
# CONVEX_AREA(볼록한면적)에서 높은 값을 가진다.
# 세번째인자는 SOLIDITY(견고함),SHAPEFACTOR_4에서 높은 값을 가진다. 

# 인자점수
head(fa_pc_varimax$scores)


# oblimin 회전결과
fa_pc_oblimin = principal(data, nfactors = 3, rotate = 'oblimin',
                         scores = T, method = 'regression')
fa_pc_oblimin
# => 회전방법에 있어서 oblimin은 varimax와 비교하면 
# 인자 적재값이 차이가 나는 것을 볼 수 있다. 그러나
#  세 인자에 대해 묶여지는 변수가 같으며 Proportion Var도 비슷하게 보임. 

# 인자와 변수간의 관련성 시각화 - 회전방법: oblimin
dev.new()
heatmap.2(abs(fa_pc_oblimin$loadings), col = brewer.pal(9, 'Greens'),
          trace = 'none', key = FALSE,
          cexCol = 1.2, main = 'fa_pc_oblimin$loadings', cexRow = 0.5 )

  # 인자점수
head(fa_pc_oblimin$scores)

# <varimax와 oblimin의 히트맵(시각화) 비교 결과> 
# 인자의 순서가 달라서 헷갈릴수있는데 자세히 보면
# varimax와 oblimin의 차이는 크게 없어보인다. 

# 인자패턴 그림 <- 강의노트에 있어서 그려보긴함..

# plot(factor1, factor3)
dev.new()
plot(fa_pc_oblimin$loadings[, 1], fa_pc_oblimin$loadings[, 2]
     , xlab = "factor1", ylab = "factor2", pch = 19, main = 'pc_oblimin')
text(x=fa_pc_oblimin$loadings[, 1], y=fa_pc_oblimin$loadings[, 2]
     , labels = colnames(data)
     ,adj = -0.1,  cex = 0.8)
abline(h=0, v=0, lty=2)

# plot(factor1, factor3)
dev.new()
plot(fa_pc_oblimin$loadings[, 1], fa_pc_oblimin$loadings[, 3]
     , xlab = "factor1", ylab = "factor3", pch = 19, main = 'pc_oblimin')
text(x=fa_pc_oblimin$loadings[, 1], y=fa_pc_oblimin$loadings[, 3]
     , labels = colnames(data)
     ,adj = -0.1,  cex = 0.8)
abline(h=0, v=0, lty=2)
#########################################################################

# 2. 최대우도추정법을 이용한 인자분석

# varimax 회전 결과 (SOLIDITY, SHAPEFACTOR_4 제외 전) 
fa_ml_varimax = factanal(data, factors = 3, rotation = 'varimax') 
fa_ml_varimax

# 공통성(communality)
1- fa_ml_varimax$uniquenesses # 1 - 특수성
# => SOLIDITY, SHAPEFACTOR_4의 공통성이 각각 0.28, 0.25로 
# 상대적으로 작은 값을 가지므로 이 변수들을 제외하는것이 
# 타당하다고 판단하였다.

# varimax 회전 결과 (SOLIDITY, SHAPEFACTOR_4 제외)
fa2_ml_varimax = factanal(data[,-which(names(data) %in% 
c("SOLIDITY","SHAPEFACTOR_4"))]
, factors = 3, rotation = 'varimax', scores = 'Bartlett') 

# 공통성(communality)
1- fa2_ml_varimax$uniquenesses # 1 - 특수성


fa2_ml_varimax
# => 각 인자가 설명하는 총분산의 비율(Proportion Var)을 보면, 
# 첫번째인자가 총분산에대해 54.1%, 두번째인자가 40.1%, 세번째인자가 1% 설명한다. 


# 인자와 변수간의 관련성 시각화 - 회전방법: varimax
dev.new()
heatmap.2(abs(fa2_ml_varimax$loadings), col = brewer.pal(9, 'Oranges'),
          trace = 'none', key = FALSE,
          cexCol = 1.2, main = 'fa2_ml_varimax$loadings', cexRow = 0.5 )
?heatmap.2
# <주성분인자법(pc)과 최대우도법(ml)의 히트맵비교 결과>
# 먼저 인자와 변수간의 관련성을 보면, 
# pc방법과 ml방법 모두 fator1,2에서는 묶여지는 변수가 같았으나
# fator3에서는 다른 결과를 나타났다.
# 또한,  factor3가 설명하는 총분산의 비율이 pc방법에서는 12% 가 나왔고,
# ml방법에서는 1% 밖에 나오지 않았다.
# 따라서, 여기서는 상대적으로 총분산의 비율을 잘 설명하는 
# pc방법을 사용하는것이 나아보인다.


# 인자점수
head(fa2_ml_varimax$scores)



