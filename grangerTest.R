# China GDP and consumption
# note : there is a package of lmtest for granger test
GDP <- structure(list(gdp = c(3645.20 , 4062.60 , 4545.60 , 4889.50 , 5330.50 , 5985.60 , 7243.80 , 9040.70 , 
                              10274.40 , 12050.60 , 15036.80 , 17000.90 ,  18718.30 , 21826.20 , 26937.30 , 35260.00 , 48108.50 , 59810.50 , 
                              70142.50, 78060.80 , 83024.30 , 88479.20 ,  98000.50 , 108068.20, 119095.70)
                      , con = c(1759.1, 2014, 2336.9, 2627.5, 2867.1, 3220.9, 3689.5, 4627.4, 5293.5, 6047.6, 7532.1,  8778, 9435, 10544.5, 12312.2, 15696.2, 21446.1, 28072.9, 33660.3, 
                                36626.3, 38821.8, 41914.9, 46987.8, 50708.8, 55076.4)), class = "data.frame", row.names = c(NA, -25L))

# GDP <- ts(GDP,frequency = 1,start=c(1978))

grangertest <- function(y,x,p = 2,q = 2,alpha = 0.05,ylabel ='y', xlabel='x') {
  # x, y must be ordered by increasing, say from 2015 to 2020
  # p the lag periods of y
  # q the lag periods of x
  
  if(p != q) stop("q != q is not supported at this moment")
  
  n <- length(y)
  res <- list()
  listname <- c()
  
  # cal y lag
  
  y0 <- y[-(1:p)]
  res <- c(res,list(y0))
  listname <- c(listname,'y0')
  
  for (i in 1:p) {
    hp <- ifelse(p == i,0, 1:(p-i))  # heading period
    tp <- (n - i + 1):n # tailing period

    tmp <- y[-c(hp, tp)]
    vname <- paste('y_',i,sep='')
    assign(vname,tmp)
    res <- c(res,list(get(vname)))
    listname <- c(listname,vname)
  }
  
  # cal x lag
  
  x0 <- x[-(1:q)]
  res <- c(res,list(x0))
  listname <- c(listname,'x0')
  
  for (i in 1:q) {
    hp <- ifelse(q == i,0, 1:(q-i))  # heading period
    tp <- (n - i + 1):n # tailing period

    
    tmp <- x[-c(hp, tp)]
    vname <- paste('x_',i,sep='')
    assign(vname,tmp)
    res <- c(res,list(get(vname)))
    listname <- c(listname,vname)
  }
  
  names(res) <- listname
  # test if x cause y
  # only support p,q = 2
  
  fit.y.u <-  lm(y0 ~ y_1 + y_2 + x_1 + x_2) # unrestrict model
  fit.y.r <-  lm(y0 ~ y_1 + y_2) # restrict model
  
  rss.u <- sum(fit.y.u$residuals ^ 2)
  rss.r <- sum(fit.y.r$residuals ^ 2)
  
  ##  Construct F test, ~F(q, n-p-q-1)
  n <- length(y0)
  
  ftest.y <- ((rss.r - rss.u) / q) / (rss.u / (n-p-q-1))
  p.value.y <- pf(ftest.y,q,n-p-q-1,lower.tail = FALSE)         # text book value 0.220978
  
  if( p.value.y > alpha) {
    res <- c(res
             , list(firsttest = sprintf('p value %.5f > %.5f, we can NOT reject H0: x (%s) is not the granger cause of the changes of y (%s)'
             ,p.value.y, alpha, xlabel, ylabel)))
  } else {
    res <- c(res
             , list(firsttest = sprintf('p value %.5f < %.5f, we REJECT H0: x (%s) is not the granger cause of the changes of y (%s)'
             ,p.value.y, alpha, xlabel, ylabel)))
  }
  ### conclusion for 1st test, p value > 5% ,we can NOT reject H0: consumption is not the granger cause of gdp
  
  # test if y cause x
  fit.x.u <-  lm(x0 ~ x_1 + x_2 + y_1 + y_2) # unrestrict model
  fit.x.r <-  lm(x0 ~ x_1 + x_2) # restrict model
  
  rss.u <- sum(fit.x.u$residuals ^ 2)
  rss.r <- sum(fit.x.r$residuals ^ 2)
  
  ##  Construct F test, ~F(q, n-p-q-1)
  n <- length(x0)

  
  ftest.x <- ((rss.r - rss.u) / q) / (rss.u / (n-p-q-1))
  p.value.x <- pf(ftest.x,q,n-p-q-1,lower.tail = FALSE)              # text book value 0.000271636
  
  if( p.value.x > alpha) {
    res <- c(res
             , list(secondtest = sprintf('p value %.5f > %.5f, we can NOT reject H0: y (%s) is not the granger cause of the changes of x (%s)'
             ,p.value.x, alpha, ylabel, xlabel)))
  } else {
    res <- c(res
             , list(secondtest = sprintf('p value %.5f < %.5f, we REJECT H0: y (%s) is not the granger cause of the changes of x (%s) '
             ,p.value.x, alpha, ylabel, xlabel)))
  }
  
  ### conclusion for 2nd test: p.value < 5%, we reject H0: GDP is not the granger cause of consumpiton
  
  #### final conclusion: GDP is the granger cause of consumption
  
  return(res)
}

grangertest(y=GDP$gdp,x=GDP$con,ylabel="GDP",xlabel='Consumption')





