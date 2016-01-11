library(shiny)
library(shinydashboard)
library(rhandsontable)

title <- paste("Team Time:", team_name)

dashboardPage(
  dashboardHeader(title=title),
  dashboardSidebar(
      radioButtons("curPrevRadio", "Display:", c("Current", "Previous"), selected="Current", 
                   inline=TRUE),
      actionButton("savebutton", "Save"),
      actionButton("cur2prev", "Current -> Previous"),
      actionButton("prev2cur", "Current <- Previous")
  ),
  dashboardBody(
    dateRangeInput("dateRange", "For Dates"),
    rHandsontableOutput("hot"),
    radioButtons("plotType", label="By", choices=c("Person", "Area"), inline=TRUE),
    plotOutput("teamPlot", width="600px")
  ),
  skin=skin,
  title=title
)
