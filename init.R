options(stringsAsFactors = FALSE)

dates <- c(Sys.Date(), Sys.Date() + 14)
df <- data.frame(Person=c("Ashley", "Brandon", "Chloe", "Daniel"), # Millenials...
                 Development=as.integer(c(0,0,0,0)),
                 Service=as.integer(c(0,0,0,0)),
                 Research=as.integer(c(0,0,0,0)),
                 TeamDevelopment=as.integer(c(0,0,0,0)),
                 TimeOff=as.integer(c(0,0,0,0)))

save(dates, df, file="team-time-current.Rout", ascii=TRUE)
save(dates, df, file="team-time-next.Rout", ascii=TRUE)
