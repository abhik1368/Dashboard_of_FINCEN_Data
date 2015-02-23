library(shiny)
library(shinydashboard)
library(rCharts)
library(rjson)
library(dplyr)

shinyServer(function(input, output) {
  
  suspcatYear <- reactive({
  
     df <- suspcatbyYear %>%
       filter(YEAR == input$year)
   
  })
  
  suspcatTypeYear <- reactive({
    
    df <- suspcatTypebyYear %>%
      filter(YEAR == input$year)  
  })
  
  ADD_suspcatYear <- reactive({
    
    df <- suspcatbyYear %>%
      filter(YEAR == input$ADDyear)
    
  })
  
  ###SUSPICIOUS ACTIVITY CATEGORY TOTALS BY YEAR
  output$activityCat <- renderChart2({
 
    x <-  suspcatYear()
 
    a <- hPlot(x = "SUSPICIOUS_ACTIVITY_CATEGORY", y = "NUMBER_OF_FILINGS", data = x, type = "pie")
    a$title(text = "Number of Filings by Suspicious Activity Category")
    a$plotOptions(width=600, height=400)
    a$tooltip(shared = TRUE)
    a$exporting(enabled = T)
    a$addParams(dom = "activityCat")
  
    return(a)
 
  })
  
  output$activityType <- renderChart2({

    x <-  suspcatTypeYear()
    y <- input$year
    x <- x[x$YEAR == y, ]
    data <- x[x$SUSPICIOUS_ACTIVITY_CATEGORY %in% input$suspCat,]
 
    
    d1 <- dPlot(
      SUSPICIOUS_ACTIVITY_TYPE ~ NUMBER_OF_FILINGS,
      groups = "SUSPICIOUS_ACTIVITY_CATEGORY",
      data = data,
      type = "bar",
      width = 1200,
      bounds = list(x=450, y=35, width=800, height=300)
    )
    d1$xAxis(size = 8, type = "addMeasureAxis", outputFormat="#,")
    d1$yAxis(size = 8, type = "addCategoryAxis", orderRule = "SUSPICIOUS_ACTIVITY_TYPE")
    d1$legend(
      x = 0,
      y = 5,
      width = 800,
      height = 20,
      horizontalAlign = "right"
    )
    return(d1)
    
    
  })
  
  
  ###MONTH TOTALS BY YEAR
  output$activityMonth <- renderChart2({
    
    x <- monthYear
    y <- input$year
    x <- x[x$YEAR == y, ]
    
    a <- hPlot(NUMBER_OF_FILINGS ~ MONTH, data = x, type = "column")
    a$title(text = "Number of Filings by Month")
    a$tooltip(shared = TRUE)
    a$exporting(enabled = T)
    a$addParams(dom = "activityMonth")
    
    return(a)
    
  })
  
  ###STATE TOTALS BY YEAR
  output$activityState <- renderChart2({
    
    sel <- input$states
    x <- stateYear
    y <- input$year
    x <- x[x$YEAR == y, ]
    data <- x[x$STATE %in% sel,]
    
    a <- hPlot(NUMBER_OF_FILINGS ~ STATE, data = data, type = "column")
    a$title(text = "Number of Filings by State")
    a$tooltip(shared = TRUE)
    a$exporting(enabled = T)
    a$addParams(height = 300, dom = "activityState")
    
    return(a)
   
  })
  
  ###GAMING TOTALS BY YEAR
  output$activityGaming <- renderChart2({
    
    x <- gamingYear
    y <- input$ADDyear
    x <- x[x$YEAR == y, ]
    
    a <- hPlot(x = "TYPE_OF_GAMING_ESTABLISHMENT", y = "NUMBER_OF_FILINGS", data = x, type = "pie")
    a$title(text = "Number of Filings by Gaming Establishment")
    a$tooltip(shared = TRUE)
    a$exporting(enabled = T)
    a$addParams(dom = "activityGaming")
    
    return(a)
    
    
  })
  
  ###PAYMENT TOTALS BY YEAR
  output$activityPayment <- renderChart2({
    
    x <- paymentYear
    y <- input$ADDyear
    x <- x[x$YEAR == y, ]
    
    a <- hPlot(x = "PAYMENT_INSTRUMENT_TYPE", y = "NUMBER_OF_FILINGS", data = x, type = "pie")
    a$title(text = "Number of Filings by Payment Type")
    a$tooltip(shared = TRUE)
    a$exporting(enabled = T)
    a$addParams(dom = "activityPayment")
    
    return(a)
    
  })
  
  ##### DATA TABLES #####
  
  output$suspCatType <- renderDataTable(suspcatTypebyYear, options = list(pageLength = 10))
  
  output$month <- renderDataTable(monthYear, options = list(pageLength = 10))
  
  output$state <- renderDataTable(stateYear, options = list(pageLength = 10))
  
  output$gaming <- renderDataTable(gamingYear, options = list(pageLength = 10))
  
  output$payment <- renderDataTable(paymentYear, options = list(pageLength = 10))
 
})