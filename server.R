library(shiny)
library(rhandsontable)
library(ggplot2)
library(tidyr)
library(eabdslib)

options(stringsAsFactors = FALSE)

load("ds-team-time.Rout") # df and dates

shinyServer(function(input, output, session) {

  values = reactiveValues()
  
  updateDateRangeInput(session, "dateRange", start=dates[[1]], end=dates[[2]])
  
  observeEvent(input$savebutton, {
    message("save")
    dates <<- input$dateRange
    df <<- values[["hot"]]
    save(dates, df, file="ds-team-time.Rout", ascii=TRUE)
  })
  
  data = reactive({
    message("data")
    values[["hot"]] <- if (is.null(input$hot)) {
      df
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
        coord_flip() +
        theme_eab()
    } else {
      ggplot(hot_df, aes(Person, Days, fill=Area)) + 
        geom_bar(stat='identity') +
        scale_fill_manual(values=eab_color$colors) +
        xlab("") +
        coord_flip() +
        theme_eab()
    }
    
    print(p)
  })
  
  output$hot <- renderRHandsontable({
    message("hot")
    rhandsontable(data()) %>%
      hot_col("Person", readOnly = FALSE) %>%
      hot_col("Development", readOnly = FALSE) %>%
      hot_col("Service", readOnly = FALSE) %>%
      hot_col("Research", readOnly = FALSE) %>%
      hot_col("TeamDevelopment", readOnly = FALSE) %>%
      hot_col("TimeOff", readOnly = FALSE) %>%
      hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
  })

})
