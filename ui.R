library(shiny)
library(shinydashboard)
library(rhandsontable)

dashboardPage(
  dashboardHeader(title="EAB Data Science Team Time"),
  dashboardSidebar(disable=TRUE),
  dashboardBody(
    dateRangeInput("dateRange", "For Dates"),
    rHandsontableOutput("hot"),
    fluidRow(
       actionButton("savebutton", "Save"),
       actionButton("loadbutton", "Reload", onClick="document.location.reload(true)")
    ),
    radioButtons("plotType", label="By", choices=c("Person", "Area"), inline=TRUE),
    plotOutput("teamPlot")
  ),
  skin="black",
  title="DS Team Time"
)
