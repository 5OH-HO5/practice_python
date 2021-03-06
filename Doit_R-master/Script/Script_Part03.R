#### 03-1 ####

## ---------------------------------------------------------------------- ##
a <- 1  # a에 1 할당
a       # a 출력

b <- 2
b

c <- 3 
c

d <- 3.5
d

a+b

a+b+c

4/b

5*b


## -------------------------------------------------------------------- ##
var1 <- c(1, 2, 5, 7, 8)    # 숫자 다섯 개로 구성된 var1 생성
var1

var2 <- c(1:5)              # 1~5까지 연속값으로 var2 생성
var2

var3 <- seq(1, 5)           # 1~5까지 연속값으로 var3 생성
var3

var4 <- seq(1, 10, by = 2)  # 1~10까지 2 간격 연속값으로 var4 생성
var4

var5 <- seq(1, 10, by = 3)  # 1~10까지 3 간격 연속값으로 var5 생성
var5

var1
var1+2

var1
var2
var1+var2


## -------------------------------------------------------------------- ##
str1 <- "a"
str1

str2 <- "text"
str2

str3 <- "Hello World!"
str3

str4 <- c("a", "b", "c")
str4

str5 <- c("Hello!", "World", "is", "good!")
str5

str1+2


#### 03-2 ####

## -------------------------------------------------------------------- ##
# 변수 만들기
x <- c(1, 2, 3)
x

# 함수 적용하기
mean(x)
max(x)
min(x)

# Q 문제
v1 <- c(1, 3, 5, 0)
v2 <- c(2, 4, 6, 7)
# 벡터 q를 정렬하라
q <- c(v1, v2)
q
sort(q)
tail(sort(q),3)
# 벡터 q의 top3의 색인을 순서대로 출력
# order의 결과는 순서가 나와야할 index번호가 나온다
q
# R은 index번호 1부터 시작
order(q)
order(q, decreasing = T)[1:3]
# 위의 결과를 이용해서 top3 출력
q[order(q, decreasing = T)[1:3]]
# 벡터 q의 순서를 역순으로 바꾸기
n = length(q)
q
q[n:1]
# 벡터 q에서 짝수만 출력
q[q%%2==0]
# 0부터 10까지의 수 중에 짝수만 출력
seq(0,10, by = 2)
# 벡터 q에서 짝수 위치의 값인 [1, 5, 2, 6]만 출력
q

# 벡터 q에서 랜덤하게 중복허용하여 10개의 수 / replace = 중복허용여부
sample(q, 10, replace = T)
# 벡터 q에서 랜덤하게 중복없이 4개의 수
sample(q,4)
# 변수 v1, v2 삭제
rm(v1, v2)


# ignore.case = F // 대소문자를 무시하고 찾을지 여부

# Q: 아래 url을 참고하여,
# https://rfriend.tistory.com/37
# "I have a mail"을 단어단위로 쪼개고,
word <- ("I have a mail")
word_split <- strsplit(word," ")
word_split[1]
# list형태일 때
word_split[[1]]
# unlist 사용
word_split1 <- unlist(word_split)
word_split1
word_split
# "a"가 존재하는 단어 색인을 출력
grep('a', word_split)
# str5 "o"가 존재하는 성분을 출력
str5
grep('o', str5)



# 함수 적용하기
mean(X)
max(X)
min(X)
median(X)
var(X)
sd(X)

str5
# python에서 join과 같은 역할
# paste 붙이기
paste(str5, collapse = ",")  # 쉼표를 구분자로 str4의 단어들 하나로 합치기
paste(str5, collapse = " ")
paste(str5, str3, sep = ",")
paste(str5, str3, sep = " ")

x_mean <- mean(x)
x_mean

str5_paste <- paste(str5, collapse = " ")
str5_paste


#### 03-3 ####

## -------------------------------------------------------------------- ##
install.packages("ggplot2")  # ggplot2 패키지 설치
library(ggplot2)             # ggplot2 패키지 로드

# 여러 문자로 구성된 변수 생성
x <- c("a", "a", "b", "c")
x

y <- c(1, 3, 11, 7, 2, 9, 15, 18)
y

# 빈도 그래프 출력
qplot(x, geom="histogram", bins=3)
hist(y)
qplot(y, geom="histogram", bins=5)

## -------------------------------------------------------------------- ##
# data에 mpg, x축에 hwy 변수 지정하여 그래프 생성
# mpg data = 제조사, 모델별 연비를 나태낸 정보
mpg<-mpg
mpg[7:11]

qplot(data = mpg, x = hwy, bins = 20)

# x축 cty
qplot(data = mpg, x = cty)

# x축 drv, y축 hwy
qplot(data = mpg, x = drv, y = hwy)

# x축 drv, y축 hwy, 선 그래프 형태
qplot(data = mpg, x = drv, y = hwy, geom = "line")

# x축 drv, y축 hwy, 상자 그림 형태
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")

# x축 drv, y축 hwy, 상자 그림 형태, drv별 색 표현
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

# qplot 함수 매뉴얼 출력
?qplot
example(aplot)

# Q: mpg 데이터에 대해 aplot으로
# cty와 hwy간 산점도를 그리고, hwy ~ cty의 회귀선을 추가
qplot(Cyt, hwy, data=mpg)

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = F)
# cy1별 cty와 hwy간 산점도 그리기
qplot(cty, hwy, data = mpg, facets = ~cy1)
# cy1별 hwy에 대한 boxplot 그리기
qplot(factor(cy1), wt, data = mtcars, geom = "boxplot")
# 제조사별 모델별 bar차트 그리기
# coord_flip() 가로로 나타내기
qplot(manufacturer, data=mpg, geom='bar')+coord_flip()
qplot(model, data=mpg, geom='bar')+coord_flip()

manuf_Mod = paste(mpg$manufacturer, mpg$model, sep='|')
qplot(manuf_Mod, geom='bar')+coord_flip()
