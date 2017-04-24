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


##### dependency information

```{r}
R version 3.3.2 (2016-10-31)
Platform: x86_64-apple-darwin13.4.0 (64-bit)
Running under: macOS Sierra 10.12.3

locale:
[1] en_CA.UTF-8/en_CA.UTF-8/en_CA.UTF-8/C/en_CA.UTF-8/en_CA.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] ggmap_2.7       gapminder_0.2.0 viridis_0.3.4   cowplot_0.7.0   readr_1.1.0     ggplot2_2.2.1   gganimate_0.1   dplyr_0.5.0     devtools_1.12.0
[10] shiny_1.0.0    

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.8       plyr_1.8.4        base64enc_0.1-3   bitops_1.0-6      tools_3.3.2       digest_0.6.12     evaluate_0.10     jsonlite_1.2     
 [9] memoise_1.0.0     tibble_1.2        gtable_0.2.0      lattice_0.20-34   png_0.1-7         DBI_0.5-1         mapproj_1.2-4     yaml_2.1.14      
[17] proto_1.0.0       gridExtra_2.2.1   knitr_1.15.1      stringr_1.1.0     withr_1.0.2       maps_3.1.1        RgoogleMaps_1.4.1 hms_0.3          
[25] rprojroot_1.1     grid_3.3.2        R6_2.2.0          jpeg_0.1-8        rmarkdown_1.3     animation_2.5     RJSONIO_1.3-0     sp_1.2-4         
[33] reshape2_1.4.2    magrittr_1.5      backports_1.0.4   scales_0.4.1      htmltools_0.3.5   rsconnect_0.7     assertthat_0.1    mime_0.5         
[41] xtable_1.8-2      colorspace_1.3-2  geosphere_1.5-5   httpuv_1.3.3      labeling_0.3      stringi_1.1.2     RCurl_1.95-4.8    lazyeval_0.2.0   
[49] munsell_0.4.3     rjson_0.2.15  
```


Reference:

> Alaska Fisheries Science Center https://www.afsc.noaa.gov/Education/Activities/PDFs/NFS_K-6_Sept2013_L5.pdf


> Gallon S, Bailleul F, Charrassin J, Guinet C, Bost C, Handrich Y et al. Identifying foraging events in deep diving southern elephant seals, Mirounga leonina, using acceleration data loggers. Deep Sea Research Part II: Topical Studies in Oceanography [Internet]. 2013;88-89:14-22. Available from: http://www.cebc.cnrs.fr/publipdf/2013/GDSR88_2013.pdf


> Le Boeuf, Burney J., and Richard M. Laws, editors Elephant Seals: Population Ecology, Behavior, and Physiology. Berkeley: University of California Press, c1994 1994. http://ark.cdlib.org/ark:/13030/ft7b69p131/

    

