# marine_biology_shiny_app
a visualization exercise using R Shiny app


The seal datasets contain positional (GPS) and movement data of a seal during her 3-day trip to sea. The seal_gps.csv data contains the GPS coordinates (recorded whenever the seal surfaces), and the seal.csv contains motion and environmental data, collected at a set period during the journey.

The goal of this app is to build a plot of spatial data with tabular data. This app is to help users discover different behaviours that the seal exhibits on her trip such as foraging, in transit, or sleeping. 

Please note that this shiny app is not yet optimized for mobile users.

| URL                                         | Description                 |
|---------------------------------------------|-----------------------------|
| https://peter0083.shinyapps.io/sealpath/    | deployed shiny app          |
| https://peter0083.shinyapps.io/1hzsealpath/ | deployed shiny app 1Hz ver. |

According to visualization concepts described by Dr. Tamara Munzner (UBC), linked highlighting allows viewers to see how regions contiguous in one view are distributed within another view. I can gain some insights about the data based on different legs of the seal's journey through linked highlighting. For example, some data points of seal's journey are primarily collected during daytime and other segments are nighttime. Linked highlighting enables me to link the path with depth and acceleration at specific times. In addition to background information, this linkage helps me to infer the activity of the seal at that time segment on that part of the journey. According to Alaska Fisheries Science Center, Le Boeuf et al and Gallon et al, seals mainly dive for food and swim at the boundary of turbulent flow. In certain segments that had no high acceleartion readings, I can assume that the water was calm. Depth is correlated with hunting and acceleration is correlated with turbulence. Without background knowledge from references, it was difficult to make meaningful interpretation of the plots. In addition, this linked highlight is only unidirectional. The linked highlighting will be much more useful if I was able to implement it bidirectionally. With bidirectional linked highlighting, I can select the data points of interest using a brush stroke on the scatterplot and the corresponding points on the journey map will be highlighted.



Reference:

> Alaska Fisheries Science Center https://www.afsc.noaa.gov/Education/Activities/PDFs/NFS_K-6_Sept2013_L5.pdf


> Gallon S, Bailleul F, Charrassin J, Guinet C, Bost C, Handrich Y et al. Identifying foraging events in deep diving southern elephant seals, Mirounga leonina, using acceleration data loggers. Deep Sea Research Part II: Topical Studies in Oceanography [Internet]. 2013;88-89:14-22. Available from: http://www.cebc.cnrs.fr/publipdf/2013/GDSR88_2013.pdf


> Le Boeuf, Burney J., and Richard M. Laws, editors Elephant Seals: Population Ecology, Behavior, and Physiology. Berkeley: University of California Press, c1994 1994. http://ark.cdlib.org/ark:/13030/ft7b69p131/

    

