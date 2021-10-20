library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

        mainPanel(
                fileInput("dtInput",
                          label = 'Coloque o dataframe',
                          accept = ".csv")
                    
        )
    )
)
