#' 
#' Chart Card Module
#'
#' This script contains two functions:
#' \code{card_ui} generates the user interface for each card
#' \code{card_plot} generates the plot shown in a card
#' 
#' The functions together generate a box within a fluid row that has a width 
#' of 12 (the whole page), title text, source text, a select input if applicable, 
#' and an interactive chart built using plotly. 
#' 

## Load libraries ##
library(shiny)
library(shinydashboard)
library(plotly)
library(assertthat)

#'
#' @title card_ui function
#' 
#' @description Generates the ui for cards.
#' 
#' @return A fluidRow containing a tagList and a box with items specified by 
#' the function inputs.
#' 
#' @details
#' \code{card_ui} needs the text that will surround the chart on 
#' the card as well as information about the select inputs if 
#' applicable.
#' 
#' @param id character. Used to match to ui function to the associated
#' server function. Must be unique across cards.
#' @param title_text character, optional. Title text for chart.
#' @param sub_title_text character, optional. Subtitle text for chart if applicable.
#' @param select_type character, optional.  Determines the type of shiny input to be used. 
#' Must be one of the following:
#' \itemize{
#'   \item "radio"
#'   \item "drop_down"
#'   \item "checkboxes"
#'   \item NULL
#' }
#' @seealso \url{https://shiny.rstudio.com/reference/shiny/latest/selectInput.html}, 
#' @seealso \url{https://shiny.rstudio.com/reference/shiny/latest/checkboxInput.html},
#' @seealso \url{https://shiny.rstudio.com/reference/shiny/latest/radioButtons.html}
#' @param select_location character, optional. Determines if the select input will
#' be located above or below the chart. Must be one of the following:
#' \itemize{
#'   \item "above"
#'   \item "below"
#'   \item NULL
#' } 
#' @param select_choices list, optional. List of choices for the select input. Can be 
#' defined in the global.r file as a variable in passed here 
#' (e.g. in global.r: choices <- sort(unique(df$column)), in ui.r: select_choices=choices).
#' Can also be a defined list (e.g. select_choices = list("Choice 1" = "choice_1", "Choice 2" = "choice_2"))
#' See \url{https://shiny.rstudio.com/reference/shiny/latest/selectInput.html}, for more information.
#' @param select_label character, optional, text for above select input (e.g. "Select Gender")
#' @param selected list, optional - unless using checkbox input, Defines the default selections 
#' for the chart. Default checkbox inputs must be defined otherwise the chart will default to
#' no data.
#' @param source_text character or list, optional. Data source information for chart. If 
#' additional notes need to be added beyond data source information below the chart 
#' they can be added by passing a list or html elements to this function 
#' (e.g. source_text = list(p("Note 1), p("Note 2"), p("Data Source: 2010 Census")))
#' 

## Card UI Function ##
card_ui <- function(id, 
                    title_text = NULL,
                    sub_title_text = NULL,
                    source_text = NULL,
                    select_type = c(NULL, "radio", "drop_down", "checkboxes"),
                    select_location = c(NULL, "above", "below"),
                    select_choices = c(""),
                    select_label = NULL, 
                    selected = NULL) {
  
  ns <- NS(id)
  
  # # Check select_type inputs
  # select_type_args <- c(NULL, "radio", "drop_down", "checkboxes")
  # assert_that(select_type %in% select_type_args,
  #             msg = paste("select_type value of", select_type, 
  #                         "must be either 'radio', 'drop_down', 'checkboxes', or NULL", sep = " "))
  # 
  # # Check select_location inputs
  # select_location_args <- c(NULL, "above", "below")
  # assert_that(select_location %in% select_location_args,
  #             msg = paste("select_location value of", select_location, 
  #                         "must be either 'above', 'below', or NULL", sep = " "))
  
  # Output w/o selection
  if (missing(select_type) == TRUE) {
    items <- plotlyOutput(ns("plot"))
  } 
  else {
    # Select layout
    if (select_type == "radio") {
      select <- radioButtons(ns("select"),
                             choices = select_choices,
                             label = p(select_label),
                             inline = TRUE)
    } else if (select_type == "drop_down") {
      select <- selectInput(ns("select"),
                            choices = select_choices,
                            label = p(select_label),
                            selected = selected)
    } else {
      select <- checkboxGroupInput(ns("select"),
                                   choices = select_choices,
                                   label = p(select_label),
                                   selected = selected,
                                   inline = FALSE)
    }
    
    # Chart layout
    if (select_location == "above") {
      items <- list(select,
                    plotlyOutput(ns("plot")))
    } else if (select_location == "below") {
      items <- list(plotlyOutput(ns("plot")),
                    select)
    }
  }

  
  
  
  # Put together in box
  box_content <- list(h4(title_text), p(sub_title_text), items, p(source_text), br(textOutput(ns("info"))), imageOutput(ns("image")))
  
  # Return tagList with box content  
  fluidRow(
    tagList(
      box(box_content, width = 12)
    )
  )
  
}


