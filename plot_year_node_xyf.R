#plot_year_node_xyf.r 
#Generates a hovmoller-esque plot for plotting the node each year was sorted into

#Set the number of nodes
#nodes = 6

#Load in the files with the maps$unit_classif (i.e. the node number for each year) - generated in mapSOMs.r
slpsktsum_uclass <- as.matrix(read.csv('maps_unitclassif_slpsktsum_SOM2_xyf.csv', header = FALSE)) 
slpsktwin_uclass <- as.matrix(read.csv('maps_unitclassif_slpsktwin_SOM2_xyf.csv', header = FALSE)) 


##-------------------Shouldn't need to change much below this line --------------------

slpsktsum_z <- matrix(data=NA,nrow=length(slpsktsum_uclass),ncol=nodes)
for (entry in c(1:length(slpsktsum_uclass))){
  slpsktsum_z[entry,slpsktsum_uclass[entry]]<-1
  #  z[entry,maps.slpsum$unit.classif[entry]]<-maps.slpsum$unit.classif[entry]
}

slpsktwin_z <- matrix(data=NA,nrow=length(slpsktwin_uclass),ncol=nodes)
for (entry in c(1:length(slpsktwin_uclass))){
  slpsktwin_z[entry,slpsktwin_uclass[entry]]<-1
}



dev.new()
image(c(1:6),c(1948:2017),t(slpsktsum_z),ylim=c(2017,1948),col='black',ylab="Year (1948-2017)",xlab='Node',main='SLP/SKT Summer')

dev.new()
image(c(1:6),c(1949:2018),t(slpsktwin_z),ylim=c(2018,1949),col='black',ylab="Year (1949-2018)",xlab='Node',main='SLP/SKT Winter')




#plot(c(1:70),maps.slpsum$unit.classif,pch=22,col=c('green','red','blue','orange','yellow','pink'),bg='yellow',cex=1.2,lwd=2)
#plot(maps.slpsum$unit.classif,c(1:70),pch=22,col=c('black'),bg='green',cex=1.2,lwd=2)
#plot(c(1:70),maps.slpsum$unit.classif,pch=22,col=c('black'),bg='green',cex=1.2,lwd=2)