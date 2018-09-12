#plot_kohonen_fig_SOMs.r
#Plot figures for kohonen package, including SOM codes, quality, and counts
#Parent script is runSOMs.r (previously mapSOMs.r)


#Now begin making figures
#library(plotly)   #for plotting maps
library(maps)
library(mapproj)

#Plot figures
if (booCodes == 'T') {
  dev.new()
  par(mfrow=c(2,2))
  plot(som.slpsum,'codes', main='SLP summer codes')
  plot(som.slpwin,'codes', main='SLP winter codes')
  plot(som.sktsum,'codes', main='SKT summer codes')
  plot(som.sktwin,'codes', main='SKT winter codes')
} 

if (booQuality == 'T') {
  dev.new()
  par(mfrow=c(2,2))
  plot(som.slpsum,'quality', main='SLP summer quality')
  plot(som.slpwin,'quality', main='SLP winter quality')
  plot(som.sktsum,'quality', main='SKT summer quality')
  plot(som.sktwin,'quality', main='SKT winter quality')
} 

if (booCounts == 'T') {
  dev.new()
  par(mfrow=c(2,2))
  plot(som.slpsum,'counts', main='SLP summer counts')
  plot(som.slpwin,'counts', main='SLP winter counts')
  plot(som.sktsum,'counts', main='SKT summer counts')
  plot(som.sktwin,'counts', main='SKT winter counts')
} 
