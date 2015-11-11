library(shiny)
library(shinydashboard)
library(rhandsontable)

dashboardPage(
  dashboardHeader(title="EAB Data Science Team Time"),
  dashboardSidebar(disable=TRUE),
  dashboardBody(
    rHandsontableOutput("hot"),
    radioButtons("plotType", label="By", choices=c("Person", "Area"), inline=TRUE),
    plotOutput("teamPlot")
  ),
  skin="black",
  title="DS Team Time"
)
