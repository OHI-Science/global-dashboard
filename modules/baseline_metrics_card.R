library(shiny)
library(shinydashboard)
library(rlang)


## Baseline Metrics UI Function ##
baseline_metrics_ui <- function(id,
                                number_boxes = c(1, 2, 3)) {

  ns <- NS(id)

  get_width <- function(number_boxes) {
    if (number_boxes == 1) {
      width = 12
    } else if (number_boxes == 2) {
      width = 6
    } else if (number_boxes == 3) {
      width = 4
    }
    return(width)
  }

  valueboxes <- vector("list", number_boxes)

  for(i in 1:number_boxes) {
    box_id <- paste("valuebox", as.character(i), sep="_")
    valuebox <- valueBoxOutput(ns(box_id), width = get_width(number_boxes))
    valueboxes[[i]] <- valuebox
  }

  
  fluidRow(class = "valuebox",
           box(h4("BASELINE METRICS"),
               valueboxes,
               class = "baseline",
               width = 12)
  )

}




baseline_metrics <- function(input,
                             output,
                             session,
                             goal_name,
                             first,
                             second,
                             third,
                             icon,
                             color) {

  base_df <- baseline %>%
    filter(goal == goal_name)
  
  metrics <- c(first,second,third)
  
  
  for(b in metrics){local({
    
    base_df <- base_df %>%
      filter(subtitle == b)
      
    box_id <- paste0("valuebox_",which(metrics == b))
      
    output[[box_id]] <- renderValueBox({
        valueBox(base_df$metric,
                 base_df$description,
                 icon = icon(icon),
                 color = color)
      })

  })
  
  }    
}
 