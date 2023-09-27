# table()함수/구분 1개의 인자를 가지고 도수분포표 작성
table(K $진출대륙명)

# table()함수/2개의 인자를 가지고 교차표를 작성
table(K $진출대륙명, K $진출형태)

#  상대도수 계산
ECN <- table(K $진출대륙명)
prop.table(ECN)

#막대그래프
barplot(table(K $진출대륙명))

entry <- table(K $진출대륙명, K $진출형태)
barplot(entry, legend = TRUE)

#파이차트
pie(table(K $진출대륙명))
pie(table(K $투자형태))