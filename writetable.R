table.html <- function(df) {
  # Creae HTML table from a data frame
  # the format must be in last column
  # for simplify coding, a format column is required, even whole column in white space
  
  nr <- nrow(df)
  nc <- ncol(df) - 1
  
  out <- paste("<table border=1> \n", sep=" ")
  # header row
  out <- paste(out, "<tr>", sep=" ")
  for (i in 1: nc) {
    out <- paste(out,"<th>",colnames(df)[i],"</th>", sep=" ")
  }
  out <- paste(out,"</tr>","\n", sep=" ")
  
  # data row
  for (i in 1:nr) {
    out <- paste(out, "<tr style='", df[i,nc+1], "'>",sep=" ")
    for (j in 1: nc) {
      out <- if (j==1) paste(out, "<td align='left'>",df[i,j],"</td> \n" ) else
        paste(out, "<td align='right'>",df[i,j],"</td> \n" )
    }
    out <- paste(out, "</tr>","\n", sep=" ")
  }
  
  out <- paste(out,"</table>", sep=" ")
  
  return(out)
}

# Create Markdown table from data frame, to be used for either Word or HTML
table.md <- function(df) {
  
  nr <- nrow(df)
  nc <- ncol(df)
  
  # header
  out <- "\n"   # new line is needed to enable table
  out <- paste(colnames(df), collapse="|")
  out <- paste("|",out,"|", "\n", sep="")
  
  # horizon line, align right then all left
  hline <- "|:------"
  hline <- c(hline, rep("------:", nc-1))
  hline <- paste(hline, collapse = "|")
  
  out <-paste(out, hline,"|", "\n", sep="")
  
  for (i in 1: nr) {
    dr <- paste(df[i,], collapse = "|")
    out <- paste(out,"|", dr,"|", "\n", sep= "")
  }
  cat(out)
}