#'
#' @title card_plot function
#' 
#' @description Generates the plotly chart on each card.
#' 
#' @return A plotly chart object.
#' 
#' @details
#' \code{card_plot} needs the data, fields, colors, and labels for the chart.
#' 
#' @param input autofilled by shiny.
#' @param output autofilled by shiny.
#' @param session character, must be the exact same as the id passed to the card_ui function.
#' @param df name of dataframe or "input". The function is built to handle one of three senarios:
#' \itemize{
#'   \item{There is no select input. In this case df is the name of the dataframe being used 
#'   in the chart (e.g. df = pop_per_neighborhood)}
#'   \item{There is a select input that involves selecting between different dataframes. In this
#'   case df = "input" and we will get the correct dataframe based on the user selection.}
#'   \item{There is a select input that involves subsetting a column in the dataframe. In this
#'   case we pass the name of the dataframe to df (e.g. df = pop_per_neighborhood) and we use
#'   @param filter_field to delcare the column we are filtering (e.g. filter_field = "Neighborhood")}
#' }
#' @param x character, name of the field containing data to be plotted on the x-axis. 
#' @param y character, name of the field containing data to be plotted on the y-axis. 
#' @param z character, name of the field containing data to be plotted on the y-axis. Default is NULL.
#' @param color_group character, name of the field containing data to color the chart by. 
#' @param mode character, default set to "lines+markers". Determines the types of markers for the chart.
#' For a scatter plot with no lines use "markers", for a line plot use "lines+markers". 
#' @seealso \url{https://plot.ly/python/reference/#scatter-mode}
#' @param filter_field character, optional. Used when a select input is being used that subset a specific 
#' column in a dataframe @seealso @param df
#' @param colors list, optional. List with set of colors to be used in chart 
#' (e.g. colors = c("#f46d43", "#3288bd", "#fee08b"))
#' @param plot_type character, defines the type of chart to be built. See \url{https://plot.ly/r/#basic-charts}
#' for addition information
#' @param tooltip_text object, optional. Determines content for tooltip. Best to use paste() function as it
#' enables the ability to put text and column values together. When passing a column value to the tooltip the "~"
#' must be placed before paste() so the fields get evaluated 
#' (e.g. tooltip_text = ~paste("Year:", year, "<br>Neighborhood:", neighborhood, sep = " "))
#' @param xaxis_label character, text for x-axis label.
#' @param yaxis_label character, text for y-axis label.
#' @param yaxis_range vector, optional. Vector defining max and min of y-axis (e.g. yaxis_range = c(0,100))
#' @param tick_suffix character, optional. Text symbol for y-axis tick suffix (e.g. tick_suffix = "%")
#' @param tick_prefix character, optional. Text symbol for y-axis tick prefix (e.g. tick_suffix = "$")
#' @param annotations list, optional. Used to add annotations to the plot if applicable. Annotations
#' require their own set of parameters outlined here: \url{https://plot.ly/r/text-and-annotations/#single-annotation}.
#' @param xaxis_margin numeric, optional. Allows the use to increase the space between the x-axis tick marks and the 
#' x-axis label. Increased to around 160 for long text labels. 
#' @param add_traces list, optional. Allows user to pass list of pre-defined traces to the plot. Multiple
#' traces can be added to the list and the function will iterate through them and add each to the plot.
#' Traces require their own set of parameters outlined here: \url{https://plot.ly/r/reference/}
#' 


