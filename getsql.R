
getsql <- function (sqlstring,db, usr, pwd, svr,stringsAsFactors = FALSE) {
  
  require(RODBC)
  myconn <- odbcDriverConnect('driver={SQL Server};server=svr;database=db;uid=usr;pwd=pwd')
  result <- sqlQuery(myconn, sqlstring, stringsAsFactors = stringsAsFactors)
  close(myconn)

  return (result)
}

listSQLTables <- function(svr) {
  require(RODBC)
  myconn <- if (svr=="K3") odbcDriverConnect('driver={SQL Server};server=svr;database=db;uid=usr;pwd=pwd')
  sqlTables(myconn)
}

SaveToSQL <- function(df, tablename="", svr, db,usr,pwd) {
                      require(RODBC)
                      # connect to SQL server
                      ch <- odbcDriverConnect('driver={SQL Server};server=svr;database=db;trusted_connection=true')

                      # list tables available in database
                      sqlTable.List<- sqlTables(ch, schema = "dbo")

                      # get info on table structure
                      tmp <- sqlColumns(ch, tablename)
                      varT <- as.character(tmp$TYPE_NAME)
                      df.cols <- colnames(df)
                      sql.cols <- as.character(tmp$COLUMN_NAME) 
                      idx <- match(sql.cols,df.cols)
                      idx <- idx[!is.na(idx)]
                      sql.cols <- sql.cols[idx]
                      varT <- varT[idx]
                      names(varT) <- sql.cols
                     
                      sqlSave(ch, df, tablename = tablename,append = TRUE, rownames = FALSE, colnames = FALSE,
                              varTypes=varT, verbose = TRUE, test = FALSE, nastring = NULL,  fast = TRUE)
                     close(ch)
}