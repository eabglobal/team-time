Team Time
=========

This rather simple [Shiny](http://shiny.rstudio.com/) app is a handy way to show how 
team members' time is allocated over a period of time, such as a two-week sprint.

It was written by Harlan Harris for the Data Science team at [EAB](http://eab.com), and is
MIT licensed, so you can use it wherever you like.

Source is on [GitHub](https://github.com/advisory/team-time). Contributions very welcome!

Usage
-----

* You can right-click on the table to change people's names.
* Be sure to Save your work -- it doesn't automatically save. 
* There are two tables, current and next, that can be used to handle time-block transitions.
* There's no real-time update. If you edit the table, someone else will have to Load to see the changes.

Setup
-----

1. Install the files into a Shiny server directory.
2. Copy `sample_global.R` to `global.R` (so Shiny will pick it up) and edit appropriately.
3. Start R in the directory. `source("init.R")` to initialize the data files. Note that
   the Area names are fixed, so edit `init.R` if you need to change them; person names can
   be changed/added/deleted from within the application.

Fun Things
----------

* Uses the `rhandsontable` package to support an editable table in a Shiny app.
* Uses the `shinyjs` package to enable/disable front-end widgets.
* Saves state as files in the application directory.
