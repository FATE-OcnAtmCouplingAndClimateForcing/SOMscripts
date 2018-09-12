#plot_geo_map_SOMs.r
#Plots geographic maps of codes for each node, called in parent script runSOMs.r



  #  par(mfrow=c(sdim2,sdim1))  #apparently filled.contour doesn't allow multiple plots on one page - could try filled.contour2 or 3
  #  par(mar=c(0,0,0,0), oma=c(1,1,1,1))
  #    dev.new()
  for (node in c(1:nodes)){
    #   for (node in 1){
    #      par(mfrow=c(sdim2,sdim1))
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes.sktsum[node,]
    filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Summer SST, node', node))  #this works, but doesn't mask out the land
    #    filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,300), ylim=c(60,20), zlim=range(dummy,finite=TRUE), levels=pretty(zlim,nlevels), nlevels=10, map(add=TRUE, interior=FALSE))  
    #   filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20), plot.axes={axis(1);axis(2);par(usr=c(120,240,20,60));map(add=TRUE,fill=TRUE); par(usr=c(-240,-120,20,60));map(projection="",add=TRUE,fill=TRUE)})  #plot western and easter hemis separately  
    # image(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20))
    # map(add=TRUE)
    rm(dummy)
  }
  
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes.sktwin[node,]
    filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Winter SST, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes.slpsum[node,]
    filled.contour(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Summer SLP, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  
  for (node in c(1:nodes)){
    dev.new()   #change this later so that all plots are happening on the same fig - adjust using par()
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes.slpwin[node,]
    filled.contour(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  nlevels=10, main=paste('Winter SLP, node', node))  #this works, but doesn't mask out the land
    rm(dummy)
  }
  




#contour(x=sktlonvec[,1], y=rev(sktlatvec[,1]), sktsumavgM, ylim=c(60,20))  #can reverse the ylim to make up for reversing the latitudinal (y) data
#filled.contour(x=sktlonvec[,1], y=rev(sktlatvec[,1]), sktsumavgM, ylim=c(60,20), nlevels=10)  
#filled.contour(x=sktlonvecM, y=rev(sktlatvecM), sktsumavgM, ylim=c(60,20), nlevels=10)  
#filled.contour(x=sktlonvecM, y=rev(sktlatvecM), test, ylim=c(60,20), nlevels=10)  