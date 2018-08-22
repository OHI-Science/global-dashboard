library(shiny)
library(shinydashboard)

tab_title_ui <- function(goal_text, definition, commitment_text) {
  
  fluidRow(box(
               h1(strong(goal_text)),
               h4(strong(paste0("The Global Index measures ",definition))),
               tags$div(class = "commitment_text", 
                        h4(class="subtitle", "Importance:"),
                        h3(class="commitment", commitment_text)), width = 12)
  )
  
}