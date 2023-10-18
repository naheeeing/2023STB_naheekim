str(subway)
summary(subway)
subway$day<-substr(subway$Date,7,8)
subway$day<-as.integer(subway$day)
table(subway$Line)
subway$Line<-ifelse(subway$Line=="9호선2~3단계","9호선",subway$Line)
table(subway$Station)
#파생변수4.총승하차승객수total_passenger
subway$total_passenger<-subway$on_board+subway$getting_off
#분석데이터최종확인
str(subway)
#데이터 확인
#1.지하철역의하루평균승차/하차승객수
subway%>%  summarise(on_m=mean(on_board), off_m=mean(getting_off))
#승차승객이가장많았던역
#2-1 solution
max(subway$on_board)
subway%>%
  filter(on_board==94732)%>%
  select(Date, Line, Station, on_board)
20221216 2호선 잠실(송파구청)    94732
#하루평균전체승객수가많은역(10개중상위3개의 역)
passenger10<-subway %>%
 group_by(Station)%>%
  summarise(m=mean(total_passenger))%>%
  arrange(desc(m))%>%
  head(10)
head(passenger10, 3)
1 강남           148890.
2 삼성(무역센터) 109113.
3 구로디지털단지 108253.

#12월중에전체승객이가장많았던날짜3개
subway %>%
  group_by(Date) %>%
  summarise(total=sum(total_passenger)) %>%
  arrange(desc(total)) %>%
  head(3)
Date    total
<dbl>    <dbl>
  1 20221221 15699271
2 20221216 15695660
3 20221209 15623399
#1호선에서하루평균전체승객이가장많았던역과요일, 승차승객수, 하차승객수, 전체승객수
subway %>%
  filter(Line=="1호선") %>%
  filter(total_passenger==max(total_passenger)) %>%
  select(Date, Station, on_board, getting_off, total_passenger)
#전체지하철노선에서전체승객비율이높은노선
line_pct<-subway %>%
  group_by(Line) %>%
  summarise(total=sum(total_passenger)) %>%
  mutate(all=sum(total), pct=round(total/all*100,2))
line_pct%>%
  arrange(desc(pct)) %>%head(3)
Line     total       all   pct
<chr>    <dbl>     <dbl> <dbl>
  1 2호선 83322218 411586147 20.2 
2 5호선 38034569 411586147  9.24
3 7호선 34038397 411586147  8.27

#지하철 전체 승객 비율 막대그래프 그리기
line_pct10 <-line_pct%>%
  filter(Line%in%c("1호선","2호선","3호선","4호선","5호선","6호선","7호선","8호선","9호선","분당선" ))
ggplot(data = line_pct10, aes(x=reorder(Line,pct),y=pct))+
  geom_col()+
  coord_flip()+
  ggtitle("수도권지하철노선별이용비율")+
  xlab("노선")+
  ylab("이용비율")
#일별별전체승객수를선그래프
line_graph<-subway %>%
  group_by(day) %>%
  summarise(s=sum(total_passenger))
ggplot(data = line_graph, aes(x=day, y=s, group=1))+
  geom_line()+
  ggtitle("수도권지하철일별이용승객수")+
  xlab("일")+
  ylab("이용승객")


