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

# Set number of variables we're going to compare 
compsize <- 4   #1 = univariable "som", 2 = two co-variable "xyf", 3 or more = multivariable "supersom"

#set variable filenames to load - only has data for the sea points
#NOTE: these files must contain headers and 'year' column, and must *at least* contain the temporal range of interest
#file1 <- '../BiologyData/goa.biology.pca.1965.2012.csv'        # Contains V1 and V2
file1 <- '../BiologyData/goa.biology.pca.1965.2012_V1only.csv'  # Contains V1 only
#file1 <- '../PhysicalData/MonthlyAverages/MonthlyAvg11to3_forYears1948to2018_hgt.csv'     # Geopotential height at 200mbar (hPa)
file2 <- '../PhysicalData/MonthlyAverages/MonthlyAvg11to3_forYears1948to2018_skt.csv'     # Skin Temp
file3 <- '../PhysicalData/MonthlyAverages/MonthlyAvg11to1_forYears1948to2018_slp.csv'     # Sea Level Pressure
#file4 <- '../PhysicalData/pdo_1900to2018_FebtoApr_avg.csv'     # PDO averaged Feb to Apr
file4 <- '../PhysicalData/npgo_1950to2018_FebtoApr_avg.csv'     # NPGO averaged Feb to Apr

# Set variable grid sizes: "SLP"/"HGT" (both same grid) or "SKT". If strictly timeseries var (e.g. biol V1), it doesn't matter what you choose - the slp grid will be used - so just use the variable name
vargrid1 <- "biolV1"
vargrid2 <- "SKT" 
vargrid3 <- "SLP"
vargrid4 <- "npgo"

# Set temporal range of interest  **THIS IS NEW!! And allows you to re-use input files with longer temporal ranges
yearmin <- 1965
yearmax <- 2012

#set dimensions for the som grid (2D) and shape of somgrid (options: 'hexagonal','rectangular')
sdim1 <- 3 
sdim2 <- 2
sshape <- 'hexagonal' 

# set relative weights for each variable (up to 4 variables)
wei1 <- 1   #weight for var 1
wei2 <- 1   #weight for var 2
wei3 <- 1   #weight for var 3
wei4 <- 1   #weight for var 4


# Which types of plots do you want to make? 
booCodes <- 'T'
booQuality <- 'T'
booCounts <- 'T'
booYearNode <- 'T'
booGeoMap <- 'T'

# Plot title name and name to save plots
title_name <- "Test superSOM of HGT, SKT, SLP for 1948-2018"   
plot_fname <- "test_plots"

#Do you want to save SOM codes or maps as .csv files?
saveCodes <- 'T'
saveMaps <- 'T'

# Code and map filenames  ###COME BACK TO THIS>>>need to save depending on number of vars, etc.
codes1_fname <- sprintf("codes_SOM_%iby%i%sgrid_%ito%iyears_%s.csv", sdim1, sdim2, sshape, yearmin, yearmax, vargrid1)
codes2_fname <- sprintf("codes_SOM_%iby%i%sgrid_%ito%iyears_%s.csv", sdim1, sdim2, sshape, yearmin, yearmax, vargrid2)
codes3_fname <- sprintf("codes_SOM_%iby%i%sgrid_%ito%iyears_%s.csv", sdim1, sdim2, sshape, yearmin, yearmax, vargrid3)
codes4_fname <- sprintf("codes_SOM_%iby%i%sgrid_%ito%iyears_%s.csv", sdim1, sdim2, sshape, yearmin, yearmax, vargrid4)

varnames <- paste(c(vargrid1, vargrid2, vargrid3, vargrid4),collapse="_")
map_fname = sprintf("maps_unitclassif_SOM_%iby%i%sgrid_%ito%iyears_%s.csv", sdim1, sdim2, sshape, yearmin, yearmax, varnames)


##----------Shouldn't need to change too much below this line ----------------
nodes <- sdim1*sdim2  #this is the number of nodes that all codes are grouped into

#Load kohonen package (load other packages later)
library(tidyverse)   #for dplyr and ggplot - load first because of conflicts
library(kohonen)  #for SOMs


#Load csv file(s) and grab only the values of interest for SOM comparison (i.e. not headers)

