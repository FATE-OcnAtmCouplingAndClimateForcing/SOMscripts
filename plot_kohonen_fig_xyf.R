#plot_kohonen_fig_xyf.r
#Plot figures for kohonen package, including SOM codes, quality, and counts
#Parent script is runSOM2_xyf.r (previously mapSOM2_xyf.r)

if (booCodes == 'T') {
  dev.new()
  par(mfrow=c(2,2))
  plot(som2.slpsktsum,'codes', main='SLP/SKT summer codes')
  plot(som2.slpsktwin,'codes', main='SLP/SKT winter codes')
} 

if (booQuality == 'T') {
  dev.new()
  par(mfrow=c(2,1))
  plot(som2.slpsktsum,'quality', main='SLP/SKT summer quality')
  plot(som2.slpsktwin,'quality', main='SLP/SKT winter quality')
} 

if (booCounts == 'T') {
  dev.new()
  par(mfrow=c(2,1))
  plot(som2.slpsktsum,'counts', main='SLP/SKT summer counts')
  plot(som2.slpsktwin,'counts', main='SLP/SKT winter counts')
} 