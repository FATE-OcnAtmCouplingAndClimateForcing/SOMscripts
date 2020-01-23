## plot_kohonen_fig.r
## Emily Norton, 8/7/18
## Plot figures for kohonen package, including SOM codes, quality, and counts
## Parent script is runSOM2_xyf_super.r 

if (booCodes == 'T') {
  dev.new()
  par(mfrow=c(2,2))
  plot(som_out,'codes', main = "SOM Codes")
} 

if (booQuality == 'T') {
  dev.new()
  par(mfrow=c(2,1))
  plot(som_out,'quality', main = "SOM Quality")
} 

if (booCounts == 'T') {
  dev.new()
  par(mfrow=c(2,1))
  plot(som_out,'counts', main = "SOM Counts")
} 
