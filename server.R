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
        Fire_Filt <- Fire_Filt[month(DISCOVERY_DATE) == as.numeric(input$SelectMonth) & STAT_CAUSE_DESCR == input$SelectCause]
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
    
    #-------Generate The Second Map -> A Geo Earth Map -------#
    output$GeoMap2 <- renderGvis({
        gvisMap(Fires2(), 'latlong',
                options = list(region = "US", displayMode = "Markers",
                               width = "auto", height = "auto", 
                               icons = "{default:{normal:'http://maps.gstatic.com/mapfiles/ms2/micons/firedept.png'}}"
                               )
                )
    })
    
    output$LatHist <- renderPlotly({
        plot_ly(x = ~WildFires[,LATITUDE], type = 'histogram', nbinsx = 35, color = 'red', alpha = 0.85)
    })
    
    output$LongHist <- renderPlotly({
        plot_ly(x = ~WildFires[,LONGITUDE], type = 'histogram', nbinsx = 35, color = 'red', alpha = 0.85)
    })
    
    observe({
        print(input$SelectMonth)
    })
    
}