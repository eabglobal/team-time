library(shiny)
library(rhandsontable)

df <- data.frame(Person=c("Harlan", "Parsa", "Jay", "Leo"),
                 Development=as.integer(c(1,2,3,7)),
                 Service=as.integer(c(1,2,3,1)),
                 Research=as.integer(c(0,5,0,0)),
                 TeamDevelopment=as.integer(c(1,1,1,1)),
                 TimeOff=as.integer(c(0,0,0,1)))

shinyServer(function(input, output, session) {

  output$hot <- renderRHandsontable({
    rhandsontable(df) %>%
      hot_col("Person", readOnly = TRUE) %>%
      hot_col("Development", readOnly = FALSE) %>%
      hot_col("Service", readOnly = FALSE) %>%
      hot_col("Research", readOnly = FALSE) %>%
      hot_col("TeamDevelopment", readOnly = FALSE) %>%
      hot_col("TimeOff", readOnly = FALSE) %>%
      hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
  })

})
