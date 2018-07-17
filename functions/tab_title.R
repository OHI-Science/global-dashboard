library(shiny)
library(shinydashboard)

tab_title_ui <- function(goal_text,
                         commitment_text) {
  
  fluidRow(box(h4(em(class = "subtitle", "OHI Northeast Goal:")),
               h1(strong(goal_text)),
               tags$div(class = "commitment_text", 
                        h4(class="subtitle", em("A healthy ocean provides:")),
                        h2(class="commitment", strong(commitment_text))), width = 12)
  )
  
}