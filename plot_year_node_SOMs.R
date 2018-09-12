#plot_year_node_SOMs.r 
#Generates a hovmoller-esque plot for plotting the node each year was sorted into

#Set the number of nodes
#nodes = 6

#Load in the files with the maps$unit_classif (i.e. the node number for each year) - generated in mapSOMs.r
#slpsum_uclass <- as.matrix(read.csv('maps_unitclassif_slpsum_SOM.csv', header = FALSE)) 
#slpwin_uclass <- as.matrix(read.csv('maps_unitclassif_slpwin_SOM.csv', header = FALSE)) 
#sktsum_uclass <- as.matrix(read.csv('maps_unitclassif_sktsum_SOM.csv', header = FALSE)) 
#sktwin_uclass <- as.matrix(read.csv('maps_unitclassif_sktwin_SOM.csv', header = FALSE)) 

slpsum_uclass <- as.matrix(maps.slpsum$unit.classif) 
slpwin_uclass <- as.matrix(maps.slpwin$unit.classif) 
sktsum_uclass <- as.matrix(maps.sktsum$unit.classif) 
sktwin_uclass <- as.matrix(maps.sktwin$unit.classif) 

##-------------------Shouldn't need to change much below this line --------------------

slpsum_z <- matrix(data=NA,nrow=length(slpsum_uclass),ncol=nodes)
for (entry in c(1:length(slpsum_uclass))){
  slpsum_z[entry,slpsum_uclass[entry]]<-1
#  z[entry,maps.slpsum$unit.classif[entry]]<-maps.slpsum$unit.classif[entry]
}

slpwin_z <- matrix(data=NA,nrow=length(slpwin_uclass),ncol=nodes)
for (entry in c(1:length(slpwin_uclass))){
  slpwin_z[entry,slpwin_uclass[entry]]<-1
}

sktsum_z <- matrix(data=NA,nrow=length(sktsum_uclass),ncol=nodes)
for (entry in c(1:length(sktsum_uclass))){
  sktsum_z[entry,sktsum_uclass[entry]]<-1
}

sktwin_z <- matrix(data=NA,nrow=length(sktwin_uclass),ncol=nodes)
for (entry in c(1:length(sktwin_uclass))){
  sktwin_z[entry,sktwin_uclass[entry]]<-1
}


dev.new()
image(c(1:6),c(1948:2017),t(slpsum_z),ylim=c(2017,1948),col='black',ylab="Year (1948-2017)",xlab='Node',main='SLP Summer')

dev.new()
image(c(1:6),c(1949:2018),t(slpwin_z),ylim=c(2018,1949),col='black',ylab="Year (1949-2018)",xlab='Node',main='SLP Winter')

dev.new()
image(c(1:6),c(1948:2017),t(sktsum_z),ylim=c(2017,1948),col='black',ylab="Year (1948-2017)",xlab='Node',main='SKT Summer')

dev.new()
image(c(1:6),c(1949:2018),t(sktwin_z),ylim=c(2018,1949),col='black',ylab="Year (1949-2018)",xlab='Node',main='SKT Winter')


#plot(c(1:70),maps.slpsum$unit.classif,pch=22,col=c('green','red','blue','orange','yellow','pink'),bg='yellow',cex=1.2,lwd=2)
#plot(maps.slpsum$unit.classif,c(1:70),pch=22,col=c('black'),bg='green',cex=1.2,lwd=2)
#plot(c(1:70),maps.slpsum$unit.classif,pch=22,col=c('black'),bg='green',cex=1.2,lwd=2)