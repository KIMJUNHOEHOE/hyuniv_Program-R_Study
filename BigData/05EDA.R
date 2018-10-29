# Lecture : EDA(Explorary Data Analysis), Ž���� ������ �м�
# Date : October 10th, 2018

# �����Ϳ� ������ ����(pattern) �Ǵ� Ư¡�� ã�Ƴ��� �۾�
# �׷����� ǥ�� �� �׷��� ��.

install.packages("ggplot2") # Visualization : �ð�ȭ
install.packages("dplyr")   # Data Analysis and Handling
install.packages("RColorBrewer") # Colors
install.packages("stringr") # ���ڿ� ó�� ��Ű��
install.packages("prettyR") # Mode(�ֺ�), �������м�
install.packages("e1071") # Skewness, Kurtosis, SVM
install.packages("psych") # Descriptive Statistics = Summary Statistics

library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(stringr)
library(prettyR)
library(e1071)
library(psych)
library(writexl)

# �۾�����
setwd("c:/R/BigData/")


# ������ �о����
# ggplot2::diamonds


# �������� ����(������� ����)
# 1. ���� �ڷ� = ������ �ڷ� : ����(����) = character vector or factor, numeric vector
# 2. ���� �ڷ� : numeric vector 
# ���� �ڷ��� numeric vector�� ���� �ڷ��� numeric vector�� ������ ���� : ��Ģ���� ���

# diamonds
diamonds <- diamonds[ ,1:10] # �� �����ͷ� ����
# ���� �ڷ� : cut, color, clarity
# ���� �ڷ� : carat, depth, table, price, x, y, z

# 1. �Ϻ���(Uni-variate) ���� �ڷ��� �м� ----
# 1.1 ǥ ----
# (1) ��(Frequency)
# table(data$variable) - ���� ���� vector
table(diamonds$cut)
sort(table(diamonds$cut), decreasing = TRUE)
sort(table(diamonds$cut), decreasing = TRUE)[1:3]

table(diamonds$color)
table(diamonds$clarity)

# matrix�� �����̽��� �� �� ���� ���, drop = FALSE �� ��� ��Ʈ���� ����
# data.frame�� �����̽��� ���� ���´� data.frame
diamonds[,2] # cut 
class(diamonds[,2])
diamonds[,3] # color
diamonds[,4] # clarity

for(i in 2:4){ # for�� ������ �� Ŀ���� ��ġ�� for��
  print(sort(table(diamonds[ , i]), decreasing = TRUE))
}

# (2) �����(Percent)
# prop.table(frequency) : ���� : 0~1 , property
# prop.table(frequency)*100 : �����
prop.table(table(diamonds$cut))*100 # ���ϰ��� vector
sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE)
# ����� �Ҽ��� �ڸ����� Ư������ ������ �� �ڸ� ǥ����
# round( , digits=1) : �Ҽ��� �� ��°���� �ݿø��ؼ� ù ��° ���� ������
round(sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE) , digits = 1)

# ����1
# for�� �̿��ؼ� �� ���� ���� �ڷῡ ����
# ��, ������� ����Ͻÿ�.
for(i in 2:4){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ ,i]))*100,decreasing = TRUE), digits=1))
}

for(i in c("cut","color","clarity")){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ ,i]))*100,decreasing = TRUE), digits=1))
}

# Ư�� ������ �ִ� �� ã�� -> grep ����

# 1.2 �׷��� ----
# (1) ���� �׷��� : ����/���� ----
# barplot(frequency or percent)
barplot(sort(table(diamonds$cut),decreasing = TRUE))
barplot(prop.table(sort(table(diamonds$cut),decreasing = TRUE))*100)

# i. ���� ���� : col = "color"
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = "tan4")

# ���� 2
# ���� ������ �� �ٸ��� �Ͻÿ�.
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = c("tan4","red","blue","springgreen","white"))

pal <- RColorBrewer::brewer.pal(n = 5, name = "BuGn")
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = pal)
barplot(sort(table(diamonds$cut), decreasing = TRUE), col = rainbow(5))

