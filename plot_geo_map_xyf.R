#plot_geo_map_xyf.r
#Plots geographic maps of codes for each node, called in parent script runSOM2_xyf.r
library('RColorBrewer')
source('filled_contour3.R')
source('filled_legend.R')

dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes2.sktsum[node,]
    filled.contour3(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Summer SST, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))


dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes2.sktwin[node,]
    filled.contour3(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Winter SST, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu'))) 


dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes2.slpsum[node,]
    filled.contour3(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Summer SLP, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  

dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes2.slpwin[node,]
    filled.contour3(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Winter SLP, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  
