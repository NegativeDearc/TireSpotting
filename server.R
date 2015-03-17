library(shiny)
library(rmarkdown)
library(ggplot2)


shinyServer(
  function(input,output){    
### 把链式表达式组合成数据
dataset <- reactive({ 
  data.frame(Name = c("TREAD \t 胎面","SNOW \t 冠带层","IL/SW \t 预复合","PLY 1 \t 帘布1","PLY 2 \t 帘布2"),
                              direction = c(input$TREAD,
                                            input$SNOW,
                                            input$PA,
                                            input$PLY1,
                                            input$PLY2),
                                            count = c(50,50,50,50,50))
  
})
### 链式ggplot
plotInput <- reactive({
      df <- dataset()
      p <- ggplot(df,aes(x = direction,y = count))+coord_polar()
      p <- p+geom_segment(data = df,aes(y = 0, xend=direction, yend=count,colour = Name))+
        scale_x_continuous(limits=c(0,360),breaks=df$direction)+
        geom_text(label=df$Name,size=4)+
        ggtitle(input$type)+
        theme_bw()+
        theme(legend.position = "none",
              axis.title = element_blank(),
              axis.text.y= element_blank(),
              axis.ticks=element_blank(),
              panel.grid.major = element_line(color = "grey"),
              panel.border = element_blank())
})
### 最后渲染
output$pic <- renderPlot({
  print(plotInput())
}) 
### 数据集
output$summary <- renderTable({
  as.data.frame(dataset())
})
### 下载模块
output$download <- downloadHandler(filename = function() { paste(input$type, '.png', sep='') },
                                   content = function(file) {
                                     device <- function(..., width, height) grDevices::png(..., width = width, height = height, res = 300, units = "in")
                                     ggsave(file,plotInput(),dpi = 600,device = device)})
})