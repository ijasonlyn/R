cal <- function(month, year) {
  
  if(!require(chron)) stop('Unable to load chron package')
  
  if(missing(year) && missing(month)) {
    tmp <- month.day.year(Sys.Date())
    year <- tmp$year
    month <- tmp$month
  }
  if(missing(year) || missing(month)){  # year calendar
    if(missing(year)) year <- month
    par(mfrow=c(4,3))
    tmp <- seq.dates( from=julian(1,1,year), to=julian(12,31,year) )
    tmp2 <- month.day.year(tmp)
    wd <- do.call(day.of.week, tmp2)
    par(mar=c(1.5,1.5,2.5,1.5))
    for(i in 1:12){
      w <- tmp2$month == i
      cs <- cumsum(wd[w]==0)
      if(cs[1] > 0) cs <- cs - 1
      nr <- max( cs ) + 1
      plot.new()
      plot.window( xlim=c(0,6), ylim=c(0,nr+1) )
      text( wd[w], nr - cs -0.5 , tmp2$day[w] )
      title( main=month.name[i] )
      text( 0:6, nr+0.5, c('S','M','T','W','T','F','S') )
    }
    
  } else {  # month calendar
    
    ld <- seq.dates( from=julian(month,1,year), length=2, by='months')[2]-1
    days <- seq.dates( from=julian(month,1,year), to=ld)
    tmp <- month.day.year(days)
    wd <- do.call(day.of.week, tmp)
    cs <- cumsum(wd == 0)
    if(cs[1] > 0) cs <- cs - 1
    nr <- max(cs) + 1
    par(oma=c(0.1,0.1,4.6,0.1))
    par(mfrow=c(nr,7))
    par(mar=c(0,0,0,0))
    for(i in seq_len(wd[1])){ 
      plot.new()
      #box()
    }
    day.name <- c('Sun','Mon','Tues','Wed','Thur','Fri','Sat')
    for(i in tmp$day){
      plot.new()
      box()
      text(0,1, i, adj=c(0,1))
      if(i < 8) mtext( day.name[wd[i]+1], line=0.5,
                       at=grconvertX(0.5,to='ndc'), outer=TRUE ) 
    }
    mtext(paste(month.name[month],tmp$year[1], sep="-"), line=2.5, at=0.5, cex=1.75, outer=TRUE)
    #box('inner') #optional 
  }
}

# get the row and col for a date
addr <- function(date) {
  # input:    a Date
  # Output:   an address in terms of row and column
  
  y <- as.integer(format(date,"%Y"))
  m <- as.integer(format(date,"%m"))
  w <- as.integer(format(date,"%w"))
  
  from <- paste(y,m,"01", sep="-")
  from <- as.Date(from)
  to <- paste(y,m+1,"01", sep="-")
  to <- as.Date(to) -1
  
  ds <- seq.Date(from, to, by="day")
  ws <- as.integer(format(ds,"%w"))
  ws <- cumsum(ws==0)
  if(ws[1] > 0) ws <- ws - 1
  
  row <- ws[match(date,ds)]+1
  col <- w + 1
  
  return(c(row=row,col=col))
}

calprint <- function(month,year,df) {
  
  # input:    df, a two column dataframe, 1st for action items, 2nd for date
  
  m <- month
  y <- year
  cal(m, y)
  
  from <- paste(y,m,"01", sep="-")
  from <- as.Date(from)
  to <- paste(y,m+1,"01", sep="-")
  to <- as.Date(to) -1  
  sel <- df[,1] >= from & df[,1] <= to
  df <- df[sel,]
  
  n <- nrow(df)
  
  for (i in 1:n) {
    ad <- addr(df[i,1])
    par(mfg = ad)
    text(0.1,0.9, paste(df[i,2],"\n", sep=""),adj=c(0,1),cex=.9)
  }
  
}