# ii. ��Ʈ�� ���� : main = "title"
barplot(sort(table(diamonds$cut), decreasing = TRUE), 
        col = "tan4",
        main = "Cut of Diamonds")

# iii. y�� ���� : ylab = "y axis's label"
barplot(sort(table(diamonds$cut), decreasing = TRUE), 
        col = "tan4",
        main = "Cut of Diamonds",
        ylab = "frequency",
        xlab = "degree")
# iv. y�� ���� : ylim = c(min,max)
barplot(sort(table(diamonds$cut), decreasing = TRUE), 
        col = "tan4",
        main = "Cut of Diamonds",
        ylab = "frequency",
        xlab = "degree",
        ylim = c(0,25000)
        )

# v. ���� ����׷��� : horiz = TRUE
barplot(sort(table(diamonds$cut), decreasing = FALSE), 
        col = "tan4",
        main = "Cut of Diamonds",
        xlab = "frequency",
        ylab = "degree",
        xlim = c(0,25000),
        horiz = TRUE
        )

# ����3
# for�� �̿��ؼ� �� ���� ���� �ڷῡ ���� ������ ���� �׷����� �ۼ��غ�����.
for(i in c("cut","color","clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(i,"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
          )
}

for(i in 2:4){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
}

# paste(character1, character2, ..., sep =" " )
# ��Ģ �ִ� ���� ���� ���� ����
stringr::str_to_title(paste("i", "am", "boy", sep=":"))
paste("Love","is","choice.")
paste("Love","is","choice.", sep = "-")
paste("Love","is","choice.", sep = "")
paste("����", c("��ȸ", "����", "��ȣ"), sep = "-")
paste("V", 1:10, sep = "") # vectorization, recycling rule
paste("cut", "of Diamonds")
paste("color", "of Diamonds")
paste("clariy", "of Diamonds")
colnames(diamonds)
colnames(diamonds)[2]
colnames(diamonds)[3]
colnames(diamonds)[4]

tolower("Love is choice.") # �ҹ���
toupper("Love is choice.") # �빮��

stringr::str_to_title("i am a boy") # ù ����(�������) ���ڸ� �빮��


# (2) �� �׷��� ----
# pie(freqency or percent)
pie(sort(table(diamonds$cut), decreasing = TRUE))
pie(prop.table(sort(table(diamonds$cut), decreasing = TRUE)),
    col = pal)

# i. �������� ũ�� : radius = 0.8 : default
pie(sort(table(diamonds$cut
               ), decreasing = TRUE),
    col = pal,
    radius = 1)

# ii. �ð� ���� : clockwise = TRUE : default - FALSE
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col = pal,
    radius = 1,
    clockwise = TRUE)

# iii. ù° ������ ���� ���� : init.angle =
# �ð� �ݴ� ���� : 0, 0�� ������ 3�ù���
# �ð���� : 90
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col = pal,
    radius = 1,
    clockwise = TRUE,
    init.angle = 270)

# ����4
# ���� �ڷ� �� ���� ���� ������ ����/�� �׷����� �ۼ��Ͻÿ�.
# (��, ���� ��������)
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
          )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
      )
  
}

# �׷��� ȭ�� �����ϱ�
# par(mfrow = c(nrow, ncol)) : ����� ä����
# par(mfcol = c(nrow, ncol)) : ������ ä����
# par : partition, mf : multi frame

par(mfrow = c(3,2)) # �������� �׷��� ����� ������� ��.
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
  )
  
}

# �׷��� ȭ�� ������ ����
# par(mfrow = c(1,1))
par(mfrow = c(1,1))

# �׷����� pdf ���Ϸ� �����ϱ�
# pdf(file = "directory/filename.pdf") : ���� ����
# �׷��� �۾�
# dev.off() : ���� ��
# graphic device off�� ����
pdf(file = "output1.pdf")
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
  )
  
}
dev.off()

