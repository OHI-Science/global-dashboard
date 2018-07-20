library(shiny)
library(shinydashboard)

metrics <- function(goal,baseline_text) {
  
  fluidRow(
    
    box(h4(class = "subtitle", "BASELINE METRICS"),
    tags$div(class = "baseline_text",
             h1(class="subtitle", strong(paste(goal,"%",sep=""))),
             h5(class="baseline", strong(baseline_text))), 
    width = 12)
    
  )
}


