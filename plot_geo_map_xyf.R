#plot_geo_map_xyf.r
#Plots geographic maps of codes for each node, called in parent script runSOM2_xyf.r


if (booGeoMap == 'T') {
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes2.sktsum[node,]
    filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Summer SST, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes2.sktwin[node,]
    filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Winter SST, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes2.slpsum[node,]
    filled.contour(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Summer SLP, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes2.slpwin[node,]
    filled.contour(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Winter SLP, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  
}