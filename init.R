options(stringsAsFactors = FALSE)

dates <- c(Sys.Date(), Sys.Date() + 14)
# note that area names are flexible here, but cannot be changed from within the application.
# row (person) names can be changed from within the application.
df <- data.frame(Person=c("Ashley", "Brandon", "Chloe", "Daniel"), # Millenials...
                 Development=as.integer(c(1,2,3,4)),
                 Service=as.integer(c(5,6,7,8)),
                 Research=as.integer(c(1,2,3,4)),
                 TeamDevelopment=as.integer(c(5,6,7,8)),
                 TimeOff=as.integer(c(1,2,3,4)))

state_obj <- list(dates=dates, table=df)

saveRDS(state_obj, file="team-time-curr.Rout")
saveRDS(state_obj, file="team-time-next.Rout")

