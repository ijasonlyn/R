
# http://www.cs.cornell.edu/cv/OtherPdf/Ellipse.pdf




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
