library(shiny)
library(shinydashboard)
library(rlang)

baseline_metrics_ui <- function(id,
                                number_boxes = c(1, 2, 3, 4)) {
  
  ns <- NS(id)
  
  get_width <- function(number_boxes) {
    if (number_boxes == 1) {
      width = 12
    } else if (number_boxes == 2) {
      width = 6
    } else if (number_boxes == 3) {
      width = 4
    } else if (number_boxes == 4) {
      width = 3
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
                             number_boxes,
                             statistic,
                             text,
                             icon = NULL
) {
  
  for(x in 1:number_boxes) {local({
    i <- x
    box_id <- paste("valuebox", as.character(i), sep="_")
    output[[box_id]] <- renderValueBox({
      valueBox(statistic[i], 
               paste0(text[i]), 
               icon = icon(icon), 
               color = "light-blue")
    })
  })}
}