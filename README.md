# SOMscripts
run SOMs for individual variables ('som') or covariates ('xyf')

Parent R scripts:
runSOM_xyf_super.r - generates self-organizing maps for one ("som"), two ("xyf"), or three or more ("supersom") variables at a time.  Variables must be in .csv format with headers and "year" column.  The program calls additional scripts to generate kohonen figs, geographic map, year/node hovmoller figs

Additional plotting scripts (called by parent codes):
plot_year_node.r - makes a hovmoller-esque plot of which years are sorted into which node
plot_geo_map.r - makes a geographic map of the codes for each of the nodes
plot_kohonen_fig.r - generates codes, counts, and quality plots for the kohonen SOM and xyf functions


Note: The user will need to change all of the path names to their local directory (e.g. change setwd(...), etc.)
