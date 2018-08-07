library(shiny)
library(shinydashboard)

tab_title_ui <- function(goal_text,
                         commitment_text) {
  
  fluidRow(box(
               h1(strong(goal_text)),
               tags$div(class = "commitment_text", 
                        h4(class="subtitle", "Healthy Oceans Goal: "),
                        h2(class="commitment", commitment_text)), width = 12)
  )
  
}