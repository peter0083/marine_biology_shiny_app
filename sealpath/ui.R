#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Seal Data Interactive Visualization Tool"),

  fluidRow(
    column(12,
           p("Instruction: On seal's path, use mouse to position your cursor at the beginning of point you want to highlight. \n
              Press and hold your primary mouse button. Drag the cursor to the end of the point and let go of the mouse button. \n
              Once completed, all points within the box will give information about depth vs acceleration and light level counts in the graphs below."),
           plotOutput("path", brush = brushOpts(id = "plot_brush")),
           fluidRow(
             column(6,
                    plotOutput("accelPlot"),
                    fluidRow(
                      column(12, 
                             checkboxInput("checkbox1", label = "Faceted View for Depth vs Acceleration", value = FALSE))
                      )
             ),
             column(width = 6,
                    plotOutput("histogram"),
                    fluidRow(
                      column(12,
                             checkboxInput("checkbox2", label = "Faceted View for Light Level Detection", value = FALSE)))
                    ))
           )
    )
  )
)
