
function(input, output, session) {
  
  ## Fisheries Production ##
  # callModule(card_plot, "fis_prod",
  #            df = fis_harvest,
  #            x = "year",
  #            y = "bbmsy",
  #            color_group = "stock_id",
  #            filter_field = "country",
  #            colors = cols,
  #            plot_type = "scatter",
  #            mode = "lines+markers",
  #            tooltip_text = ~paste("Tonnes:", round(bbmsy, digits = 1), 
  #                                  "<br>Species:", str_replace(str_extract(fis_harvest$stock_id, "^(\\w+)_(\\w+)"),"_"," "), sep=" "),
  #            xaxis_label = "Year",
  #            yaxis_label = "Biomass / Max Sustainable Yield")
  
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
             tooltip_text = ~paste("Tonnes:", prettyNum(tonnes, big.mark=","), # format numbers > 1,000
                                   "<br>Species:", species, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Annual Production (tonnes)")
  
  
  ## Mariculture Baseline Metrics ##
  callModule(summary_stats, "mar_baseline",
             number_boxes = 3,
             statistic = list("19%", "68%", "51%"),
             text = list("of global seafood comes from mariculture. Aquaculture, which includes marine and inland production, contributes 53% to all seafood provision.",
                         "of mariculture produced in 2016 for human consumption came from China. They are followed by South Korea at only 4%!",
                         "of mariculture is comprised of shellfish production by weight. The remaining 33% is from seaweed and 15% from fish."))
  

  ## Mariculture Global Map ##
  callModule(card_map, "mar_global_map",
             data = mar_global_map,
             field = "input",
             filter_field = type, # type of data to plot
             display_field = "map_data",
             display_units = "units",
             color_palette = ygb,
             legend_title = "Legend",
             popup_title = "country")

  


  }
