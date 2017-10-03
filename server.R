library(ggplot2)
library(plotly)
library(dplyr)

source("./helpers.R")

server <- function(input, output, session){
    #---Connect to the Database and Retreive Data---#
    conn <- dbConnecter(session, dbname = "./USWildFires.sqlite")
    FiresData1 <- reactive(dbGetDataState(conn = conn, tblname = "WildFires", state = input$State1))
    FiresData2 <- reactive(dbGetDataState(conn = conn, tblname = "WildFires", state = input$State2))
    
    
    #---Codes to make the Graphs and Change State Selected---#
    output$BarState1 <- renderPlotly({
        DT <- FiresData1()[,.(Count = .N), by = STAT_CAUSE_DESCR][,.(STAT_CAUSE_DESCR, RelFreq = Count/sum(Count))]
        plot_ly(data = DT, x = ~STAT_CAUSE_DESCR, y = ~RelFreq, type = 'bar')
    })
    
    output$BarState2 <- renderPlotly({
        DT <- FiresData2()[, .(Count = .N), by = STAT_CAUSE_DESCR][,.(STAT_CAUSE_DESCR, RelFreq = Count/sum(Count))]
        plot_ly(data = DT, x = ~STAT_CAUSE_DESCR, y = ~RelFreq, type = 'bar')
    })
    
    output$LineState1 <- renderPlotly({
        DT <- FiresData1()[,.(Count = .N),by = FIRE_YEAR]
        DT <- DT %>% arrange(., FIRE_YEAR)
        plot_ly(data = DT, x = ~FIRE_YEAR, y = ~Count, type = 'scatter', mode = 'lines')
    })
    
    output$LineState2 <- renderPlotly({
        DT <- FiresData2()[,.(Count = .N),by = FIRE_YEAR]
        DT <- DT %>% arrange(., FIRE_YEAR)
        plot_ly(data = DT, x = ~FIRE_YEAR, y = ~Count, type = 'scatter', mode = 'lines')
    })
    
    
    
    
    observe({
        print(input$State1)
    })
    
}