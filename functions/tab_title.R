library(shiny)
library(shinydashboard)

tab_title_ui <- function(goal_text, definition, commitment_text) {
  
  fluidRow(box(
    h1(strong(goal_text)),
    tags$div(class = "commitment_text", 
             h3(class="commitment", commitment_text)),
    h4(definition),
    width = 12)
  )
  
}