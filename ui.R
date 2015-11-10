library(shiny)
library(rhandsontable)

shinyUI(fluidPage(
  titlePanel("EAB Data Science Team"),
  title = "EAB Data Science Team",
  
  fluidRow(
    rHandsontableOutput("hot"),
    radioButtons("plotType", label="By", choices=c("Person", "Area"), inline=TRUE),
    plotOutput("teamPlot")
  )
))
