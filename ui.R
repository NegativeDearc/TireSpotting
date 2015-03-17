library(shiny)
library(rmarkdown)
library(ggplot2)


shinyUI(pageWithSidebar(
  
  headerPanel("Tire Spotting"),
  sidebarPanel(width = 3,
    h3("Help text"),
    helpText("Note: Drag the sliderbar to the right positon",br(),
             "拖动进度条选择正确的角度",br(),"then select the type of spotting",
             br(),"再选择正确的文本标题",br(),"Save the PNG file to your local disk.",
             br(),"点击下载按钮保存到你的本地磁盘"),
  
    selectInput(inputId = "type",label = h5("Choose the Spotting Type Below",
                                            br(),h5("选择类型")),
                choices =c("S1","S2","S3","S4","S6","S7","S8","S9"),
                selected = "S9"),
    
    sliderInput("TREAD",label = "TREAD:",min = 0,max = 360,value = 0,step = 5),
    sliderInput("SNOW",label = "SNOW:",min = 0,max = 360,value = 125,step = 5),   
    sliderInput("PA",label = "IL/SW:",min = 0,max = 360,value = 45,step = 5),
    sliderInput("PLY1",label = "PLY1:",min = 0,max = 360,value = 295,step = 5),
    sliderInput("PLY2",label = "PLY2:",min = 0,max = 360,value = 165,step = 5)
  
),
  mainPanel(
    tabsetPanel(
      tabPanel("Plot图形", plotOutput(outputId = "pic",width = 560,height =560 ),
               downloadButton(outputId = "download",label = "Download下载")),
      tabPanel("Dataset数据", tableOutput(outputId = "summary")),
      tabPanel("Logs更新记录", includeMarkdown('logs.md')),
      tabPanel("Author作者",helpText(img(src="logo.jpg",height=250,width=250),
                                    h5("Author: Sheldon Chen",br(),
                                       "Current Time:",as.POSIXct(Sys.time()),tz = "GMT",br(),
                                       "If you found any bug or good suggests",
                                       a(href="mailto:sxchen@coopertire.com&Subject=feedback","Click Here!"))))
    )
  )
))
    
         
