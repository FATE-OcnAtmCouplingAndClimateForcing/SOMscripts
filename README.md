# SOMscripts
run SOMs for individual variables ('som') or covariates ('xyf')

Parent R scripts:
runSOMs.r - generates SOMs individually for slp and sst (requires slp + sst data in csv format); calls additional scripts to generate kohonen figs, geographic map, year/node hovmoller figs
mapSOM2_xyf.r - analogous to runSOMs.r but generates paired/linked SOMs for slp + sst together

Additional plotting scripts (called by parent codes):
plot_year_node_SOMs/xyf.r - makes a hovmoller-esque plot of which years are sorted into which node
plot_geo_map_SOMs/xyf.r - makes a geographic map of the codes for each of the nodes
plot_kohonen_fig_SOMs/xyf.r - generates codes, counts, and quality plots for the kohonen SOM and xyf functions


Note: The user will need to change all of the path names to their local directory.
