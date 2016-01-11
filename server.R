library(shiny)
library(shinyjs)
library(rhandsontable)
library(ggplot2)
library(tidyr)
library(magrittr)

options(stringsAsFactors = FALSE)

shinyServer(function(input, output, session) {
  
  # coordinates Shiny and table state
  values = reactiveValues()
  
  ###### UI Updaters
  
  observe({
    message("updateDateRange")
    updateDateRangeInput(session, "dateRange", start=file_dates()[[1]], end=file_dates()[[2]])
  })
  
  observe({
    message("save buttons")
    if (input$curPrevRadio == "Current") {
      enable("save2next")
      disable("save2curr")
    } else {
      disable("save2next")
      enable("save2curr")
    }
  })
  
  ###### Persistent data accessors 
  
  curFileName <- reactive({
    message("curFileName")
    if (input$curPrevRadio == "Current") "team-time-curr.Rout" else "team-time-next.Rout"
  })
  
  file_dates <- reactive({
    message("file_dates")
    readRDS(curFileName())$dates
  })
  file_table <- reactive({
    message("file_df")
    readRDS(curFileName())$table
  })
  
  
  ####### Save to disk
  
  observeEvent(input$savebutton, {
    message("save")
    state_obj <- list(dates=input$dateRange, table=values[["hot"]])
    saveRDS(state_obj, file=curFileName())
  })
  
  observeEvent(input$save2curr, {
    message("save2curr")
    state_obj <- list(dates=input$dateRange, table=values[["hot"]])
    saveRDS(state_obj, file="team-time-curr.Rout")
  })
  
  observeEvent(input$save2next, {
    message("save2next")
    state_obj <- list(dates=input$dateRange, table=values[["hot"]])
    saveRDS(state_obj, file="team-time-next.Rout")
  })
  
  ###### Sync data and table
  
  # if the radio button changes, over-write the table
  observe({
    values[["hot"]] <- file_table()
  })
  
  # if the input changes, over-write the table
  observe({
    values[["hot"]] <- if (is.null(input$hot)) file_table() else hot_to_r(input$hot)
  })
  
  output$hot <- renderRHandsontable({
    message("hot")
    ret <- rhandsontable(values[["hot"]]) %>%
      hot_col("Person", readOnly = FALSE) 
    for (cc in colnames(values[["hot"]])) {
      if (cc != "Person") {
        ret %<>% hot_col(cc, readOnly = FALSE)
      }
    }
    ret %>% hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
  })
  
  ####### Plots
  
  output$teamPlot <- renderPlot({
    message("teamPlot")
    if (is.null(values[["hot"]])) return(NULL)
    hot_df <- gather(values[["hot"]], Area, Days, -Person)
    p <- if (input$plotType == "Area") {
      ggplot(hot_df, aes(Area, Days, fill=Person)) + 
        geom_bar(stat='identity') +
        xlab("") +
        coord_flip() 
    } else {
      ggplot(hot_df, aes(Person, Days, fill=Area)) + 
        geom_bar(stat='identity') +
        xlab("") +
        coord_flip() 
    }
    
    print(p)
  })
  
})
