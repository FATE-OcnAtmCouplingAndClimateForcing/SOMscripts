##runSOMs2_xyf.r
#Emily Norton, 8/7/18
#This script uses the xyf function of the kohonen package to use two variables when running a self-organizing map 
#This program can be used to systematically run and test various SOMs, 
#and then generate a several figures and/or map outputs based on the codes produced

#clear any lingering objects
rm(list = ls(all = TRUE))
#clear any potentially interfering loaded packages
lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)

#Set the following options before running
setwd('/Users/emilynorton/Documents/FATE_Hunsicker_Bond_OcnAtmCoupling/RScripts/')

#set dimensions and weights for the som grid
sdim1 <- 3 
sdim2 <- 2

wei1 <- 1   #weight for slp
wei2 <- 1   #weight for skt


#set shape of somgrid (options: 'hexagonal','rectangular')
sshape <- 'hexagonal'   

#option to set seed for reproducible results
set.seed(9)   

#set variable filenames to load - only has data for the sea points
slpsumfile <-'../PhysicalData/SummerAvg_1948to2018_slp.csv'
slpwinfile <- '../PhysicalData/WinterAvg_1948to2018_slp.csv'
sktsumfile <- '../PhysicalData/SummerAvg_1948to2018_skt.csv'
sktwinfile <- '../PhysicalData/WinterAvg_1948to2018_skt.csv'

#set grid filenames to load, with only lat/lon for the sea points, and the indexing info for each point
slpseaindsfile <- '../PhysicalData/slp_seainds.csv' 
slplatvecfile <- '../PhysicalData/slp_lat_vec.csv'
slplonvecfile <- '../PhysicalData/slp_lon_vec.csv'

sktseaindsfile <- '../PhysicalData/skt_seainds.csv'
sktlatvecfile <- '../PhysicalData/skt_lat_vec.csv'
sktlonvecfile <- '../PhysicalData/skt_lon_vec.csv'

#Determine which plots you want to make
booCodes <- 'T'
booQuality <- 'T'
booCounts <- 'T'
booYearNode <- 'T'
booGeoMap <- 'T'


#Determine which variables you want to save as .csv files
saveCodes <- 'T'
saveMaps <- 'T'
##Add filenames to save to here...!


##----------Shouldn't need to change too much below this line ----------------
nodes <- sdim1*sdim2  #this is the number of nodes that all codes are grouped into

#Load kohonen package (load other packages later)
library(kohonen)  #for SOMs


#Load csv files for summer- and winter-averaged Sea Level Pressure (slp) and Sea Surface Temp (skt=skin temp)
slpsum <- read.csv(slpsumfile, header = FALSE)
slpwin <- read.csv(slpwinfile, header = FALSE)
sktsum <- read.csv(sktsumfile, header = FALSE)
sktwin <- read.csv(sktwinfile, header = FALSE)

#Load grid files in as matrices, and the indices ('seainds') where the data are from
slpseaindsM <- as.matrix(read.csv(slpseaindsfile, header = FALSE)) 
slplatvecM <-as.matrix(read.csv(slplatvecfile, header=FALSE))
slplonvecM <-as.matrix(read.csv(slplonvecfile, header=FALSE))

sktseaindsM <- as.matrix(read.csv(sktseaindsfile, header = FALSE)) 
sktlatvecM <-as.matrix(read.csv(sktlatvecfile, header=FALSE))
sktlonvecM <-as.matrix(read.csv(sktlonvecfile, header=FALSE))


#Get SOMs ('som2') with two variables taken into account together
som2.slpsktsum <- xyf(X=scale(slpsum),Y=scale(sktsum),user.weights=c(1,1),grid=somgrid(sdim1,sdim2,sshape))
som2.slpsktwin <- xyf(X=scale(slpwin),Y=scale(sktwin),user.weights=c(1,1),grid=somgrid(sdim1,sdim2,sshape))

#Get codes for each of the SOMs
codes.slpsktsum <-getCodes(som2.slpsktsum)
codes.slpsktwin <-getCodes(som2.slpsktwin)

codes2.slpsum <- codes.slpsktsum[[1]]
codes2.sktsum <- codes.slpsktsum[[2]]
codes2.slpwin <- codes.slpsktwin[[1]]
codes2.sktwin <- codes.slpsktwin[[2]]

if (saveCodes == 'T') {
write.table(codes2.slpsum, file='codes2_slpsum_SOM2_092118.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(codes2.slpwin, file='codes2_slpwin_SOM2_092118.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(codes2.sktsum, file='codes2_sktsum_SOM2_092118.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(codes2.sktwin, file='codes2_sktwin_SOM2_092118.csv', row.names=FALSE,col.names=FALSE,sep=',')
}

maps.slpsktsum <- map(som2.slpsktsum)
maps.slpsktwin <- map(som2.slpsktwin)

if (saveMaps == 'T') {
write.table(maps.slpsktsum$unit.classif, file='maps_unitclassif_slpsktsum_SOM2_xyf_092118.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(maps.slpsktwin$unit.classif, file='maps_unitclassif_slpsktwin_SOM2_xyf_092118.csv', row.names=FALSE,col.names=FALSE,sep=',')
}



##Load libraries for making figures
#library(plotly)   #for plotting maps
library(maps)
library(mapproj)

#Now begin making figures
#Make hovmoller-esque plot for what years were sorted into each node
if (booYearNode == 'T') {
  source('plot_year_node_xyf.r')
}

#Generate informational plots for kohonen
source('plot_kohonen_fig_xyf.r')

#Generate geographic map of averaged codes for each node
if (booGeoMap == 'T') {
  source('plot_geo_map_xyf.r')
}
