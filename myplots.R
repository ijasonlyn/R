waterfall <- function(df,text.size = 3, title = "Sales bridge \n for the period of Q4") {
  # output:   a water fall plot
  # Input:    data frame with two variable
  #             decr: the description of actions that make a change
  #             change of amount: The amount that changed according to the actions
  
  require(ggplot2)
  require(scales)   # for comma function
  
  colnames(df) <- c("desc", "amount")
  balance <- df
  
  # factor desc, add id and type
  balance$desc <- factor(balance$desc, levels = balance$desc)
  balance$id <- seq_along(balance$amount)
  balance$type <- ifelse(balance$amount > 0, "in", "out")
  balance[c(1,nrow(balance)), "type"] <- "net"
  
  # to specify the coordinates for drawing the waterfall bars
  balance$end <- cumsum(balance$amount)
  balance$end <- c(head(balance$end, -1), 0)   # replace last number with 0
  balance$start <- c(0, head(balance$end, -1))
  balance <- balance[, c(3, 1, 4, 6, 5, 2)]  # re-arrage columns
  
  # color RGB, out = red, in = green, net = blue
  balance$type <- factor(balance$type, levels = c("out","in", "net")) 
  
  # replace white space with new line for better x-axis label
  strwr <- function(str) gsub(" ", "\n", str) 
  
  p <- ggplot(balance, aes(x = desc, fill = type)) 
  p <- p + geom_rect(aes(xmin = id - 0.45, xmax = id + 0.45, ymin = end, ymax = start))  
  p <- p + scale_y_continuous("", labels = comma )     # comma is a format function from scale package
  p <- p + scale_x_discrete("",breaks = levels(balance$desc),labels = strwr(levels(balance$desc))) 
  p <- p + theme(legend.position = "none")
  
  # Reduce line spacing and use bold text
  # hjust = 0.5 to allow title to appear in the middle, instead of left-aligned
  p <- p + ggtitle(title) + theme(plot.title = element_text(lineheight=.8, face="bold", hjust = 0.5))
  
  # add number to bar
  p <- p + geom_text(data = subset(balance, type == "in") 
                     , aes(id, end, label = comma(amount)), vjust = 1, size = text.size)
  p <- p + geom_text(data = subset(balance, type == "out")
                     , aes(id, end, label = comma(amount)), vjust = -0.3,size = text.size) 
  
  p <- p + geom_text(data = subset(balance, type == "net" & id == min(id))
                     , aes(id, end,colour = type, label = comma(end)
                           , vjust = ifelse(end < start, 1, -0.3)), size = text.size + .5)
  p <- p + geom_text(data = subset(balance, type == "net" & id == max(id))
                     , aes(id, start, colour = type, label = comma(start)
                           , vjust = ifelse(end < start, -0.3, 1)), size = text.size + .5)
  p
}

# testing data
test_data_for_waterfall <- data.frame(description = c("Starting Cash","Sales", "Refunds", "Payouts", "Court Losses", "Court Wins", "Contracts", "End Cash")
                      , amount = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800))

# ^^^^^^           end of function of Water Fall             ^^^^^^^


# vvvvvv           function of funnel                       VVVVVVVV

funnel <- function(df, title = "Sales funnel") {
  
  # Output    :  Funnel plot
  # Input:    :  df data frame containing (must in same sequence)
  #              steps: describing the converstion steps, must be factorred
  #              numbers: the numbers of counts
  #              rate: the conversion rate
  # * important: step must be factored *
  
  colnames(df) <- c("steps","numbers","rate")
  if( !is.factor( df$steps )) stop("steps must be factorred")
  dat <- df
  
  require(ggplot2)
  require(reshape2)
  
  # add spacing, melt, sort
  total <- subset(dat, rate==100)$numbers
  dat$padding <- (total - dat$numbers) / 2
  
  molten <- melt(dat[, -3], id.var='steps')
  molten <- molten[order(molten$variable, decreasing = T), ]
  molten$steps <- factor(molten$steps, levels = rev(levels(dat$steps)))
  
  p <- ggplot(molten, aes(x=steps))
  p <- p + geom_bar(aes(y = value, fill = variable)
                    ,stat='identity', position='stack') 
  p <- p + geom_text(data=dat, aes(y=total/2, label= paste(round(rate), '%')),
                     color='white') 
  p <- p + scale_fill_manual(values = c('skyblue1', NA))
  p <- p + coord_flip() + theme(legend.position = 'none') + labs(x='stage', y='volume')
  # title
  p <- p + ggtitle(title) + theme(plot.title = element_text(lineheight=.8, face="bold", hjust = 0.5))
  p
}