# pdf �� �������� ���� ���� �׷��� �����ϱ�
pdf(file = "output2.pdf")
par(mfrow = c(3,2))
for(i in c("cut", "color", "clarity")){
  barplot(sort(table(diamonds[ ,i]), decreasing = TRUE), 
          col = "tan4",
          main = paste(stringr::str_to_title(i),"of Diamonds", sep = " "),
          ylab = "frequency",
          xlab = "degree",
          ylim = c(0,25000)
  )
  
  pie(sort(table(diamonds[ ,i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 270,
      main = paste(stringr::str_to_title(i),"of Diamonds", sep = " ")
  )
  
}
dev.off()
par(mfrow=c(1,1))


# ggplot2 ��Ű���� �̿��ؼ� �׷��� �ۼ��ϱ� ----
# ggplot2::ggplot(data = , mapping = aes(x = variable)) +
# geom_bar() , ����׷���
# �˾Ƽ� �󵵸� ���ؼ� ���� �׷����� ������
ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) + # fill : ���� ä����
  geom_bar() + # ���� �׷���
  theme_classic() + # ggplot ��� �ٹ̱�
  facet_wrap(~ color + clarity) # color, clarity�� ���� �׷���

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) + 
  geom_bar() +
  labs(title = "Cut of Diamonds",
       x = "Cut",
       y = "Frequency")

# 2. �Ϻ��� ���� �ڷ��� �м� ----

# 2.1 ǥ = ��ǥ ----
# (1) ������ ��
# ���� �����
# i. �ּҰ�, �ִ밪
min(diamonds$price)
max(diamonds$price)
# ii. ���� = �ִ밪 - �ּҰ�
priceRange <- max(diamonds$price)-min(diamonds$price)
# iii. ������ ���� : Sturges Formular : 1 + 3.3*log(n)
intervalCount <- 1 + 3.3*log10(length(diamonds$price))
# iv. ������ �� = ����� �� = ����/������ ����
intervalWidth <- priceRange/17
# v. ù ����: �ּҰ�/ ������ ���� : �ִ밪�� �ǵ��� ����

diamonds$priceGroup <- cut(diamonds$price, # cut�� �ڵ������� factor
                           breaks = seq(from =0, to= 19000, by = 1000),
                           right = FALSE)
table(diamonds$priceGroup) # cut�� ���ϰ��� factor�̱� ������ table ����ϸ� ������ �� ����
sort(table(diamonds$priceGroup), decreasing = TRUE)

# (2) ������ ����� - prop.table(freqeuncy) * 100
round(sort(prop.table(table(diamonds$priceGroup))*100, decreasing = TRUE), digits = 1)

# 2.2 �׷��� ----
# (1) ������׷�
# hist(data&variable, breaks = ) 
hist(diamonds$price, # defalut : Sturges Formular�� �����
     xlim = c(0,20000)
     )
?hist
histResult <- hist(diamonds$price)
histResult
histResult$counts # ���ϰ� ����
str(histResult)

# List�� Slicing
# (1) list[index]
# (2) list[[index]]
# (3) list$index

hist(diamonds$price,
     breaks = seq(from=0, to=20000, by=2000))

hist(diamonds$price, breaks = 200) # ������ ����

# (2) ���� �׸�(Boxplot)
# boxplot(data$variable, range = 1.5)
boxplot(diamonds$price, range = 1.5) # range = 1 : 2�ñ׸� �̻��� �̻�ġ�� ���ڴ�.
# IQR = Q3(3������)-Q1(1������)
# Q3 + 1.5IQR �̻��� ������ �̻�ġ��� �� # range = 1.5 : 3 �ñ׸� �̻��� �̻�ġ�� ���ڴ�.
# Q1 - 1.5IQR �Ʒ��� ���鵵 �̻�ġ
boxplot(diamonds$price, range = 1)
boxplot(diamonds$price, range = 2)

# ���ܺ� ���ڱ׸�
# boxplot(data$variable ~ data$variable)
# boxplot(���� �ڷ� ~ ���� �ڷ�)
boxplot(diamonds$price ~ diamonds$cut) # cut ���ܺ� price boxplot 
# Ideal�� ������ ���� ������ ���� ���� : carat�̶�� ������ ������ ���� �ʱ� ������

# (3) ggplot2 ��Ű���� �̿��� ������׷�/���ڱ׸�
# i. ������׷�
ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram()

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) # bindwidth : ����

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) +
  facet_wrap(~cut) # cut���� ������׷�, ������ ������ �ǹ���

