
function(input, output, session) {
  
  
  ## Mariculture Production ##
  callModule(card_plot, "mar_prod",
             df = mar_harvest,
             x = "year",
             y = "tonnes",
             color_group = "species",
             filter_field = "country",
             colors = cols,
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Tonnes:", tonnes,
                                   "<br>Species:", species, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Annual Production (tonnes)")
  
  callModule(baseline_metrics, "mar_baseline",
             goal_name = "MAR",
             first = "Global Mariculture Score",
             second = "Largest Share of Production",
             third = "Seafood per Capita",
             icon = "fish",
             color = "light-blue") # see ?validColors
  
  # 
  # callModule(baseline_metrics,"mar_baseline",
  #            number_boxes = 3,
  #            statistic = list("21.9%", "68%", "50,000"),
  #            text = list("Global Mariculture Score: healthy oceans maximize the marine cultivation potential and minimize impacts to the ecosystem",
  #                        "China contributes the largest historic share by tonnes of mariculture produced for human consumption",
  #                        "low- and middle-income households spend 50% or more of their income on housing"),
  #            icon = "home"
  #            )

  


  }
