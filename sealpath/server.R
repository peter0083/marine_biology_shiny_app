#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



# the latest gganimate has issues with legends Reference: https://stackoverflow.com/questions/42954762/gganimate-creating-duplicate-legend-and-caption
library(devtools)
library(dplyr)
library(gganimate)
library(ggplot2)
library(readr)
library(cowplot)
library(viridis)
library(gapminder)
library(ggmap)
library(shiny)

# load the data set
seal_data1 <- read_csv("CopyOfseal.csv")
seal_gps <- read_csv("CopyOfseal_gps.csv")
seal_data2 <- seal_data1 %>% 
  mutate(accel = sqrt(aX^2 + aY^2 + aZ^2))


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$value1 <- renderPrint({ input$checkbox1 })
  output$value2 <- renderPrint({ input$checkbox2 })
  
  output$path <- renderPlot({

    seal_location <- c(lon = -169.48514, lat = 57.225556)  # a coordinate near St. Paul, Alaska
    seal_boundary <- c(-170.612418, 56.854979, -168, 57.621875)
    seal_path <- get_map(location = seal_location, source = "google", maptype = "satellite", zoom = 8) 
    ggmap(seal_path) +
      geom_point(data = seal_gps, aes(x = lon, y= lat), size = 1, alpha = 1, colour = "yellow") +
      geom_path(data = seal_gps, aes(x = lon, y= lat), colour = "grey", alpha = 0.4) +
      ggtitle("Seal's Path in Bird's-eye View") +
      labs(y = "latitude", x = "longitude") +
      theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
      scale_x_continuous(limits = c(seal_boundary[1], seal_boundary[3])) +
      scale_y_continuous(limits = c(seal_boundary[2], seal_boundary[4])) +
      coord_cartesian()
}) 
  output$accelPlot <- renderPlot({
    
      data_selected <- brushedPoints(seal_gps, input$plot_brush)
      if (nrow(data_selected) > 1 & input$checkbox1 == TRUE) {
        date_range <- c((max(as.POSIXct(data_selected$time))), (min(as.POSIXct(data_selected$time))))
        seal_data3 <- seal_data2 %>% 
           filter(time <= max(date_range) & time >= min(date_range))
        
        ggplot() +
          geom_point(data = seal_data3, 
                     aes(x = accel, y = -depth, colour = night), 
                     alpha = 0.8, size = 1, shape = 23) +
          geom_point(data = seal_data2, 
                     aes(x = accel, y = -depth, colour = night), 
                     alpha = 0.1, size = 0.5) +
          scale_colour_discrete(guide = FALSE) +
          ggtitle("Seal's Depth vs Acceleration") +
          labs(y = "Depth", x = "Acceleration") +
          theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
          facet_wrap(~night)
        
      } else if (nrow(data_selected) <= 1 & input$checkbox1 == TRUE) {
          ggplot(seal_data2, aes(x = accel, y = -depth, colour = night)) +
            geom_point(alpha = 0.1) +
            scale_colour_discrete(guide = FALSE) +
            ggtitle("Seal's Depth vs Acceleration") +
            labs(y = "Depth", x = "Acceleration") +
            theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
            facet_wrap(~night) 
        
      } else if ((nrow(data_selected) > 1 & input$checkbox1 == FALSE)) {
        date_range <- c((max(as.POSIXct(data_selected$time))), (min(as.POSIXct(data_selected$time))))
        seal_data3 <- seal_data2 %>% 
          filter(time <= max(date_range) & time >= min(date_range))
        
        ggplot() +
          geom_point(data = seal_data3, 
                     aes(x = accel, y = -depth, colour = night), 
                     alpha = 0.8, size = 1, shape = 23) +
          geom_point(data = seal_data2, 
                     aes(x = accel, y = -depth, colour = night), 
                     alpha = 0.1, size = 0.5) +
          scale_colour_discrete(name = "Time of the Day") +
          ggtitle("Seal's Depth vs Acceleration") +
          labs(y = "Depth", x = "Acceleration") +
          theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) 
        
      } else {
        ggplot(seal_data2, aes(x = accel, y = -depth, colour = night)) +
          geom_point(alpha = 0.3) +
          scale_colour_discrete(name = "Time of the Day") +
          ggtitle("Seal's Depth vs Acceleration") +
          labs(y = "Depth", x = "Acceleration") +
          theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) 
      }
})
  output$info <- renderPrint({
    # With base graphics, need to tell it what the x and y variables are.
    brushedPoints(seal_gps, input$plot_brush, xvar = "lon", yvar = "lat")
  })
  
  output$histogram <- renderPlot({
    
    data_selected <- brushedPoints(seal_gps, input$plot_brush)

    if (nrow(data_selected) > 1 & input$checkbox2 == TRUE) {
      date_range <- c((max(as.POSIXct(data_selected$time))), (min(as.POSIXct(data_selected$time))))
      seal_data3 <- seal_data2 %>% 
        filter(time <= max(date_range) & time >= min(date_range))
      
      ggplot() +
        geom_bar(data = seal_data2,
                  aes(x = lightLev, alpha = 0.1)) +
        geom_bar(data = seal_data3, 
                   aes(x = lightLev, fill = night)) +
        ggtitle("Light Level Detected by Sensor") +
        labs(y = "Detection counts", x = "Light level") +
        facet_wrap(~night) +
        theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
        scale_fill_discrete(guide = FALSE) +
        scale_alpha_continuous(name = NULL,
                               labels = "Overall")
      
    } else if (nrow(data_selected) <= 1 & input$checkbox2 == TRUE) {
      ggplot() +
        geom_bar(data = seal_data2, 
                 aes(x = lightLev, fill = night)) +
        ggtitle("Light Level Detected by Sensors") +
        labs(y = "Detection counts", x = "Light level") +
        facet_wrap(~night) +
        theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
        scale_fill_discrete(guide = FALSE)
      
    } else if ((nrow(data_selected) > 1 & input$checkbox2 == FALSE)) {
      
      date_range <- c((max(as.POSIXct(data_selected$time))), (min(as.POSIXct(data_selected$time))))
      seal_data3 <- seal_data2 %>% 
        filter(time <= max(date_range) & time >= min(date_range))
      
      ggplot() +
        geom_bar(data = seal_data2, 
                 aes(x = lightLev, alpha = 0.1)) +
        geom_bar(data = seal_data3, 
                 aes(x = lightLev, fill = night)) +
        ggtitle("Light Level Detected by Sensors") +
        labs(y = "Detection counts", x = "Light level") +
        theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
        scale_fill_discrete(name = "Time of the Day") +
        scale_alpha_continuous(name = "Wholeday",
                               labels = "Overall")
    } else {
      ggplot() +
        geom_bar(data = seal_data2, 
                 aes(x = lightLev, fill = night)) +
        ggtitle("Light Level Detected by Sensors") +
        labs(y = "Detection counts", x = "Light level") +
        theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
        scale_fill_discrete(name = "Time of the Day") +
        scale_alpha_continuous(name = "Whole Day",
                               labels = "Overall")
    }
   
  })
  
})
