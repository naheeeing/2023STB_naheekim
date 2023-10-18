#변수의이상치와결측치확인하고처리
summary(congestion)
#결측치개수확인
is.na(congestion)
sum(is.na(congestion))
colSums(is.na(congestion))
#6시출발기차의결측치를제거
congestion1 <-congestion[!is.na(congestion$s0600),]
colSums(is.na(congestion1))

#23시30분출발기차의결측치를제거
congestion1 <-congestion1[!is.na(congestion1$s2330),]
colSums(is.na(congestion1))

##남은결측치를0으로대체
congestion1[is.na(congestion1)] <-0
colSums(is.na(congestion1))
##이상치확인
ggplot(congestion1, aes(y=s0530))+  
geom_boxplot()
summary(congestion1$s0530)

#1.지하철역의하루평균혼잡도
congestion1$day_mean <-rowMeans(congestion1[,c('s0530','s0600','s0630','s0700','s0730','s0800','s0830','s0900','s0930','s1000','s1030','s1100','s1130','s1200','s1230','s1300','s1330','s1400','s1430','s1500','s1530','s1600','s1630','s1700','s1730','s1800','s1830','s1900','s1930','s2000','s2030','s2100','s2130','s2200','s2230','s2300','s2330')])

#2.지하철호선별퇴근시간(18:00~20:00)대의평균혼잡도

#3.08시지하철혼잡도범주화/범주별빈도분석