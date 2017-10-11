ui <- dashboardPage(
    skin = "black",
    dashboardHeader(
        title = "U.S Wild Fires"
    ),
    dashboardSidebar(
        sidebarUserPanel(
            name = "Nicholas Maloof",
            image = "https://media.licdn.com/mpr/mpr/shrinknp_100_100/AAEAAQAAAAAAAAi7AAAAJDNkZmRjZThkLWZhMDMtNDdlMi1hZmYxLThlYWU2NzA5MjU2ZA.jpg"
        ),
        sidebarMenu(
            menuItem(text = "Geography", tabName = "MapTab", icon = icon("map")),
            menuItem(text = "Locations", tabName = "MapTab2", icon = icon("map-marker")),
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
                        htmlOutput(outputId = "GeoMap1"),
                        background = "red"
                    )
                )
            ),
            #------------------------------------------------------------------------------#
            tabItem(
                tabName = "MapTab2",
                fluidPage(
                    h1("Exact Fire Locations"),
                    fluidRow(
                        column(
                            width = 3,
                            offset = 1,
                            selectInput(
                                inputId = "SelectYear2",
                                label = "Please Select a Year",
                                choices = as.character(1992:2015),
                                selected = "1992"
                            )
                        ),
                        column(
                            width = 3,
                            offset = 1,
                            selectInput(
                                inputId = "SelectMonth",
                                label = "Select a Month",
                                choices = list("January" = 1, "February" = 2,
                                               "March" = 3, "April" = 4, "May" = 5,
                                               "June" = 6, "July" = 7, "August" = 8, "September" = 9,
                                               "October" = 10, "November" = 11, "December" = 12)
                            )
                        ),
                        column(
                            width = 3,
                            offset = 1,
                            selectInput(
                                inputId = "SelectCause",
                                label = "Select a Cause",
                                choices = c("Miscellaneous", "Lightning", "Debris Burning", "Campfire",
                                            "Equipment Use", "Arson", "Children", "Railroad", "Smoking",
                                            "Powerline", "Structure", "Fireworks", "Missing/Undefined")
                            )
                        )
                    ),
                    
                    box(
                        width = 12,
                        htmlOutput(outputId = "GeoMap2")
                    ),
                    column(
                        width = 12,
                        box(
                            width = 6,
                            plotlyOutput(outputId = "LatHist")
                        ),
                        box(
                            width = 6,
                            plotlyOutput(outputId = "LongHist")
                        )
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