# get data
test_data_for_funnel <- read.table(text=
                                     "steps  numbers     rate
                                   clicks 332835  100.000000
                                   signup  157697  47.379933
                                   cart   29866   8.973215
                                   buys   17012   5.111241"
                                   , header = T)
test_data_for_funnel$steps <- factor(test_data_for_funnel$steps,levels= c("clicks","signup","cart","buys"))

# ^^^^^^          End of function of funnel    ^^^^^^^^^^^^^^


# VVVVVV          Three cycles drawing        VVVVVVVVVVVVVV

threeCircle <- function(char=NA) {
  
  ## To draw 3 cycles R = right, L=left, D=down
  ## R & L are in same level
  ## RL = intersect point of R & L, two points up and down
  ## r = radium
  ## Rc = Cycle R's center, same applied to Lc, Dc
  ## dist = distance between two point
  ## x.margin = away from left 
  ## y.margin = away from top
  ## ic = intercept of two circle
  
  require(grid)
  
  ## assign radium, intercept, left margin, top margin
  r <- 0.25
  ic <- .2
  leftm <- .02
  topm <- .02
  
  L.x <- r + leftm
  R.x <- L.x + 2*r - ic
  L.y <- R.y <- 1- r- topm
  LR.dist <- R.x - L.x
  LD.dist <- RD.dist <- LR.dist
  D.x <- L.x + LR.dist/2
  D.y <- L.y - sqrt(LR.dist^2-(LR.dist/2)^2 )
  
  LR.x <- D.x
  LR.y.lo <- L.y - sqrt(r^2 -(LR.dist/2)^2 )
  LR.y.hi <- L.y + sqrt(r^2 -(LR.dist/2)^2 )
  
  
  Lc <- c(L.x, L.y)
  Rc <- c(R.x, R.y)
  Dc <- c(D.x, D.y)
  
  grid.newpage()
  viewport(x=.5,y=.5,width=1, height=1, just=c("left","top"))
  
  center <- c("Dc","Lc","Rc")
  cols <- c("lightgreen","rosybrown","lightblue")
  txt <- c("Competitors' VP","Our VP", "Customer needs")
  txt.x <- c(D.x, L.x-r*sin(pi/6)-.01, R.x + r*sin(pi/6)+.015)
  txt.y <- c(D.y-r-0.01, L.y+r*cos(pi/6)+.01, R.y+r*cos(pi/6)+.01)
  for (i in 1:3) {
    
    x <- get(center[i])[1]
    y <- get(center[i])[2]
    col <- cols[i]
    
    gr.cir <- circleGrob(x=x,y=y,r=r,gp=gpar(col=col, fill=NA,lwd=3))
    grid.draw(gr.cir)
    grid.text(txt[i], x=txt.x[i], y=txt.y[i], gp=gpar(col=cols[i], fontsize=17))
    
  }
  
  Letter <- LETTERS[1:7] %in% char
  txt.cols <- ifelse(Letter,"red","lightgray")
  fontsize <- ifelse(Letter,17,13)
  
  char.x <- c(LR.x, LR.x, R.x, L.x, L.x, LR.x, R.x)
  char.y <- c(LR.y.hi-.03, LR.y.lo + .03, LR.y.lo+.03, LR.y.lo+.03, L.y+r-.03, D.y-r+.03,R.y+r-.03)
  
  for (i in 1:7) {
    grid.text(LETTERS[i], x= char.x[i], y=char.y[i], gp=gpar(col=txt.cols[i], fontsize=fontsize[i]))
  }
  
  grid.text("Homo Light dist.\n24 hours a day \nLess heat", 
            x= LR.x, y= LR.y.lo + (LR.y.hi-LR.y.lo)/2 -.07, gp=gpar(fontsize=8))
  
}

# ^^^^^^^^              End of three cycles plot          ^^^^^^^^^^^^^^^^^


