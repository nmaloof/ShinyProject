ui <- dashboardPage(
    skin = "red",
    #---Header Code---#
    dashboardHeader(
        title = "US Wild Fires"
    ),
    
    #---Sidebar Code---#
    dashboardSidebar(
        sidebarMenu(
            menuItem("Place 1", tabName="PlaceHolder"),
            menuItem("Place 2", tabName="GraphBattle")
        )
    ),
    
    #---Body Code---#
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "PlaceHolder"
            ),
            #---TabItem1---#
            tabItem(
                tabName = "GraphBattle",
                fluidRow(
                    
                ),
                fluidRow(
                    
                )
            )
            #---TabItem1 Ends---#
        )
    )
)