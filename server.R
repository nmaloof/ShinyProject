library(data.table)
library(dplyr)

server <- function(input, output, session){
    WildFires <- fread("WildFires.csv")
    
    Fires1 <- reactive({
        if(input$SelectParam == "All" && input$SelectYear == "All"){
            return(WildFires[, .(TotalFires = .N), by = STATE])
        }else if(input$SelectParam != "All" && input$SelectYear == "All"){
            return(WildFires[STAT_CAUSE_DESCR %in% input$SelectParam, .(TotalFires = .N), by = STATE])
        }else if(input$SelectParam == "All" && input$SelectYear != "All"){
            return(WildFires[as.character(FIRE_YEAR) %in% input$SelectYear, .(TotalFires = .N), by = STATE])
        }else{
            return(WildFires[STAT_CAUSE_DESCR %in% input$SelectParam & as.character(FIRE_YEAR) %in% input$SelectYear, .(TotalFires = .N), by = STATE])
        }
    })
    
    Fires2 <- reactive({
        Fire_Filt <- WildFires[FIRE_YEAR == as.numeric(input$SelectYear2)]
        Fire_Filt$DISCOVERY_DATE <- as.Date(Fire_Filt$DISCOVERY_DATE)
        Fire_Filt <- Fire_Filt[month(DISCOVERY_DATE) == as.numeric(input$SelectMonth)]
        Fire_Filt$latlong <- paste(Fire_Filt$LATITUDE, Fire_Filt$LONGITUDE, sep = ':')
        return(Fire_Filt)
    })
    
    #-------Generate The First Geographic Map -> A Heat Map -------#
    output$GeoMap1 <- renderGvis({
        gvisGeoChart(Fires1(), "STATE", "TotalFires",
                     options = list(region = "US", displayMode = "regions", resolution = "provinces",
                                    colorAxis = "{colors:['#ffffff', '#0d0d0d']}", backgroundColor = 'lightblue',
                                    title = "Total Number of Fires", width = "auto", height = "auto")
                     )
    })
    
    #-------Generate The First Geographic Map -> A Heat Map -------#
    # output$GeoMap2 <- renderPlotly({
    #     plot_mapbox(data = WildFires[1:10000], lat = ~LATITUDE, lon = ~LONGITUDE, 
    #                 split = ~STAT_CAUSE_DESCR, size = 2, mode = "scattermapbox") %>%
    #         layout(title = "Locations of Fires")
    # })
    
    #-------Generate The Second Map -> A Geo Earth Map -------#
    output$GeoMap2 <- renderGvis({
        gvisMap(Fires2(), 'latlong',
                options = list(region = "US", displayMode = "Markers",
                               width = "auto", height = "auto")
                )
    })
    
    observe({
        print(input$SelectMonth)
    })
    
}