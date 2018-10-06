#plot_geo_map.r
#Plots geographic maps of codes for each node, called in parent script runSOM2_xyf.r
library('RColorBrewer')
source('filled_contour3.R')
source('filled_legend.R')

# Get codes for each variable
if (compsize == 1) {
codes_out1 <- codes_out
} else if (compsize > 1) {
  codes_out1 <- codes_out[[1]]
  codes_out2 <- codes_out[[2]]
} else if (compsize > 2) {
  codes_out3 <- codes_out[[3]]
}

# Make plots for each variable (if the variable isn't spatially explicit, this won't make sense)
dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=length(lonvecM1),ncol=length(latvecM1))
    dummy[seaindsM1]<-codes_out1[node,]
    filled.contour3(x=lonvecM1, y=rev(latvecM1), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Var 1, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=lonvecM1, y=rev(latvecM1), dummy, xlim=c(120,240), ylim=c(60,20),  zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu'))) 


if (compsize > 1) {
dev.new()
par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=length(lonvecM2),ncol=length(latvecM2))
    dummy[seaindsM2]<-codes_out2[node,]
    filled.contour3(x=lonvecM2, y=rev(latvecM2), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Var 2, node', node))  #this works, but doesn't mask out the land
  }
par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
filled.legend(x=lonvecM2, y=rev(latvecM2), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  
}

if (compsize > 2) {
  dev.new()
  par(mfrow=c(sdim2,sdim1))
  for (node in c(1:nodes)){
    dummy <- matrix(data=NA,nrow=length(lonvecM3),ncol=length(latvecM3))
    dummy[seaindsM3]<-codes_out3[node,]
    filled.contour3(x=lonvecM3, y=rev(latvecM3), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')), main=paste('Var 3, node', node))  #this works, but doesn't mask out the land
  }
  par(new = "TRUE",plt = c(0.85,0.9,0.25,0.85),las = 1,cex.axis = 1)
  filled.legend(x=lonvecM3, y=rev(latvecM3), dummy, xlim=c(120,240), ylim=c(60,20), zlim=c(-2.5,2.5), nlevels=10, col = rev(brewer.pal(n=10,name='RdBu')))  
}
