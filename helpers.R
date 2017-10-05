dbConnecter <- function(session, dbname){
    require(RSQLite)
    conn <- dbConnect(drv = SQLite(), dbname = dbname)
    #---Disconnect Database on Session End---#
    session$onSessionEnded(function(){
        dbDisconnect(conn)
    })
    
    #---Returns Connection---#
    conn
}

dbGetData <- function(conn, tblname){
    query = paste("SELECT * FROM", tblname)
    as.data.table(dbGetQuery(conn = conn, statement = query))
}