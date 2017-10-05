ui <- dashboardPage(
    skin = "black",
    dashboardHeader(
        title = "U.S Wild Fires"
    ),
    dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Geography", tabName = "MapTab"),
            menuItem(text = "Locations", tabName = "MapTab2"),
            menuItem(text = "State Level", tabName = "StateTab"),
            menuItem(text = "Temperature", tabName = "TempTab")
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "MapTab",
                fluidPage(
                    h1("Geographical Spread of Wild Fires"),
                    fluidRow(
                        column(
                            width = 5,
                            offset = 1,
                            selectizeInput(
                                inputId = "SelectParam",
                                label = "Choose a Parameter to Visualize",
                                choices = c("All", "Miscellaneous", "Lightning", "Debris Burning", "Campfire", 
                                            "Equipment Use", "Arson", "Children", "Railroad", "Smoking",
                                            "Powerline", "Structure", "Fireworks", "Missing/Undefined"),
                                multiple = TRUE,
                                selected = "All",
                                options = list(placeholder = "Select Cause(s)")
                            )
                        ),
                        column(
                            width = 5,
                            offset = 1,
                            selectizeInput(
                                inputId = "SelectYear",
                                label = "Choose the Years to Visualize",
                                choices = c("All",as.character(1992:2015)),
                                multiple = TRUE,
                                selected = "All",
                                options = list(placeholder = "Select Year(s)")
                            )
                        )
                    ),
                    box(
                        width = 12,
                        plotlyOutput(outputId = "GeoMap1"),
                        background = "red"
                    )
                )
            ),
            #------------------------------------------------------------------------------#
            tabItem(
                tabName = "MapTab2",
                fluidPage(
                    h1("Exact Fire Locations"),
                    box(
                        width = 12,
                        plotlyOutput(outputId = "GeoMap2"),
                        background = "red"
                    )
                )
            ),
            
            tabItem(
                tabName = "StateTab",
                fluidPage(
                    h1("Wild Fires at the State Level")
                )
            ),
            tabItem(
                tabName = "TempTab",
                fluidPage(
                    h1("Wild Fire's With Temperature")
                )
            )
        )
    )
)