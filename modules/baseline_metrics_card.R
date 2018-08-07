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
  
  ## Streamline this code a little better

  df <- baseline %>%
    filter(goal == goal_name)
  


  first_df <- df %>% filter(subtitle == first)

  first_list <- list(as.character(first_df$country),
       as.character(first_df$goal),
       as.character(first_df$metric),
       as.character(first_df$subtitle),
       as.character(first_df$description))
  
  second_df <- df %>% filter(subtitle == second)
  
  second_list <- list(as.character(second_df$country),
                     as.character(second_df$goal),
                     as.character(second_df$metric),
                     as.character(second_df$subtitle),
                     as.character(second_df$description))
  
  third_df <- df %>% filter(subtitle == third)
  
  third_list <- list(as.character(third_df$country),
                      as.character(third_df$goal),
                      as.character(third_df$metric),
                      as.character(third_df$subtitle),
                      as.character(third_df$description))
  
  
  ####

  local({

    if(!is.na(first)) {

      box_id <- "valuebox_1"
      output[[box_id]] <- renderValueBox({

        valueBox(first_list[3],
                 first_list[5],
                 icon = icon(icon),
                 color = color)
        })
    }
    
    if(!is.na(second)) {
      
      box_id <- "valuebox_2"
      output[[box_id]] <- renderValueBox({
        
        valueBox(second_list[3],
                 second_list[5],
                 icon = icon(icon),
                 color = color)
      })
    }
    
    if(!is.na(third)) {
      
      box_id <- "valuebox_3"
      output[[box_id]] <- renderValueBox({
        
        valueBox(third_list[3],
                 third_list[5],
                 icon = icon(icon),
                 color = color)
      })
    }
    


      })

  }    
  
#   baseline_metrics <- function(input,
#                                output,
#                                session,
#                                number_boxes,
#                                statistic,
#                                text,
#                                icon
#   ) {
# 
#     for(x in 1:number_boxes) {local({
#       i <- x
#       box_id <- paste("valuebox", as.character(i), sep="_")
#       output[[box_id]] <- renderValueBox({
#         valueBox(statistic[i],
#                  paste0(text[i]),
#                  icon = icon(icon),
#                  color = "light-blue")
#       })
#     })}
# 
# 
#   
# }
# 
# 
# 
