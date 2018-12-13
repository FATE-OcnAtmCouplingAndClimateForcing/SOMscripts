#plot_geo_map.r
#Plots geographic maps of codes for each node, called in parent script runSOM2_xyf.r
library('RColorBrewer')
source('filled_contour3.R')
source('filled_legend.R')

# Get codes for each variable
if (compsize == 1) {
codes_out1 <- codes_out
} 
if (compsize == 2 ) {
  codes_out1 <- codes_out[[1]]
  codes_out2 <- codes_out[[2]]
} 
if (compsize == 3) {
  codes_out1 <- codes_out[[1]]
  codes_out2 <- codes_out[[2]]
  codes_out3 <- codes_out[[3]]
}
if (compsize == 4) {
  codes_out1 <- codes_out[[1]]
  codes_out2 <- codes_out[[2]]
  codes_out3 <- codes_out[[3]]
  codes_out4 <- codes_out[[4]]
}

# Make plots for each variable (if the variable isn't spatially explicit, this won't make sense, but that's okay) - try later with ggplot??
zmax <- max(abs(min(codes_out1)),max(codes_out1))
zmin <- -zmax
dev.new()
#par(mfrow=c(sdim2,sdim1))
par(mfrow=c(sdim2,sdim1),
    oma = c(5,4,0,0) + 0.1,
    mar = c(0,0,1,1) + 0.1)
  for (node in c(1:nodes)){
#    dummy <- matrix(data=NA,nrow=length(lonvecM1),ncol=length(latvecM1))
    dummyT <- matrix(data=NA,nrow=length(latvecM1),ncol=length(lonvecM1))
    dummyT[seaindsM1]<-codes_out1[node,]
    dummy <- t(dummyT)
          filled.contour3(x=lonvecM1, y=latvecM1, dummy, xlim=c(lonmin,lonmax), ylim=c(latmin,latmax), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste(sprintf('%s', grids[1]), 'node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=lonvecM1, y=latvecM1[order(latvecM1)], dummy, xlim=c(lonmin,lonmax), ylim=c(latmax,latmin),  zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu'))) 

if (compsize > 1) {
  zmax <- max(abs(min(codes_out2)),max(codes_out2))
  zmin <- -zmax
dev.new()
#par(mfrow=c(sdim2,sdim1))
par(mfrow=c(sdim2,sdim1),
    oma = c(5,4,0,0) + 0.1,
    mar = c(0,0,1,1) + 0.1)
  for (node in c(1:nodes)){
    dummyT <- matrix(data=NA,nrow=length(latvecM2),ncol=length(lonvecM2))
    dummyT[seaindsM2]<-codes_out2[node,]
    dummy <- t(dummyT)
      filled.contour3(x=lonvecM2, y=latvecM2, dummy, xlim=c(lonmin,lonmax), ylim=c(latmin,latmax), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste(sprintf('%s', grids[2]), 'node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=lonvecM2, y=latvecM2[order(latvecM2)], dummy, xlim=c(lonmin,lonmax), ylim=c(latmax,latmin), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  
}

if (compsize > 2) {
  zmax <- max(abs(min(codes_out3)),max(codes_out3))
  zmin <- -zmax
  dev.new()
  #par(mfrow=c(sdim2,sdim1))
  par(mfrow=c(sdim2,sdim1),
      oma = c(5,4,0,0) + 0.1,
      mar = c(0,0,1,1) + 0.1)
  for (node in c(1:nodes)){
    dummyT <- matrix(data=NA,nrow=length(latvecM3),ncol=length(lonvecM3))
    dummyT[seaindsM3]<-codes_out3[node,]
    dummy <- t(dummyT)
      filled.contour3(x=lonvecM3, y=latvecM3, dummy, xlim=c(lonmin,lonmax), ylim=c(latmin,latmax), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste(sprintf('%s', grids[3]), 'node', node))  #this works, but doesn't mask out the land
  }
  par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
  filled.legend(x=lonvecM3, y=latvecM3[order(latvecM3)], dummy, xlim=c(lonmin,lonmax), ylim=c(latmax,latmin), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  
  }
  
if (compsize > 3) {
  zmax <- max(abs(min(codes_out4)),max(codes_out4))
  zmin <- -zmax
  dev.new()
  #par(mfrow=c(sdim2,sdim1))
  par(mfrow=c(sdim2,sdim1),
      oma = c(5,4,0,0) + 0.1,
      mar = c(0,0,1,1) + 0.1)
  for (node in c(1:nodes)){
    dummyT <- matrix(data=NA,nrow=length(latvecM4),ncol=length(lonvecM4))
    dummyT[seaindsM4]<-codes_out4[node,]
    dummy <- t(dummyT)
      filled.contour3(x=lonvecM4, y=latvecM4, dummy, xlim=c(lonmin,lonmax), ylim=c(latmin,latmax), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste(sprintf('%s', grids[4]), 'node', node))  #this works, but doesn't mask out the land
  }
  par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
  filled.legend(x=lonvecM4, y=latvecM4[order(latvecM4)], dummy, xlim=c(lonmin,lonmax), ylim=c(latmax,latmin), zlim=c(zmin,zmax), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  
}
