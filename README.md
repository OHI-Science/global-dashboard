# global-dashboard

The OHI Global Dashboard is a data exploration tool for visualizing data used to calculate each of the goal scores.

# Future Considerations
- **Map Module**: add a date range component option to map if possible at the bottom? allow for year selection OR play button to see change over time
- **Map Module**: currently color scheme set to colorQuantile, could be interesting to add option to select colorQuantile, colorNumeric or other in setting pal (palette)
- **Map Module**: Customize popup message on global map to allow for optional 2nd row (currently you must specify the argument otherwise it reads NA)
- **Map Module**: would be cool to have data sources be reactive to the type of data the user picks since may have different data sources. At the moment all data sources listed at once (if possible).
- **Mariculture**: visualize Trujillo Sustainability Scores data
- **Mariculture**: production per capita more interesting to see over time (per consultation with Halley), may or may not be appropriate for the dashboard. Want to keep it uncluttered!!
- **General**: Jamie's figure fis v mariculture gif?? incorporate somewhere?
- **General**: Mariculture is a sub-goal that feeds into Food Provision. Is there way to have subheadings in the subheader?? So that you differentiate between goals and sub-goals?


# Repository Structure 
**ui.R, server.R**

Main components of the shiny dashboard. The UI is the user interface for the shiny app, including layout and text elements. The server for shiny app is where you add custom, interactive charts and maps for each goal.

**global.R**

Contains global set-up, libraries, color palettes, and final wrangling.

**front_page.R**

Edit this script to change the content in the homepage (The OHI Story). Elements are customized in www/custom.css


## modules
**modules/summary_stats_card.R**

Creates the summary statistics shiny output. Define stats and text each time. Contains a ui and server-associated function.

**modules/chart_card.R**

Creates graphs that can be recycled for each goal. Contains a ui and server-associated function.

**modules/map_card.R**

Creates maps that can be recycled for each goal. Contains a ui and server-associated function.


## functions
**functions/tab_title.R**

Creates the header or information section in each tab.


## slidedeck
**slidedeck/modules_slidedeck.Rmd**

Add or edit the `xaringan` presentation. Knit to html for viewing in browser

**slidedeck/modules_slidedeck.html**

View slide deck tutorial for the global dashboard shiny app.

 
## www
**www/custom.css**

Define html classes here to customize elements in the global-dashboard. www/img
Images that are called by CSS in front_page.R.


## int
_Folder for storing wrangled data tables._


## tmp
_Folder for testing code._

**tmp/test_global_map.Rmd**

To test the leaflet map with data. 

**tmp/summary_stats.Rmd**

Use to wrangle data and derive stats for summary stats module.

**tmp/test_front_pg.R**

Use to test front page css code.
