ui <- dashboardPage(
    skin = "red",
    #---Header Code---#
    dashboardHeader(
        title = "US Wild Fires"
    ),
    
    #---Sidebar Code---#
    dashboardSidebar(
        sidebarMenu(
            menuItem("Place 1", tabName = "PlaceHolder"),
            menuItem("State vs State", tabName = "GraphBattle"),
            menuItem("Place 3", tabName = "GraphPage2")
        )
    ),
    
    #---Body Code---#
    dashboardBody(
        tabItems(
            #---Tab Item 1---#
            tabItem(
                tabName = "PlaceHolder"
            ),
            #---Tab Item 1 Ends---#
            
            #---Tab Item 2---#
            tabItem(
                tabName = "GraphBattle",
                #Selectize Choices for the State#
                fluidRow(
                    column(
                        width = 6,
                        selectizeInput(
                            inputId = "State1",
                            label = "Choose a State",
                            choices = state.abb
                        )
                    ),
                    column(
                        width = 6,
                        selectizeInput(
                            inputId = "State2",
                            label = "Choose a State",
                            choices = state.abb
                        )
                    )
                ),
                #Plot for the causes of Fire#
                fluidRow(
                    box(
                        plotlyOutput(outputId = "BarState1")
                    ),
                    box(
                        plotlyOutput(outputId = "BarState2")
                    )
                ),
                #Plot for the amount of Fires Over Time#
                fluidRow(
                    box(
                        plotlyOutput(outputId = "LineState1")
                    ),
                    box(
                        plotlyOutput(outputId = "LineState2")
                    )
                )
                
                
            )
            #---Tab Item2 Ends---#
            
        )
    )
)