## Card Server Function ##
card_plot <- function(input,
                      output,
                      session,
                      df,
                      x,
                      y,
                      z = NULL,
                      color_group = NULL,
                      mode = "markers",
                      filter_field = NULL,
                      colors = NULL, 
                      plot_type,
                      tooltip_text = NULL,
                      xaxis_label = "Year",
                      yaxis_label = "",
                      yaxis_range = c("None", "None"),
                      tick_suffix = "",
                      tick_prefix = "",
                      annotations = NULL,
                      xaxis_margin = NULL,
                      xaxis_categoryorder = NULL,
                      xaxis_categoryarray = NULL,
                      add_traces = NULL,
                      more_info = FALSE,
                      show_image = FALSE) {
  
  # Get correct data
  if (df == "input") {
    selected_data <- reactive({
      selected_data <- get(input$select)
      print(names(input$select))
      return(selected_data)
    })
  } else {
    selected_data <- reactive({
      # get input function
      get_input <- function(x, column, n) {
        df %>% filter_(lazyeval::interp(quote(x %in% y), 
                                        x=as.name(column),
                                        y=n))
      }
      
      if (is.null(input$select)) {
        selected_data <- df
      } else {
        selected_data <- get_input(df, filter_field, input$select)
      }
      return(selected_data)
      
    })
  } 
  
  if (plot_type == "bar") {
    marker = list(line=list(color="#202C39", width=0))
  } else if (mode == "lines+markers") {
    line = list(width=4)
    marker = list(size=8)
  } else if (mode == "markers") {
    line = list(width=0)
    marker = list(size=15, line=list(color="#202C39", width=1))
  }
  
  # Make arguments formulas
  
  # x
  x <- as.formula(paste0("~", x))
  
  # y
  y <- as.formula(paste0("~", y))
  
  # z 
  if (is.null(z) == FALSE) {
    z <- as.formula(paste0("~", z))
  } else {z <- z}
  
  # color_group
  if (is.null(color_group) == FALSE) {
    color_group <- as.formula(paste0("~", color_group))
  } else {color_group <- color_group}
  
  # Create chart
  output$plot <- renderPlotly({
    
    p <- plot_ly(selected_data(), 
                 x = x,
                 y = y,
                 z = z,
                 color = color_group, 
                 colors = colors,
                 type = plot_type, 
                 line = line, 
                 mode = mode, 
                 marker = marker,
                 text = tooltip_text, 
                 hoverinfo = "text") %>%
      layout(font = list(family = "Lora", size = 14),
             xaxis = list(title = xaxis_label, 
                          fixedrange = TRUE, 
                          linecolor = "#A9A9A9",
                          categoryorder = xaxis_categoryorder,
                          categoryarray = xaxis_categoryarray), 
             yaxis = list(title = yaxis_label, 
                          fixedrange = TRUE, 
                          linecolor = "#A9A9A9",
                          ticksuffix = tick_suffix,
                          tickprefix = tick_prefix, 
                          zeroline = FALSE, 
                          range = yaxis_range),
             annotations = annotations,
             margin = list(b = xaxis_margin)) %>%
      config(displayModeBar = F)
    
    if (is.null(add_traces)) {
      return(p)
    } else {
      for (i in 1:length(add_traces)) {
        trace <- add_traces[[i]]
        p <- add_trace(p,
                       x = trace$x, 
                       y = trace$y, 
                       marker = trace$marker, 
                       mode = trace$mode, 
                       type = trace$type,
                       inherit = TRUE,
                       showlegend = FALSE)
      }
      return(p)
    }
    
  })
  
  
  
  
  
  
  ## Add text about the selected country
  output$info <- renderText({

    if(!more_info) {
      
      return(paste("More information on", input$select, "coming soon!", sep=" "))
      
      } else {
      
        display_text <- countryInfo %>%
          filter(country == input$select) %>%
          select(description) %>%
          .$description

        return(display_text)

              }
    })

  
  ## Add mariculture image for selected country
  ## Need to adjust size of image
  output$image <- renderImage({
  
  
      country_full <- input$select
      country <- str_replace_all(tolower(country_full), " ", "")
      
      list(src = paste("images/mar/",country,".png",sep=""),
           contentType = "image/png",
           width = 400,
           height = 300)
   
  },deleteFile=FALSE)
  
  return(data)
  
}
