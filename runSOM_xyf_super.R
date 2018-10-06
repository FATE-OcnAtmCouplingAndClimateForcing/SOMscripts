##runSOM_xyf_super.r
#Emily Norton, 8/7/18
#This script uses the som, xyf, or (coming soon!) supersom function of the kohonen package to identify self-organizing maps
#for one, two, or three (or more!) variables at a time
#This program can be used to systematically run and test various SOMs, 
#and then generate several figures and/or map outputs based on the codes produced

#clear any lingering objects
rm(list = ls(all = TRUE))
#clear any potentially interfering loaded packages
lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)

#Set the following options before running
setwd('/Users/emilynorton/Documents/FATE_Hunsicker_Bond_OcnAtmCoupling/RScripts/')

#option to set seed for reproducible results
set.seed(9)   

# Set number of variables we're going to compare, and their grid sizes, "SLP" or "SKT" (if strictly timeseries var, it doesn't matter which one)
compsize <- 2   #1 = univariable "som", 2 = two co-variable "xyf", 3 = multivariable "supersom"

vargrid1 <- "SLP"
vargrid2 <- "SKT" 
vargrid3 <- "SKT"
  
#set variable filenames to load - only has data for the sea points
file1 <- '../BiologyData/goa.biology.pca.1965.2012.csv'
file2 <- '../PhysicalData/WinterAvg_1965to2012_skt.csv'
file3 <- "NA"

#set dimensions and weights for the som grid
sdim1 <- 3 
sdim2 <- 2

wei1 <- 1   #weight for var 1
wei2 <- 1   #weight for var 2

#set shape of somgrid (options: 'hexagonal','rectangular')
sshape <- 'hexagonal'   

#Determine which plots you want to make (and save?)
booCodes <- 'T'
booQuality <- 'T'
booCounts <- 'T'
booYearNode <- 'T'
booGeoMap <- 'T'

# Plot title name and name to save plots
title_name <- "SOM2 xyf of SKT and biolV1,V2 for 1965-2012"   
plot_fname <- "test_plots"

#Determine which variables you want to save as .csv files
saveCodes <- 'F'
saveMaps <- 'F'

# Code and map filenames
codes_fname <- 'codes_TEST.csv'
codes1_fname <- 'codes2_SOM2_xyf_biolV1andV2_withSKT_1965to2012.csv'
codes2_fname <- 'codes2_SOM2_xyf_SKT_withbiolV1andV2_1965to2012.csv'

map_fname = 'maps_unitclassif_SOM2_xyf_SKT_biolV1_v2_1965to2012.csv'


##----------Shouldn't need to change too much below this line ----------------
nodes <- sdim1*sdim2  #this is the number of nodes that all codes are grouped into

#Load kohonen package (load other packages later)
library(tidyverse)   #for dplyr and ggplot - load first because of conflicts
library(kohonen)  #for SOMs


#Load csv file(s) and grab only the values of interest for SOM comparison (i.e. not headers)

data1 <- read_csv(file1)
data1_forSOM <- data1 %>% 
  select(-year)

if (compsize > 1) {
  data2 <- read_csv(file2)
  data2_forSOM <- data2 %>% 
  select(-year)
} 

if (compsize > 2){
  data3 <- read_csv(file3)
  data3_forSOM <- data3 %>% 
    select(-year)
}

#set grid filenames to load, with only lat/lon for the sea points, and the indexing info for each point -NOTE: come back and fix this
slpseaindsfile <- '../PhysicalData/slp_seainds.csv' 
slplatvecfile <- '../PhysicalData/slp_lat_vec.csv'
slplonvecfile <- '../PhysicalData/slp_lon_vec.csv'

sktseaindsfile <- '../PhysicalData/skt_seainds.csv'
sktlatvecfile <- '../PhysicalData/skt_lat_vec.csv'
sktlonvecfile <- '../PhysicalData/skt_lon_vec.csv'

slpseainds <- as.matrix(read.csv(slpseaindsfile, header = FALSE)) 
slplatvec <-as.matrix(read.csv(slplatvecfile, header=FALSE))
slplonvec <-as.matrix(read.csv(slplonvecfile, header=FALSE))

sktseainds <- as.matrix(read.csv(sktseaindsfile, header = FALSE)) 
sktlatvec <-as.matrix(read.csv(sktlatvecfile, header=FALSE))
sktlonvec <-as.matrix(read.csv(sktlonvecfile, header=FALSE))
  

#Load grid files in as matrices, and the indices ('seainds') where the data are from - NOTE: come back and fix this
if (vargrid1 == 'SLP') {
seaindsM1 <- slpseainds
latvecM1 <- slplatvec
lonvecM1 <- slplonvec
} else if (vargrid1 == "SKT") {
seaindsM1 <- sktseainds
latvecM1 <- sktlatvec
lonvecM1 <- sktlonvec
}

if (compsize > 1) {
  if (vargrid2 == 'SLP') {
    seaindsM2 <- slpseainds
    latvecM2 <- slplatvec
    lonvecM2 <- slplonvec
  } else if (vargrid2 == "SKT") {
    seaindsM2 <- sktseainds
    latvecM2 <- sktlatvec
    lonvecM2 <- sktlonvec
  }
}

if (compsize > 2) {
  if (vargrid3 == 'SLP') {
    seaindsM3 <- slpseainds
    latvecM3 <- slplatvec
    lonvecM3 <- slplonvec
  } else if (vargrid3 == "SKT") {
    seaindsM3 <- sktseainds
    latvecM3 <- sktlatvec
    lonvecM3 <- sktlonvec
  }
}

#Run SOMs with 1 ("som"), 2 ("xyf"), or 3 or more variables ("supersom") taken into account together
if (compsize == 1) {
  som_out <- som(scale(data1_forSOM),grid=somgrid(sdim1,sdim2,sshape))
}

if (compsize == 2) {
  som_out <- xyf(X=scale(data1_forSOM),Y=scale(data2_forSOM),user.weights=c(1,1),grid=somgrid(sdim1,sdim2,sshape))
}

if (compsize == 3) {
  #supersom...coming soon
}

#Get codes for the SOM
codes_out <- getCodes(som_out)

#Get maps for the SOM
maps_out <- map(som_out)

##THIS NEEDS TO BE MODIFIED FOR THE LENGTH OF CODES... if two variables, then two lists, etc.

# Save codes and maps, if desired
if (saveCodes == 'T') {
  write.table(codes_out, file = codes_fname, row.names = FALSE, col.names = FALSE, sep = ',')
  #write.table(codes_out1, file = codes1_fname, row.names=FALSE,col.names=FALSE,sep=',')
#write.table(codes_out2, file = codes2_fname, row.names=FALSE,col.names=FALSE,sep=',')
}

if (saveMaps == 'T') {
write.table(maps_out$unit.classif, file = map_fname, row.names=FALSE,col.names=FALSE,sep=',')
}


#### Now begin making figures --------------------------------------
##Load libraries for making figures
#library(plotly)   #for plotting maps
library(maps)
library(mapproj)


#Make hovmoller-esque plot for what years were sorted into each node
if (booYearNode == 'T') {
    source('plot_year_node.r')
}

#Generate informational plots for kohonen
  source('plot_kohonen_fig.r')


#Generate geographic map of averaged codes for each node
if (booGeoMap == 'T') {
    source('plot_geo_map.r')
}