# ii. ���ڱ׸�
ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, y=price)) +
  geom_boxplot()

# 2.3 �����跮 = �����跮 ----

# (1) �߽� = ��ǥ�� ----
# i. ���(Mean) - 1,2,8,9 ���:5. 5�� 1,2,8,9�� �� ��ǥ�ұ�? �׷����� �ʴ�. ���̰� ����
# �̻�ġ�� ������ ����� ��ǥ���� �� ��Ÿ���� ���� �ƴϴ�.
# mean(data$variable, na.rm = TRUE)
mean(diamonds$price, na.rm = TRUE)

# ii. �������(Trimmed Mean) - �̻�ġ�� ���� ���(����5%, ����5% ����)
# ��� 200 , ������� 20 : �����Ϳ� �̻�ġ�� �ִ�. ū �ʿ� �̻�ġ�� �ִ�.
# �츮�� ���� ���ϴ� �����ʹ� 20�� ����� ���� �̷���� �ִ�.
# mean(data$variable, trim = 0.05, na.rm = TRUE)
mean(diamonds$price, trim = 0.05, na.rm = TRUE)
mean(diamonds$price, trim = 0.1 , na.rm = TRUE)

# iii. �߾Ӱ�(Median)
# �߾Ӱ��� 5�� ���Դ�. �׷��ٸ� �ڷ�� ��� �̷���� ������? 5�� ����ϰڴ�?
# 1,2,8,9
# 1,2,8,90
# 1,2,8,989 ���̾���. �߾Ӱ� 5�� ��ǥ������ ������ �� �Ѵ�.
# �߾Ӱ��� �̻�ġ�� ������ ��պ��� �� �޴´�.
# ��հ� �߾Ӱ� ���̿� ���̰� ũ�� �̻�ġ�� �ִ�.
# median(data$variable, na.rm = TRUE)
median(diamonds$price) # ������հ� ���غ��� ������ �̻�ġ�� �����ϴ±���.

# iv. �ֺ��(�󵵰� ���� ���� ��)
# �ֺ���� �� �� �̻��� ���� �� �� ����
# �ֺ���� �Ǳ� ���ؼ��� 2�� �̻� �����ؾ� ��
# which.max(table(data$variable))
# prettyR::Mode(data$variable)
lunchFee <- c(5000,3500,5000,5000,3300)
which.max(table(lunchFee)) # which�� ���� ū ���� �ִ� index�� ������
which.max(table(diamonds$price)) # table(diamonds$price)���� 261��°�� �ִ� 605�� �ֺ��
sort(table(diamonds$price), decreasing = TRUE)[1] # �ֺ���� 605�̰� �� �󵵴� 132��

prettyR::Mode(diamonds$price)

# (2) ���� = ������ ----
# ���� �ִ� ���ܿ� �ٸ��� �󸶳� �����ұ ��ġȭ�� ��
# �ٸ��� �����ϰ� �� ������ ã�� ���� �߿�.

# i. ����(Range) : �ִ밪 - �ּҰ�
# diff(range(data$variable))
range(diamonds$price) # ���Ͱ� ����, �ּҰ� �ִ밪 2���� ����
diff(range(diamonds$price))
diff(c(326,18823,326)) # diff(c(a,b,c)) = b-a, c-b
# ������ �̻�ġ�� ������ �ʹ� ���� ���� => IQR = ����� ����(Q3-Q1)

