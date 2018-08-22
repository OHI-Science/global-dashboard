# global-dashboard

ui.R, server.R
Main components of the shiny dashboard. Defines user interface and server separately.

global.R
Contains global set-up, libraries, color palettes, and final wrangling.


## modules
modules/baseline_metrics_card.R
Creates the baseline metrics that can be recycled for each goal based on globally-defined datasets..

modules/chart_card.R
Creates graphs that can be recycled for each goal.

modules/map_card.R
Creates maps that can be recycled for each goal.


## functions
functions/front_page.R
Edit this script to change the content in the homepage (The OHI Story). Elements are customized in www/custom.css


## www
custom.css
Define html classes here to customize elements in the global-dashboard


## int
Folder for storing wrangled data tables.


## tmp
Folder for testing script