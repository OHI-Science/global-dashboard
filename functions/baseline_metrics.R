library(shiny)
library(shinydashboard)

metrics <- function(goal,baseline_text,metric1,metric1_text) {
  
  fluidRow(
    
    box(h3(class = "subtitle", "Global Mariculture Score"),
    tags$div(class = "baseline_text",
             h1(class="subtitle", strong(paste(goal,"%",sep=""))),
             h4(class="baseline", baseline_text)),
    width = 6),

    
    box(h3(class = "subtitle", "Largest Share by Weight"),
      tags$div(class = "baseline_text",
               h1(class="subtitle", strong(metric1[[1]][1])),
               h4(class="baseline", paste(metric1[[2]][1], metric1_text, sep=" "))),
      width = 6)
    
  )
}


