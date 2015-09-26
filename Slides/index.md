---
title       : MPG Predictor using mtcars
subtitle    : Are the MPG listed for each car similar to the predicted MPG?
author      : bwright.projects
job         : 
framework   : io2012       # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- &twocol w1:40% w2:60%

## Introduction
  
*** =left
With all the news stories about car  manufactures using technology and other means to quote miles per gallon (mpg), a predictive tool can help you understand the mpg based Onondaga historic data and various models.  

The MPG prediction app is one such app.  
   * Use the latest technology to predict MPG
   * Check the published MPG with a cacluated MPG

*** =right
### Part 1: Shiny App
Using the mtcars data set to predict miles per gallon (MPG)

*https://bwrightprojects.shinyapps.io/ddp_prj-mtcars/*

Github Repo

*https://github.com/bwrightprojects/ddp_prj-mtcars*

### Part 2: Reproducible Presentation

*http://bwrightprojects.github.io/ddp_prj-mtcars/index.html* 

--- .class #id

## Dataset

### Motor Trend Car Road Tests
The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).

### Source
Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.


```r
library(datasets)
head(mtcars, 2)
```

```
##               mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
```

---

## Format
A data frame with 32 observations on 11 variables.
  
1. `mpg` Miles/(US) gallon
1. `cyl` Number of cylinders 
1. `disp` Displacement (cu.in.) 
1. `hp` Gross horsepower 
1. `drat` Rear axle ratio 
1. `wt` Weight (lb/1000) 
1. `qsec` 1/4 mile time 
1. `vs` V-engine / Standard 
1. `am` Transmission (0 = automatic, 1 = manual) 
1. `gear` Number of forward gears 
1. `carb` Number of carburetors 

---

## Reactive Server Code
  

```r
#' MPG Calculator
#' @param selected car
#' @return MPG
#'
mpg_calc <- function(selCar) {
    # Subset data to one selected in ui.R
    selectedCar <- mtcars[selCar, ]
    
    # load up a pediction dataset (pdDate) with subset data
    pdData <- data.frame(cyl = selectedCar$cyl, hp = selectedCar$hp, wt = selectedCar$wt, 
        am = selectedCar$am, qsec = selectedCar$qsec)
    pdData$am <- factor(pdData$am)
    pdData$cyl <- factor(pdData$cyl)
    
    # Use the linear model to predict the MPG for the selected car and return
    mpg <- 0
    mpg <- round(predict(fit, newdata = pdData), 2)
}
```








