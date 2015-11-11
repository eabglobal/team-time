options(stringsAsFactors = FALSE)

dates <- c(Sys.Date(), Sys.Date() + 14)
df <- data.frame(Person=c("Harlan", "Parsa", "Jay", "Leo"),
                 Development=as.integer(c(0,0,0,0)),
                 Service=as.integer(c(0,0,0,0)),
                 Research=as.integer(c(0,0,0,0)),
                 TeamDevelopment=as.integer(c(0,0,0,0)),
                 TimeOff=as.integer(c(0,0,0,0)))

save(dates, df, file="ds-team-time.Rout", ascii=TRUE)
