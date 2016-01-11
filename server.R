library(shiny)
library(rhandsontable)
library(ggplot2)
library(tidyr)
library(magrittr)

options(stringsAsFactors = FALSE)

shinyServer(function(input, output, session) {
  
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
  
  values = reactiveValues()
  
  observe({
    message("updateDateRange")
    updateDateRangeInput(session, "dateRange", start=file_dates()[[1]], end=file_dates()[[2]])
  })
  
  
  observeEvent(input$savebutton, {
    message("save")
    state_obj <- list(dates=input$dateRange, table=values[["hot"]])
    
    saveRDS(state_obj, file=curFileName())
  })
  
  data = reactive({
    message("data")
    values[["hot"]] <- if (is.null(input$hot)) {
      file_table()
    } else {
      hot_to_r(input$hot)
    }
    values[["hot"]] 
  })
  
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
  
  output$hot <- renderRHandsontable({
    message("hot")
    ret <- rhandsontable(data()) %>%
      hot_col("Person", readOnly = FALSE) 
    for (cc in colnames(data())) {
      if (cc != "Person") {
        ret %<>% hot_col(cc, readOnly = FALSE)
      }
    }
    ret %>% hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
  })

})
