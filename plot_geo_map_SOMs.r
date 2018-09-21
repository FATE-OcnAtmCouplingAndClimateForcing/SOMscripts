#plot_geo_map_SOMs.r
#Plots geographic maps of codes for each node, called in parent script runSOMs.r

#require(grDevices)
library('RColorBrewer')
source('filled_contour3.R')
source('filled_legend.R')

dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes.sktsum[node,]
    filled.contour3(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Summer SST, node', node))  #this works, but doesn't mask out the land
    #    filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,300), ylim=c(60,20), zlim=range(dummy,finite=TRUE), levels=pretty(zlim,nlevels), nlevels=10, map(add=TRUE, interior=FALSE))  
    #   filled.contour(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20), plot.axes={axis(1);axis(2);par(usr=c(120,240,20,60));map(add=TRUE,fill=TRUE); par(usr=c(-240,-120,20,60));map(projection="",add=TRUE,fill=TRUE)})  #plot western and easter hemis separately  
    # image(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20))
    # map(add=TRUE)
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))

  
dev.new()
par(mfrow=c(sdim2,sdim1))
for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=73,ncol=23)
    dummy[sktseaindsM]<-codes.sktwin[node,]
    filled.contour3(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Winter SST, node', node))  #this works, but doesn't mask out the land
}
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=sktlonvecM, y=rev(sktlatvecM), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))


  
dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes.slpsum[node,]
    filled.contour3(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Summer SLP, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  


dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=55,ncol=19)
    dummy[slpseaindsM]<-codes.slpwin[node,]
    filled.contour3(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Winter SLP, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=slplonvecM, y=rev(slplatvecM), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  




#contour(x=sktlonvec[,1], y=rev(sktlatvec[,1]), sktsumavgM, ylim=c(60,20))  #can reverse the ylim to make up for reversing the latitudinal (y) data
#filled.contour(x=sktlonvec[,1], y=rev(sktlatvec[,1]), sktsumavgM, ylim=c(60,20), nlevels=10)  
#filled.contour(x=sktlonvecM, y=rev(sktlatvecM), sktsumavgM, ylim=c(60,20), nlevels=10)  
#filled.contour(x=sktlonvecM, y=rev(sktlatvecM), test, ylim=c(60,20), nlevels=10)  