library(RColorBrewer)
CustomTable <- function(x, 
                        year, 
                        as.percent = TRUE, 
                        hide.values = FALSE, 
                        values.width = 90,
                        scale.min = NULL, 
                        scale.max = NULL, 
                        heatmap = FALSE, 
                        cell.colors = colorRampPalette(brewer.pal(9,"Blues"))(101), #RColorBrewer::brewer.pal(9, "Blues"),
                        font.colors = c(rep("blue", 76), rep("white", 25)))
  
{
  categories <- rownames(x)
  values = unname(x)
  # Scaling the input values to be in [1, 2, 3, ..., n.color]
  n.colors = length(cell.colors)
  if (is.null(scale.min))
    scale.min = min(values)
  if (is.null(scale.max))
    scale.max = max(values)
  scaled.values = round((values - scale.min) / (scale.max - scale.min) * (n.colors - 1), 0) + 1
  if (as.percent)
    values <- flipFormat::FormatAsPercent(values / 100, decimals = 0)
  if (hide.values)
    values <- rep("", length(values))
  
  # Heatmap formatting of cells
  n = length(values)
  # Creating the CSS
  cell.shading = paste0('td.cell', 1:n, ' {}')
  print(scaled.values)
  print(cell.colors[scaled.values])    
  
  if (heatmap)
    cell.shading = paste0('td.cell', 1:n, ' {background-color: ', cell.colors[scaled.values], '; color: ', font.colors[scaled.values], ';}')
  cell.shading  = paste0(cell.shading, collapse = '')
  print(cell.shading)
  
  
  .cell <- function(category, year, value, i)
  {
    paste0('<tr>
           <td>', category, '</td>
           <td class = "center">', year, '</td>
           <td class = "right cell', i, '";>', value, '</td>
           </tr>')
  }
  
  cells = paste0(.cell(categories, year, values, 1:n), collapse = "")
  
  html = paste0('<!DOCTYPE html>
                <html>
                <head>
                <style>
                h1 {
                font-size: 20;
                font-family: verdana; 
                font-weight: 100;    
                line-height: 70%;
                color: #444444;
                margin-top: 20px;
                text-indent: 5px; 
                align: left;
                }
                
                h2 {
                font-size: 14px;
                font-family: verdana;
                font-weight: 200;    
                line-height: 60%;
                color: #444444;
                margin-top: 10px;
                text-indent: 5px
                }}
                
                p {}
                
                .table-caption-div {
                display: inline-block;
                
                }
                table {
                border-color: #3E7DCC;
                border-style: solid;
                background-color: #efefef;
                margin-left: 0px; 
                width: auto;
                padding: 6px;
                display: inline-block;
                border-collapse: collapse;
                table-layout: fixed
                }
                
                caption { display: inline-block;
                text-align:left}
                td {
                width: 80px; 
                height: 45px; 
                font-family: verdana; 
                color: grey; 
                font-size: 12px;
                font-weight: 100;    
                border-top: 2px solid #dddddd;
                border-bottom: 2px solid #dddddd;
                text-indent: 5px; 
                }
                td.center {
                width: 90px; 
                text-align: center;
                }
                td.right {
                width: ', values.width, 'px; 
                border-left: 1px solid #dddddd;
                border-right: 1px solid #dddddd;
                text-align: right;
                padding-right: 50px;
                }
                ', cell.shading, '
                
                td.no-left {
                border-top: none
                
                }
                
                
                </style>
                </head>
                <body>
                
                <table >
                <caption class="table-caption-div">
                <h1>Age</h1>
                <h2>How old are you?</h2>
                </caption>',
                cells,
                '</table>
                </body>
                </html>')
  rhtmlMetro::Box(text = html, text.as.html = TRUE)
  }

MyHeatmap <- function(x)
{ 
  # Lookups for coloring cells and fonts
  require(RColorBrewer)
  cell.colors = colorRampPalette(brewer.pal(9,"Blues"))(101)
  font.colors = c(rep("blue", 60), rep("white", 41))
  
  # Scaling the data to be on [1, 2, ..., 101], for the lookups
  min.x <- min(x)
  max.x <- max(x)
  scaled.x = round((x - min(x)) / (max(x) - min(x)) * 100, 0) + 1
  
  # Writing the cells styles
  n.rows = nrow(x)
  n.columns = ncol(x)
  rows = rep(1:n.rows, rep(n.columns, n.rows))
  columns = rep(1:n.columns, n.rows)
  x.lookups = as.numeric(t(scaled.x))
  cells.styles = paste0('td.cell', rows, columns, ' {background-color: ', cell.colors[x.lookups], '; color: ', font.colors[x.lookups] ,';}')
  cell.styles = paste0(cells.styles, collapse = "\n")
  
  # Creating the table
  columns.headers = paste0('<th>', c("", dimnames(x)[[2]]) ,'</th>')
  tble = paste0(columns.headers, collapse = "\n")
  row.headers = paste0('<th>', c(dimnames(x)[[1]]) ,'</th>')
  print('row.headers')
  print(row.headers)
  for (row in 1:n.rows)
  {
    row.cells = paste0('<td class = "border cell', row, 1:n.columns, '">', x[row,],'</td>')
    print('row.cells')
    print(row.cells)
    tble = paste0(tble, '<tr>', row.headers[row], paste(row.cells, collapse = '\n'), '</tr>')
  }
  # Assembling the HTML
  html = paste0('<!DOCTYPE html>
    <html>
    <head>
    <style>
      table, th, td {border-collapse: collapse; }
      th, td {padding: 5px; text-align: center; font-family: arial; font-size: 8pt}
      td.border {border: 1px solid grey; }',' td.cell11 {background-color: #F7FBFF; color: blue;}',
                cell.styles, '
    </style>
    </head>
    <body>
    <table style="width:100%">', tble, '
    </table>
    </body>
    </html>')
  rhtmlMetro::Box(text = html, text.as.html = TRUE)
}

my.data = matrix(1:9, nrow = 3, dimnames = list(c("This is a long column heading; too long to show neatly in any of of the visualization packages that I know and love", "This is a second column heading; too long to show neatly in any of of the visualization packages that I know and love.", "This is a third  column heading; too long to show neatly in any of of the visualization packages that I know and love."),
                                                c("This was a long row heading; too long to show neatly in any of of the visualization packages that I know and love", "This is another long column heading, which is too long to show neatly in any of of the visualization packages that I know and love", "This is a third long column heading, which is too long to show neatly in any of of the visualization packages that I know and love")))

MyHeatmap(my.data)
MyHeatmap(matrix(1:200, 
                 nrow = 20, 
                 dimname = list(LETTERS[1:20], 
                                letters[1:10])))

CustomTable(table.Q3.Age, year = 2016, as.percent = TRUE, heatmap = TRUE)    