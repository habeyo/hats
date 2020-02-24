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

library(datasets)
head(mtcars)
summary(mtcars)
str(mtcars)
plot(mtcars$hp, mtcars$cyl)
hist(mtcars$hp)
boxplot(mtcars$mpg)
