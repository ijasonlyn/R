
# http://www.cs.cornell.edu/cv/OtherPdf/Ellipse.pdf
# with center(h,k) and semiaxes a and b, the ellipse formula is
# (x -h)^2 / a ^2 + (y - k)^2 / b^2 = 1
# i.e. 
#       x(t) = h + acos(t)
#       y(t) = k + bsin(t)
#       t in (0, 2*pi)
# with rotate phi, in matrix form is 
# [ x(t) \n y(t) ] = [ h \n k ] + [cos(phi)  -sin(phi)  \n sin(phi)  cos(phi) ] %*% [acos(t)  \n bsin(t) ]


plotEllipse <- function(a=0,b=0,center=c(0,0),phi=0*pi,fill=TRUE) {
  xc <- center[1]
  yc <- center[2]
  
}


xc <- 1 # center x_c or h
yc <- 2 # y_c or k
a <- 5 # major axis length
b <- 2 # minor axis length
phi <- pi/3 # angle of major axis with x axis phi or tau

t <- seq(0, 2*pi, 0.01) 
x <- xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi)
y <- yc + a*cos(t)*cos(phi) + b*sin(t)*cos(phi)
plot(x,y,pch=19, col='blue')
polygon(x,y,col="red")
