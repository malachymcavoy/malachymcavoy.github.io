#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(readxl)
library(shiny)
library(ggplot2)
library(dplyr)
nflData <- read_excel("Malachy2022-04-24.xlsx") %>% group_by(Rnd)

# Define UI for application that draws a histogram 
ui <- fluidPage(
    sidebarLayout(
    sidebarPanel(sliderInput("samplesize",
                             "Sample Size:",
                             min = 100,
                             max = 10000,
                             value = 1000)),
    mainPanel(plotOutput("distPlot"))
    )
)


# Define UI for application that draws a histogram 
ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(sliderInput("Year",
                                 "Year",
                                 min = 2001,
                                 max = 2021,
                                 value = 2021)),
        mainPanel(plotOutput("barplot"))
    )
)




# Define server logic required to draw a histogram
server <- function(input, output) { output$barplot <- renderPlot({
    hist(rnorm(input$wAV),
         col='darkorchid',
         xlab="Sample",
         main="Normally Distributed Sample")},
    height=300
) }


# Define server logic required to draw a histogram
server <- function(input, output) { output$barplot <- renderPlot({
    ggplot(data = nflData,
           aes(x = Rnd,
               y = wAV,
               fill = Rnd))},
    height=300
) }



# Run the application 
shinyApp(ui = ui, server = server)




