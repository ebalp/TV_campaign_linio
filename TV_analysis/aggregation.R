library(plyr)

print("Channel Aggregation")
chanlift <- aggregate(lift~channel,data=spot,mean)
chancost <- aggregate(cost~channel,data=spot,mean)
chanrat <- aggregate(rating~channel,data=spot,mean)
chanliftsd <-aggregate(lift~channel,data=spot,sd,na.rm=TRUE)
names(chanliftsd) <- c("channel","liftsd")
chan <- merge(chanlift, chancost, by= "channel")
chan <- merge(chan, chanrat, by="channel")
chan <- merge(chan, chanliftsd, by = "channel")
chan$liftcost <- chan$lift/chan$cost
chan$liftgrp <- chan$lift/chan$rating
chan$grpcost <- chan$rating/chan$cost
chan$count <- count(spot, 'channel')$freq
suppressWarnings(chan$conflift <- qt(0.975,df=chan$count-1)*chan$liftsd/sqrt(chan$count))
suppressWarnings(chan$confprop <- chan$lift/(qt(0.975,df=chan$count-1)*chan$liftsd/sqrt(chan$count)))
suppressWarnings(chan$good <- 1/(chan$confprop>1.5)/(chan$count>4))
rm(chanlift,chancost,chanrat,chanliftsd)

print("Channel-Fringe Aggregation")
chanlift <- aggregate(lift~channel+fringe+dtype,data=spot,mean)
chancost <- aggregate(cost~channel+fringe+dtype,data=spot,mean)
chanrat <- aggregate(rating~channel+fringe+dtype,data=spot,mean)
chtmliftsd <-aggregate(lift~channel+fringe+dtype,data=spot,sd,na.rm=TRUE)
names(chtmliftsd) <- c("channel","fringe","dtype","liftsd")
chtm <- merge(chanlift, chancost, by=c("channel","fringe","dtype"))
chtm <- merge(chtm, chanrat, by=c("channel","fringe","dtype"))
chtm <- merge(chtm, chtmliftsd, by = c("channel","fringe","dtype"))
chtm$count <- count(spot, c('channel','fringe','dtype'))$freq
chtm$fringe <- factor(chtm$fringe, levels = c("E","D","P","L","O"))
suppressWarnings(chtm$conf <- (qt(0.975,df=chtm$count-1)*chtm$liftsd/sqrt(chtm$count)))
suppressWarnings(chtm$confprop <- chtm$lift/(qt(0.975,df=chtm$count-1)*chtm$liftsd/sqrt(chtm$count)))
suppressWarnings(chtm$good <- 1/(chtm$confprop>1)/(chtm$count>4))
rm(chanlift,chancost,chanrat,chtmliftsd)