# ii. ���������(IQR : Inter Quartile Range)
# IQR(data$variable)
IQR(diamonds$price) # ������ ���� ���̰� 4400���� ���̰� �ִ�.
# ����� �������� �Ѱ� : �����͸� 2���� ����Ѵ�.

# iii. �л�(variance)
# R���� ���ϴ� ��հ� �л��� , ǥ����� ǥ���л��̴�.
# var() : ǥ���л�
# R���� ��л��� ���ϱ� ���ؼ��� (var()/(n-1))*n
# ���� ������ ���
# �̻�ġ�� ������ �޴´�.
# �������� ������ ǥ������ ����.
# ������ : ���� ���������� ��Ʈ�� �� �� �ִ� ������ ����
# var(data$variable, na.rm = TRUE)
var(diamonds$price) # �л��� ������ �޷��� ����.

# iv. ǥ���� ǥ������(SD)
sd(diamonds$price)

# v. ������ ���� ����(MAD : Median Absolute Deviation)
# mad(data$variable)
# ��հ� �л��� �̻�ġ�� ������ ���� ���� �� �����Ƿ�, �����͸� Ȯ���ϰ� �̻�ġ�� ������ ���
# �ٸ��� Ȯ���� ������ ������ ���� ���� �̿��� �� �ִ�.
mad(diamonds$price) # ǥ������ 4000�� ���� �� �ٸ��� ���� ���̰� ����.

# (3) ������ ���
# i. �ֵ�(Skewness) : ��Ī����
# e1071::skewness(data$variable)
# �ֵ� = 0 : ��Ī
# �ֵ� > 0 : �������� ġ��ħ - ū �̻�ġ�� ���� ���
# �ֵ� < 0 : ���������� ġ��ħ - ���� �̻�ġ�� ���� ���
e1071::skewness(diamonds$price)
hist(diamonds$price)

# ii. ÷��(Kurtosis) : �߽�(��������� �ֺ����� ����)�� �󸶳� �����Ѱ�(�߽ɿ� �󸶳� ���� �ִ°�)
# �л� : ��ü������ ��տ��� �󸶳� �����ִ°�(����)
# ÷�� : �߽ɿ��� ���̰� ���ΰ�(����)(�л��� �۾Ƶ� ���̴� ���� �� ����)
# �л�� ÷���� �ٸ� ����
# e1071::kurtosis(data$variable)
# ÷�� = 0 : ����
# ÷�� > 0 : ����, ����
# ÷�� < 0 : ����.
# ���ȸ�翡���� ÷���� �߿���. ��ȭ�� ������ ��
e1071::kurtosis(diamonds$price)

# (4) ��Ÿ
# i. �ּҰ� : min(data$variable)
# ii. �ִ밪 : max(data$variable)

# (5) �����跮(���� �ڷ�)�� ���ϴ� ���� ������ �Լ���
# i. summary(data$variable) or summary(data)
summary(diamonds$price)
# �� ��� �߿��� ��ո� ���� Five Numbers Summary
# �ش� �����Ϳ����� ����� �ڷ��� ��ǥ������ �������� ����

summary(dplyr::select(diamonds, -(2:4), -priceGroup)) # ������ �ڷḸ �������� ��

# ii. by(data$variable, data$variable, fuctionName)
#     by(�����ڷ�, �����ڷ�, �Լ���) : �����ڷ� ���� ���� �ڷ� �Լ�ó��
# ���ܺ��� �Լ�ó�� �ϰ� ���� �� ���!
by(diamonds$price, diamonds$cut, mean)
by(diamonds$price, diamonds$cut, mean, trim = 0.05) # cut ���� �� �������
by(diamonds$price, diamonds$cut, sd)
by(diamonds$price, diamonds$cut, summary)
by(diamonds$price, diamonds$cut, hist)
par(mfrow=c(3,2))
by(diamonds$price, diamonds$cut, hist, col ="blue")
par(mfrow =c(1,1))


