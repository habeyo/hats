# HOW TO CREATE and open git using R-STUDIO
# CREATE GITHUB ACCOUNT THEN from The CLONE DOWNLOAD SECTION COPY THE URL
# THEN OPEN r-studio from file=> createproject=>VERSIONCONTROL=> AND PUT THE 
# COPPIED URL EG(https://github.com/habeyo/hats.git)
# THEN FROM FILE=> NEWFILE=RSCRIPT=> WRITE SOME TIHING AND SAVE IT AS r file
# then how do we upload this created file to github?
# tools=>versioncontrol=>commit=> and select the files you want to commit=> and take to
# the github repository => then write some messeges if ypu want and hit commit
#a new messege will apear says 2 files changed...etc and close it
# then hit push  after some procesecess it will end and you close it
# finaly when you go to your github account and refresh it the changes you made from R-STUIDO WILL APPEAR IN THE GIT HUB REPOSITORY 

# the github repository




# to install new library , eg package tidyverse 
install.packages('tidyverse')
# or if the library is already in the packages list and load it
library(tidyverse)
load('flights.rda')
names(flights)
# data manuplation using dplyr()=>filter(),arrange(),select(),mutate(),summarise()
# all the above can be used with conjunction with group_by()
# eg we filter the df flights on january 1st with delaytime > 30 minutes
# to use filter effectively you need to know the comparison operators (>,>=,!=(notequal) etc)
filter(flights,month==1,day==1, arr_delay>=30)
# if you want to save it in to a new df
jan30mindelay<-filter(flights,month==1,day ==1,arr_delay>=30)

# logical operators(y & !x = y and not x),(x|y= x or y),(x&y= x and y),

# find all flights that departed in nov. or dec.
filter(flights,month==11 | month ==12)
# x % in % y this will select every row where x is one of the values in y
nov_dec<- filter(flights,month %in% c(11,12))

# eg select the flights that were not delayed in arrival or departure by more than 2 hrs
filter(flights,!(arr_delay>120 | dep_delay >120))
filter(flights,arr_delay<=120, dep_delay <=120)

#departed in summer
summer<-filter(flights,month ==7 | month ==8 | month ==9 )
summer<-filter(flights, month %in% c(7,8,9))

# flew to houston (IAH, HOU)
IAH_HOU<-Filter(flights, as.character(dest=='IAH') | as.character (dest =='HOU'))
IAH<-Filter(flights,as.character(flights$dest)=='IAH')
IAH<- Filter(flights, as.characterd(dest))

#arrived more than 2hrs late but did not leave late
arr_late<-filter(flights, flights$arr_delay >120 & flights$dep_delay==0)
# missing Values
is.na(flights)
is.na(head(flights))

# arrival delayed by more than 1 hr, and made up over 30 minutes in flight.
delby1hour<-filter(flights,arr_delay > 60 & air_time>=30)

# departed between midnight and 6am inclusive
depbn12en6<-filter(flights,dep_time<=2400 & dep_time>=600)
depbn12en6[between(depbn12en6,month,7,9)]

# arrange() is similar to filter,
arrange(flights,desc(dep_delay))
# sort flights with the most delayed flights
mostdelayed<- arrange(flights,desc(arr_delay))

# which flights traveled the farthest?
farthest<-arrange(flights,desc(distance))
# highest speed kmhr
kmhr<-flights$distance/flights$hour+(flights$minute/60)
flightskmr<-data.frame(flights,kmhr)
head(flightskmr)
fastest<-arrange(flightskmr,desc(kmhr))

# select columns with select()
# select columns by name eg
select(flights,year,month,day)

# select all column names between year and dep_delay
select(flights,year : dep_delay)

# select all colomns except the col in negative brackets
select(flights,-(year : day))

#select columns with the help of helper functions eg

select(flights,contains('dep'))

# selects from year to day and all the colomns with 'dep' , select var that starts with 'dep'
select(flights,year : day, contains('tim'))
select(flights,year, starts_with('dep'))

# to rename a column name(tailnum) by tail_num we use rename
flights1<-rename(flights, tail_num = tailnum)

# if you like to bring some variables in the first and then the rest
select(flights, time_hour,air_time, everything())


# adding new variable with mutate
flights_sml <-select(flights, year:day,ends_with('delay'),distance,air_time)
flights_sml<-mutate(flights_sml, gain= dep_delay - arr_delay, speed= distance/air_time*60)
# if you like to retain only the new variables
transmute(flights_sml,gain =dep_delay -arr_delay, hours= air_time/60, gain_phr= gain/hours)

# grouped summaries with summarise() => this colapses a df in to a single row. it helps most when 
# it is used with a group_by()

by_day<- group_by(flights,year,month,day)
summarise(by_day,delay=mean(dep_delay,na.rm = TRUE))

# combining multiple operations with pipe

# 3-steps for this graph
#1. group flight by destination ,# 2 summarise to compute distance,average delay and number of flights
#3 filter to remove noisy points and hanolulu, which is twice as the distance as the next closest airport
by_dest<-group_by(flights,dest)
delay<-summarise(by_dest,
count= n(),
dist=mean(distance,na.rm = TRUE),
delay=mean(arr_delay,na.rm = TRUE)
)
delay<-filter(delay,count>20, dest !='HNL')

# using pip
delays<- flights%>%
  group_by(dest) %>%
  summarise(
    count=n(),
    dist=mean(dist,na.rm = TRUE),
    delay=mean(arr_delay,na.rm = TRUE)
  )%>%
  filter(count>20, dest!='HNL')
    


ggplot(data = delay, mapping = aes(x=dist, y= delay))+ geom_point(aes(size= count),alpha =1/3) +geom_smooth(se=FALSE)


library(datasets)
head(mtcars)
summary(mtcars)
str(mtcars)
plot(mtcars$hp, mtcars$cyl)
hist(mtcars$hp)
boxplot(mtcars$mpg)
