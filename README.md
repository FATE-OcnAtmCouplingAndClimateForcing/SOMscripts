# SOMscripts

Parent R script:
runSOM_xyf_super.r - generates self-organizing maps for one ("som"), two ("xyf"), or three or more ("supersom") variables at a time.  Variables must be in .csv format with headers and "year" column.  The program calls additional scripts to generate standard Kohonen-package figures, geographic map of nodes for each variable, and a year/node hovmoller plot.

Additional plotting scripts (called by parent code):
plot_year_node.r - Generates a hovmoller-style plot for which years are sorted by node.
plot_geo_map.r - Makes a geographic map of the codes for each of the nodes and variables.
plot_kohonen_fig.r - Generates codes, counts, and quality plots that come standard with the Kohonen package.

Required input files:
One or two dimensional variables may be included. These files must be ordered by year in rows, and spatial location, if applicable, in columns (see example files). Since the Kohonen som function does not allow NAN points to be included in the variable input, points outside of the boundaries and/or on land must be removed prior to running the script. To plot these points well, we require the following additional files:
  1) latvec/lonvec files: A vector of lat/lon points from the grid that spans at least the entire plotting domain; latitude must be monotonically increasing; and
  2) seainds: Indices of the points from your variable input file based on the full grid.
  
