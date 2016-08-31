#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for application that draws the plot, based on user input
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Interesting Metrics for 2007 US Highway Accidents"),
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. 
  sidebarLayout(
    sidebarPanel(
      radioButtons("dist", "Choose your Metric:",
                   c("Total Persons Involved" = "PERSONS",
                     "Pedestrians-Only Count" = "PEDS",
                     "Highway Width (Lane Count)" = "NO_LANES",
                     "Speed Limit (mph)" = "SP_LIMIT",
                     "Fatality Count" = "FATALS",
                     "Drunk Driver" = "DRUNK_DR")),
      br(),
      
      sliderInput("n", 
                  "Choose GSA State Code*:", 
                  value  = 06,
                  min    = 1, 
                  max    = 56,
                  step   = 1),
    
      HTML('<footer>
*01-Alabama
02-Alaska
           04-Arizona
           05-Arkansas
           06-California
           08-Colorado
           09-Connecticut
           10-Delaware
           11-District of Columbia
           12-Florida
           13-Georgia
           15-Hawaii
           16-Idaho
           17-Illinois
           18-Indiana
           19-Iowa
           20-Kansas
           21-Kentucky
           22-Louisiana
           23-Maine
           24-Maryland
           25-Massachusetts
           26-Michigan
           27-Minnesota
           28-Mississippi
           29-Missouri
           30-Montana
           31-Nebraska
           32-Nevada
           33-New Hampshire
           34-New Jersey
           35-New Mexico
           36-New York
           37-North Carolina
           38-North Dakota
           39-Ohio
           40-Oklahoma
           41-Oregon
           42-Pennsylvania
           43-Puerto Rico
           44-Rhode Island
           45-South
           46-South Dakota
           47-Tennessee
           48-Texas
           49-Utah
           50-Vermont
           51-Virginia
           52-Virgin Islands
           53-Washington
           54-West Virginia
           55-Wisconsin
           56-Wyoming
           </footer>')
       
 ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Histogram", plotOutput("plot")),
                  tabPanel("Frequency", tableOutput("table")),
                  tabPanel("Statistics", verbatimTextOutput("summary")) 
      )
      
    )
  )
))