# iii. psych::describe(), describeBy() - 10�� �̻��� �����跮(���� �ڷ�)�� �� ������ ó������
# psych::describe(data$variable)
# psych::describe(data)
psych::describe(diamonds$price) # default : trimmed�� 10% �������
psych::describe(diamonds$price, trim = 0.05)
psych::describe(dplyr::select(diamonds, -(2:4), -priceGroup))
# psych::describeBy(data$variable, data$variable) - By�� ���ܺ��� ó���� ��
# psych::describeBy(data, data$variable) - By�� ���ܺ��� ó���� ��
psych::describeBy(diamonds$price, diamonds$cut)
psych::describeBy(dplyr::select(diamonds, -(2:4), -priceGroup), diamonds$cut)

priceByCut <- psych::describeBy(diamonds$price, diamonds$cut)
mode(priceByCut)
priceByCut[[1]]

writexl::write_xlsx(priceByCut[[1]],
                    path="priceByCut_1011.xlsx",
                    col_names = TRUE)

# iv. dplyr::summarize(data, variableName = function(variable))
dplyr::summarise(diamonds, 
                 n = n(),
                 Mean = mean(price),
                 SD = sd(price))

# ���ܺ� : dplyr::group_by(data, variable)
diamonds %>% 
  dplyr::group_by(cut) %>%
  dplyr::summarise(
                   n = n(),
                   Mean = mean(price),
                   SD = sd(price))

# Mean�� �������� �������� �����ϱ�
diamonds %>% 
  dplyr::group_by(cut) %>%
  dplyr::summarise(
                  n = n(),
                  Mean = mean(price),
                  SD = sd(price)) %>% 
  dplyr::arrange(desc(Mean))

# �� ����� ����׷����� �׸���
diamonds %>% 
  dplyr::group_by(cut) %>%
  dplyr::summarise(
                    n = n(),
                    Mean = mean(price),
                    SD = sd(price)) %>% 
  dplyr::arrange(desc(Mean)) %>% 
  ggplot2::ggplot(mapping=aes(x=cut, y=Mean)) +
  geom_bar(stat = "identity") # �� �����͸� ������ �� ���� stat �� ������, �츮�� ���� �����跮


# ����
# cut�� "Good" �Ǵ� "Very Good"�̰�,
# carat�� 2 �̻��� diamonds��
# xyz.sum�� ���ϰ�,
# cut���� xyz.sum�� ���� ������׷��� �ۼ��Ͻÿ�.
diamonds %>% 
  dplyr::filter(cut %in% c("Good","Very Good"), carat >= 2) %>% 
  dplyr::mutate(xyz.sum=(x + y + z)) %>% 
  ggplot2::ggplot(mapping = aes(x = xyz.sum)) +
  geom_histogram() +
  facet_wrap(~cut)

# ����
# ggplot2���� �����ϴ� diamonds �����͸� �̿��ϰ�, carat�� 2�����̰�, cut�� "Ideal" ��
# ���̾Ƹ�忡 ���ؼ� xyz.sum�� ���ϰ�, color���� xyz.sum�� ���� ��� Mean�� ���ϰ�, Mean�� ��������
# ������������ �����ϰ�, �� �ڷḦ �̿��Ͽ� ggplot2 ��Ű���� ����Ͽ� ����׷����� �ۼ��ϴ� ���α׷�
diamonds %>% 
  dplyr::filter(carat<=2, cut =="Ideal") %>% 
  dplyr::mutate(xyz.sum=(x+y+z)) %>% 
  dplyr::group_by(color) %>% 
  dplyr::summarise(Mean = mean(xyz.sum)) %>% 
  dplyr::arrange(Mean) %>% 
  ggplot2::ggplot(mapping=aes(x=color, y=Mean)) +
  geom_bar(stat="identity")

# RStudio Cheatsheets : ��Ű�� ��ɵ� �� ���� �� �� ����
# KRUG : ���̽��� �׷� : R�� ���ؼ� �����ϰ� ���� ��
# R Conference Korea : R �м���
# �����;߳���(conference): R �����Ͼ�
# Kaggle
# RMarkdown