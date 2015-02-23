library(shiny)
library(shinydashboard)
library(rCharts)




header <- dashboardHeader(title = "FINCEN SARC")

sidebar <- dashboardSidebar(
  
  sidebarMenu(
    
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "Coming Soon", badgeColor = "red"), 
    
    menuItem("Charts", icon = icon("bar-chart"), tabName = "charts"),
    
    menuItem("Data", icon = icon("table"), tabName = "data")
  )
  )

body <- dashboardBody(
  tabItems(
    
    # First tab content
    tabItem(tabName = "dashboard", 
            
            fluidRow(
              
              box(
                title = "Filings by Suspicious Activity Category", width = 10, solidHeader = TRUE, status = "primary", 
                collapsible = TRUE,
                showOutput("activityCat", "highcharts")
                ),
              
              box(
                title = "SARC's by Year", width = 2, background = "light-blue",
                collapsible = TRUE,
                selectizeInput("year", "Select Year:", choices = suspcatbyYear$YEAR, selected = max(suspcatbyYear$YEAR), multiple = TRUE, options = list(maxItems = 1))
              )
            ),
                
            fluidRow(
              
              box(
                title = "Suspicious Activity Type", width = 2, background = "purple",
                collapsible = TRUE,
                checkboxGroupInput('suspCat', 'Check Categories to display:', 
                choices = unique(suspcatTypebyYear$SUSPICIOUS_ACTIVITY_CATEGORY), 
                selected = unique(suspcatTypebyYear$SUSPICIOUS_ACTIVITY_CATEGORY)[4:9])
             ),
                
                box(
                  title = "Filings by Type", width = 10, solidHeader = TRUE, status = "warning",
                  collapsible = TRUE,
                  showOutput("activityType", "dimple")
                )
                
              ),
              
            
            fluidRow(
              
              box(
                title = "Filings by Month", width = 10, solidHeader = TRUE, status = "success",
                collapsible = TRUE,
                showOutput("activityMonth", "highcharts"))
              ),
            
            fluidRow(
              
              box(
                title = "Filings by State", width = 10, solidHeader = TRUE, status = "info",
                collapsible = TRUE,
                selectizeInput("states", "Select States:", choices = stateYear$STATE, multiple = TRUE, selected = unique(stateYear$STATE)[10:30]),
                showOutput("activityState", "highcharts")
              )
            )

    ),
    
    # Second tab content
    tabItem(tabName = "widgets",
            
            h2("Widgets tab content - MORE TO COME")
            
           ### A place holder for now. Just here to demonstrate the badge Label and badge Color for this tab.
            
    ), 
    
    # Third tab content
    tabItem(tabName = "charts",
            
            h2("Yealy filings by gaming establishment & payment type."),
            
            fluidRow(
              
              box(
                title = "Casino/Card Club SARs by Year", width = 4,
                collapsible = TRUE,
                selectizeInput("ADDyear", "Select Year:", choices = suspcatbyYear$YEAR, selected = max(suspcatbyYear$YEAR), multiple = TRUE, options = list(maxItems = 1))
              )
            ),
            
            fluidRow(
              
              box(
                title = "Filings by Gaming Establishment", width = 10, solidHeader = TRUE, status = "warning",
                collapsible = TRUE,
                showOutput("activityGaming", "highcharts")
                )
              ),

            fluidRow(
              
              box(
                title = "Filings by Payment Type", width = 10, solidHeader = TRUE, status = "danger",
                collapsible = TRUE,
                showOutput("activityPayment", "highcharts")
              )
            )
          
            
    ),
            
    # Fourth tab content
    tabItem(tabName = "data",
            
            h2("Data Tables"),
            
            fluidRow(
                          
                          box(
                            title = "Suspicious Activity Category & Type", width = 8, status = "info",
                            collapsible = TRUE,
                            dataTableOutput("suspCatType")),
                          
                          box(
                            title = "Filings by Month", width = 4, status = "primary", 
                            collapsible = TRUE,
                            dataTableOutput("month")
                            )
                        ),
            fluidRow(
              
              box(
                title = "Filings by State", width = 6, status = "info",
                collapsible = TRUE,
                dataTableOutput("state")),
              
              box(
                title = "Filings by Gaming Establishment", width = 6, status = "primary", 
                collapsible = TRUE,
                dataTableOutput("gaming")
              )
            ),
            
            fluidRow(
              
              box(
                title = "Filings by Payment Type", status = "info",
                collapsible = TRUE,
                dataTableOutput("payment"))

            )
            
            
    )
    
  )
)



dashboardPage(header, sidebar, body, skin = "black")





