library(shiny)
require(markdown)

# ui.R

library(datasets)
data(mtcars)
##mtcars$carnames <- row.names(mtcars)

shinyUI(fluidPage(
        titlePanel("Miles per gallon predictor"),
        tabsetPanel(
        tabPanel("Predictor",
        sidebarLayout(

                sidebarPanel(
                        
                        helpText(
                                "You can start typing a car name to filter the list"
                                ),
                        
                        selectizeInput(
                                'theCar', label = h4("Choose a car type"), choices = row.names(mtcars),
                                options = list(create = TRUE),
                                selected = "Datsun 710"
                        ),
                        helpText(
                                
                                h4("Description : "),br(),
                                "This app calculates the distance traveled by the selected car in miles for each gallon of fuel consumed by the vehicle. The model will try to predict the same as in the data set",
                                br(),br(),
                                "The input variable for prediction model are:",br(),
                                "1- The transmission type (Automatic or Manuel)",br(),
                                "2- The weight of the vehicle in 1000 Lbs", br(),
                                "3- The qsec of the vehicle (The number of seconds needed to complete a quarter mile starting from a standstill)"
                        )
                ),
                
                mainPanel(
                   tabsetPanel(
                      tabPanel("Predictor",
                          tableOutput("view"),
                          textOutput("mpg")
                      ),
                      tabPanel("Plots Graph",
                          plotOutput("mpgPlot")
                      )
                )   
               )
        )
),
tabPanel("About",
         mainPanel(
                 includeMarkdown("about.md")
         )
)

        ))
)