data1 <- read_csv(file1)
data1_forSOM <- data1 %>%   #get rid of year column...may want to prepare in other ways, e.g. make sure all of the same years are used for both files, etc.
  filter(year <= yearmax, year >= yearmin) %>%
  select(-year)

if (compsize > 1) {
  data2 <- read_csv(file2)
  data2_forSOM <- data2 %>% 
    filter(year <= yearmax, year >= yearmin) %>%
    select(-year)
} 

if (compsize > 2){
  data3 <- read_csv(file3)
  data3_forSOM <- data3 %>% 
    filter(year <= yearmax, year >= yearmin) %>%
    select(-year)
}

if (compsize > 3){
  data4 <- read_csv(file4)
  data4_forSOM <- data4 %>% 
    filter(year <= yearmax, year >= yearmin) %>%
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
  

# Load grid files in as matrices, and the indices ('seainds') where the data are from - NOTE: 'SLP' (sea level pressure)
# and 'HGT' (geopotential height at 200mbar) have the same grid and sea indices
if (vargrid1 == 'SKT') {
seaindsM1 <- sktseainds
latvecM1 <- sktlatvec
lonvecM1 <- sktlonvec
} else {                       # if vargrid 1 == "SLP" | vargrid2 == 'HGT' (or anything else, assume slp-sized grid)
seaindsM1 <- slpseainds
latvecM1 <- slplatvec
lonvecM1 <- slplonvec
}

if (compsize > 1) {
  if (vargrid2 == 'SKT') {
    seaindsM2 <- sktseainds
    latvecM2 <- sktlatvec
    lonvecM2 <- sktlonvec
  } else {
    seaindsM2 <- slpseainds
    latvecM2 <- slplatvec
    lonvecM2 <- slplonvec
  }
}

if (compsize > 2) {
  if (vargrid3 == 'SKT') {
    seaindsM3 <- sktseainds
    latvecM3 <- sktlatvec
    lonvecM3 <- sktlonvec
  } else {
    seaindsM3 <- slpseainds
    latvecM3 <- slplatvec
    lonvecM3 <- slplonvec
  }
}

if (compsize > 3) {
  if (vargrid4 == 'SKT') {
    seaindsM4 <- sktseainds
    latvecM4 <- sktlatvec
    lonvecM4 <- sktlonvec
  } else {
    seaindsM4 <- slpseainds
    latvecM4 <- slplatvec
    lonvecM4 <- slplonvec
  }
}

#Run SOMs with 1 ("som"), 2 ("xyf"), or 3 or more variables ("supersom") taken into account together
if (compsize == 1) {
  som_out <- som(scale(data1_forSOM),grid=somgrid(sdim1,sdim2,sshape))
}

if (compsize == 2) {
  som_out <- xyf(X=scale(data1_forSOM),Y=scale(data2_forSOM),user.weights=c(wei1,wei2),grid=somgrid(sdim1,sdim2,sshape))
}

if (compsize == 3) {
  Comb_dat <- list(scale(data1_forSOM), scale(data2_forSOM), scale(data3_forSOM))
  som_out <- supersom(Comb_dat, user.weights=c(wei1,wei2,wei3),grid=somgrid(sdim1,sdim2,sshape))
}

if (compsize == 4) {
  Comb_dat <- list(scale(data1_forSOM), scale(data2_forSOM), scale(data3_forSOM), scale(data4_forSOM))
  som_out <- supersom(Comb_dat, user.weights=c(wei1,wei2,wei3,wei4),grid=somgrid(sdim1,sdim2,sshape))
}

#Get codes for the SOM
codes_out <- getCodes(som_out)

#Get maps for the SOM
maps_out <- map(som_out)

##THIS NEEDS TO BE MODIFIED FOR THE LENGTH OF CODES... if two variables, then two lists, etc.

# Save codes and maps, if desired
if (saveCodes == 'T') {
  write.table(codes_out1, file = codes1_fname, row.names=FALSE,col.names=FALSE,sep=',')
    if (compsize > 1) {
      write.table(codes_out2, file = codes2_fname, row.names=FALSE,col.names=FALSE,sep=',') }
    if (compsize > 2) {
      write.table(codes_out3, file = codes3_fname, row.names=FALSE,col.names=FALSE,sep=',') }
    if (compsize > 3) {
      write.table(codes_out4, file = codes4_fname, row.names=FALSE,col.names=FALSE,sep=',') }
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
