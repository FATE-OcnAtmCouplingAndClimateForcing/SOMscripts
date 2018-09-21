#plot_year_node_SOMs.r 
#Generates a hovmoller-esque plot for plotting the node each year was sorted into

#Load in the node number for each year (i.e. maps$unit_classif) - generated in runSOMs.r
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
