
funnelplot <- function(lvl = 4, labs, conversionrate) {

  if(missing(labs)) labs <- paste("level ", 1:lvl, sep='')
  if(missing(conversionrate)) conversionrate <- paste(seq(labs),'%',sep='')

  mx <- .6 # mid point of x
  lf <- c(x = 0.2, y = 1)
  rt <- c(x = 1, y = 1)
  bm <- c(x = mx,y = 0)


  lvl <- 4
  cols <- heat.colors(lvl)


  prop <- seq(0,1,length = lvl + 1)

  lx <- lf[1] * prop + bm[1] * ( 1 - prop ) # from midpoint to leftmost
  ly <- lf[2] * prop + bm[2] * ( 1 - prop ) # from 0 to 1
  rx <- rt[1] * prop + bm[1] * ( 1 - prop ) # from midpoint to rightmost
  ry <- rt[2] * prop + bm[2] * ( 1 - prop ) # from 0 to 1
  lab.y <- (tail(ly,-1) + head(ly,-1)) / 2 # label on the left


  plot(c(0,1),c(0,1),type='n'
    ,main='Funnel plot'
    ,xlab = ''
    , ylab=''
    , frame.plot = FALSE
    , axes = FALSE)

  for (i in 1:lvl) {
    if (i == 1) {

      polygon(x = c(lx[1:2], bm[1])
        ,y = c(ly[1:2], bm[1])
        ,col = cols[i])
        text(x = 0.01, y = lab.y[1]
        ,labels = labs[1]
        ,adj = c(0,1)
      )
      text(x = mx, y = lab.y[1],conversionrate[1]) # convertion rate
    }
    polygon(x = c(lx[c(i,i+1)], rev(rx[c(i,i+1)]))
      ,y = c(ly[c(i,i+1)],rev(ry[c(i,i+1)]))
      ,col = cols[i]
      )
    text(x = 0.01, y = lab.y[i]
      ,labels = labs[i]
      ,adj = c(0,1)
      )
    text(x = mx, y = lab.y[i],conversionrate[i])
  }
}

funnelplot()
