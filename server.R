library(shiny)
library(plyr)
# Define server logic for computing Metric using dataset "2007_ACCIDENT2007-FullDataSet.csv"
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested Metric Plot.
  # This is called whenever the inputs change. The output
  # functions defined below then all use the value computed from
  # this expression
  
  adata <-read.csv("./Data/2007_ACCIDENT2007-FullDataSet.csv",header = TRUE)
  
  data <- reactive({
    dist <- switch(input$dist,
                   PERSONS     = cbind(adata$STATE,adata$PERSONS),
                   PEDS        = cbind(adata$STATE,adata$PEDS),
                   NO_LANES    = cbind(adata$STATE,adata$NO_LANES),
                   SP_LIMIT    = cbind(adata$STATE,adata$SP_LIMIT),
                   FATALS      = cbind(adata$STATE,adata$FATALS),
                   DRUNK_DR    = cbind(adata$STATE,adata$DRUNK_DR),
                   cbind(adata$STATE,adata$PERSONS))
  })
  
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$plot <- renderPlot({
    dist <- input$dist
    df <- subset (as.data.frame(data()) , V1== input$n)
    if (nrow(df) >0 ) {
    H <- hist(as.numeric(df$V2)) 
    H$density <- with(H, 100 * density* diff(breaks)[1])
    labs <- paste(round(H$density), "%", sep="")
    plot(H, freq = TRUE, labels = labs, ylim=c(0, 1.08*max(H$counts)), 
         col="green", border="blue", ylab="Accident Count", xlab=" ",
         main=paste(' ', dist,  sep=''))
    }
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    df <- subset (as.data.frame(data()) , V1== input$n)
    summary(as.numeric(df$V2))
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    df <- subset (as.data.frame(data()) , V1== input$n)
    count(data.frame(x=as.numeric(df$V2)))
  })
  
})