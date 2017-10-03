#-----Connect to the Database-----#
dbConnecter <- function(session, dbname){
    require(RSQLite)
    conn <- dbConnect(drv = SQLite(), dbname = dbname)
    #---Disconnect DBase on Session End---#
    session$onSessionEnded(function(){
        dbDisconnect(conn)
    })
    
    #---Returns Connection---#
    conn
}

dbGetDataState <- function(conn, tblname, state){
    query <- paste0("SELECT * FROM ", tblname, " WHERE STATE = '", state, "'")
    as.data.table(dbGetQuery(conn = conn, statement = query))
}