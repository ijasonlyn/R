plotEllipse <- function(xrange, yrange,filled=TRUE,a=5,b=4,centre=c(0,0),phi=0*pi, new = TRUE) {
  
  # xrange := c(left, right)   
  # yrange := c(bottom, top)
  # centre := c(x,y)
  
  if (!(missing(xrange) & missing(yrange))) {
    centre <- c(sum(xrange)/2, sum(yrange)/2)
    a <- (xrange[2] - xrange[1]) / 2
    b <- (yrange[2] - xrange[1]) / 2
    #phi <- atan((b/a))
  } 
  
  xc <- centre[1] 
  yc <- centre[2] 
  
  t <- seq(0, 2*pi, 0.1) 
  x <- xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi)
  y <- yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi)
  
  if (new) {              # if not call inside plot of other's
    # par(pty="s")    # set to square plot
    plot(x,y, type='l', col="purple")        # else ellipse circle
  }

  
  if(filled) {
    polygon(x,y,col="lightblue")   # if filled, polygon
    }
  } 

#plotEllipse()
plotEllipse(c(1,3),c(2,9))