##runSOMs.r
#Emily Norton, 8/7/18
#This script can be used to systematically run and test various SOMs, 
#and then generate a graphical map output based on the codes produces

#clear any lingering objects
rm(list = ls(all = TRUE))
#clear any potentially interfering loaded packages
lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)

#Set the following options before running
setwd('/Users/emilynorton/Documents/FATE_Hunsicker_Bond_OcnAtmCoupling/')

#set dimensions for the som grid
sdim1 <- 3
sdim2 <- 2

#set shape of somgrid (options: 'hexagonal','rectangular')
sshape <- 'hexagonal'   


#option to set seed for reproducible results
set.seed(9)   

#set variable filenames to load - only has data for the sea points
slpsumfile <- 'SummerAvg_1948to2018_slp.csv'
slpwinfile <- 'WinterAvg_1948to2018_slp.csv'
sktsumfile <- 'SummerAvg_1948to2018_skt.csv'
sktwinfile <- 'WinterAvg_1948to2018_skt.csv'

#set grid filenames to load, with only lat/lon for the sea points
slplatfile <- 'slp_lat_sea.csv'
slplonfile <- 'slp_lon_sea.csv'
sktlatfile <- 'skt_lat_sea.csv'
sktlonfile <- 'skt_lon_sea.csv'


#Determine which plots you want to see
booCodes <- 'T'  #kohonen codes plot
booQuality <- 'T'   #kohonen quality plot
booCounts <- 'T'    #kohonen counts plot
booYearNode <- 'T'  #hovmoller-esque plot of year in each node
booGeoMap <- 'T'  #geographic map

##----------Shouldn't need to change too much below this line ----------------
#Load kohonen (load other packages later, right before we make plots.  
#Otherwise they disrupt some of the kohonen functions.)
library(kohonen)  #for SOMs


#Load csv files for summer- and winter-averaged Sea Level Pressure (slp) and Sea Surface Temp (skt=skin temp)
slpsum <- read.csv(slpsumfile, header = FALSE)
slpwin <- read.csv(slpwinfile, header = FALSE)
sktsum <- read.csv(sktsumfile, header = FALSE)
sktwin <- read.csv(sktwinfile, header = FALSE)

#Load grid files in as matrices, and the indices ('seainds') where the data are from
slpseaindsM <- as.matrix(read.csv('slp_seainds.csv', header = FALSE)) 
slplatvecM <-as.matrix(read.csv('slp_lat_vec.csv', header=FALSE))
slplonvecM <-as.matrix(read.csv('slp_lon_vec.csv', header=FALSE))

sktseaindsM <- as.matrix(read.csv('skt_seainds.csv', header = FALSE)) 
sktlatvecM <-as.matrix(read.csv('skt_lat_vec.csv', header=FALSE))
sktlonvecM <-as.matrix(read.csv('skt_lon_vec.csv', header=FALSE))


#Get SOMs for each of the sum/win data sets
som.slpsum <- som(scale(slpsum),grid=somgrid(sdim1,sdim2,sshape))
som.slpwin <- som(scale(slpwin),grid=somgrid(sdim1,sdim2,sshape))
som.sktsum <- som(scale(sktsum),grid=somgrid(sdim1,sdim2,sshape))
som.sktwin <- som(scale(sktwin),grid=somgrid(sdim1,sdim2,sshape))

#Get codes for each of the SOMs
codes.slpsum <-getCodes(som.slpsum)
codes.slpwin <-getCodes(som.slpwin)
codes.sktsum <-getCodes(som.sktsum)
codes.sktwin <-getCodes(som.sktwin)

write.table(codes.slpsum, file='codes_slpsum_SOM_080818.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(codes.slpwin, file='codes_slpwin_SOM_080818.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(codes.sktsum, file='codes_sktsum_SOM_080818.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(codes.sktwin, file='codes_sktwin_SOM_080818.csv', row.names=FALSE,col.names=FALSE,sep=',')

maps.slpsum <- map(som.slpsum)
maps.slpwin <- map(som.slpwin)
maps.sktsum <- map(som.sktsum)
maps.sktwin <- map(som.sktwin)

write.table(maps.slpsum$unit.classif, file='maps_unitclassif_slpsum_SOM.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(maps.slpwin$unit.classif, file='maps_unitclassif_slpwin_SOM.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(maps.sktsum$unit.classif, file='maps_unitclassif_sktsum_SOM.csv', row.names=FALSE,col.names=FALSE,sep=',')
write.table(maps.sktwin$unit.classif, file='maps_unitclassif_sktwin_SOM.csv', row.names=FALSE,col.names=FALSE,sep=',')

nodes <- sdim1*sdim2  #this is the number of nodes that all codes are grouped into


#Now begin making figures
#Make hovmoller-esque plot for what years were sorted into each node
if (booYearNode == 'T') {
source('plot_year_node_SOMs.r')
}

#Generate informational plots for kohonen
source('plot_kohonen_fig_SOMs.r')

#Generate geographic map of averaged codes for each node
if (booGeoMap == 'T') {
source('plot_geo_map_SOMs.r')
}
