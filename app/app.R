if(!require(shiny)) install.packages("shiny");require(shiny)

ui <-  shinyUi(fluidPage(

    )
)

server <- function(input, output) {

    # df -> input$dtInput 
}

shinyApp(ui = ui, server = server)
