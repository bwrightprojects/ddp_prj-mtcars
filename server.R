library(shiny)

# load teh mtcars dataset
library(datasets)
data(mtcars)

# Fit a linear model for the prediciton.  user wt, qsec and am
fit<-lm(mpg ~ I(wt-mean(wt)) + I(qsec-mean(qsec)) + factor(am)-1, data=mtcars)
##fit<-lm(mpg ~ I(wt-mean(wt)) + I(qsec-mean(qsec)) + factor(am)-1 + factor(cyl)-1, data=mtcars)

#' MPG Calculator
#' @param selected car
#' @return MPG
#'
mpg_calc <- function(selCar){
        
        # Subset data to one selected in ui.R
        selectedCar<-mtcars[selCar,]
        
        # load up a pediction dataset (pdDate) with subset data
        pdData<-data.frame(cyl=selectedCar$cyl,hp=selectedCar$hp,wt=selectedCar$wt,am=selectedCar$am,qsec=selectedCar$qsec)
        pdData$am<-factor(pdData$am)
        pdData$cyl<-factor(pdData$cyl)
        
        # Use the linear model to predict the MPG for the selected car and return
        mpg<-0
        mpg<-round(predict(fit,newdata=pdData),2)
        
}


shinyServer(
        function(input, output) {
                formulaString <- reactive({
                        mtcars[input$theCar,]
                        paste("~mpg+qsec+wt+am")
                })
                # Display the selected data for the car selected by the user
                output$view <- renderTable({
                        mtcars[input$theCar,]
                })
                
                # output the predicted MPG
                output$mpg <- renderText({ 
                        
                        paste("Estimted Predicted Mpg is : " , mpg_calc(input$theCar))
                                        
                })
                
                output$mpgPlot <- renderPlot({
                        with(mtcars, {
                             pairs(as.formula(formulaString()), main = formulaString())
                        })
                })
                        
    
        }
)