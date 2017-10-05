server <- function(input, output, session){
    WildFires <- fread("WildFires.csv")
    
    #-------Generate The First Geographic Map -> A Heat Map -------#
    output$GeoMap1 <- renderPlotly({
        if(input$SelectParam == "All" && input$SelectYear == "All"){
            Fires <- WildFires[, .(TotalFires = .N), by = STATE]
        }else if(input$SelectParam != "All" & input$SelectYear == "All"){
            Fires <- WildFires[STAT_CAUSE_DESCR %in% input$SelectParam, .(TotalFires = .N), by = STATE]
        }else if(input$SelectParam == "All" & input$SelectYear != "All"){
            Fires <- WildFires[as.character(FIRE_YEAR) %in% input$SelectYear, .(TotalFires = .N), by = STATE]
        }else{
            Fires <- WildFires[STAT_CAUSE_DESCR %in% input$SelectParam & as.character(FIRE_YEAR) %in% input$SelectYear, .(TotalFires = .N), by = STATE]
        }
        
        g <- list(
            scope = 'usa',
            projection = list(type = 'albers usa'),
            showlakes = TRUE
            # bgcolor = "rgba(51,153,255,1)",
            # paper_bgcolor = '#191A1A'
        )
        plot_geo(Fires,locationmode = 'USA-states') %>% 
            add_trace(z = ~TotalFires, locations = ~STATE, color = ~TotalFires, colors = 'Reds') %>% 
            colorbar() %>%
            layout(title = 'Fire Count by Cause and Year', geo = g)
    })
    
    #-------Generate The First Geographic Map -> A Heat Map -------#
    output$GeoMap2 <- renderPlotly({
        plot_mapbox(data = WildFires[1:10000], lat = ~LATITUDE, lon = ~LONGITUDE, 
                    split = ~STAT_CAUSE_DESCR, size = 2, mode = "scattermapbox") %>%
            layout(title = "Locations of Fires")
    })
    
    
    
    
    
    observe(
        {
            #print(str(WildFires))
        }
    )
}