library(ggplot2)


### Efficiency by Channel

gchaneff <- ggplot(chan, aes(x=channel, y=eff, fill=channel)) + geom_bar(stat="identity") +  
  ggtitle(paste("Lift/Cost by Channel"))

### Efficiency by Fringe
geffwd <- ggplot(chtm[which(chtm$dtype == "wd"),], aes(fringe, channel)) + geom_tile(aes(fill = (lift_nv/ncost)*good), colour = "white") +
  scale_fill_gradient(low="red",high="green") + ggtitle(paste("WeekDay Efficiency",stamp))

geffwe <- ggplot(chtm[which(chtm$dtype == "we"),], aes(fringe, channel)) + geom_tile(aes(fill = (lift_nv/ncost)*good), colour = "white") +
  scale_fill_gradient(low="red",high="green") + ggtitle(paste("WeekEnd Efficiency",stamp))

## Bubbles


########### Day PLOT
dayplot <- "20141124"
gtime1 <- as.POSIXlt(paste(dayplot,"160000"),format="%Y%m%d %H%M%S")
gtime2 <- as.POSIXlt(paste(dayplot,"230000"),format="%Y%m%d %H%M%S")
index <- which(as.POSIXlt(v$tmstmp)==gtime1 | as.POSIXlt(v$tmstmp)==gtime2)
gtime<-ggplot(v[index[1]:index[2],], aes(tmstmp)) + 
  geom_line(aes(y = v$base_v[index[1]:index[2]]))+
  geom_line(aes(y = v$base_nv[index[1]:index[2]]))+
  geom_line(aes(y = v$base_b[index[1]:index[2]]))+
  geom_line(aes(y = visits,color="Total"))+
  geom_line(aes(y = branding,color="Branded"))+
  geom_line(aes(y = newvisits,color="New"))+
  geom_line(aes(y = rating*20, colour = "TRPs x 20")) +
  ylab("Visits per minute")+
  ggtitle(paste("TRPs & Visits (w/baselines)", toupper(country),dayplot))+
  xlab("Time")