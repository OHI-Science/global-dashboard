library(shiny)
library(shinydashboard)

tab_title_ui <- function(goal_text, definition, goal_description) {
  
  fluidRow(box(
    h1(strong(goal_text)),
    tags$div(class = "goal_description", h3(goal_description)),
    tags$br(),
    h4(paste("Defining Goal Status:")),
    tags$i(definition),
    width = 12)
  )
  
}