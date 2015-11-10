library(shiny)
library(rhandsontable)

shinyUI(fluidPage(
  titlePanel("EAB Data Science Team"),
  title = "EAB Data Science Team",
  
  fluidRow(
    rHandsontableOutput("hot"),
    column(width=6, "graph")
  )
))
