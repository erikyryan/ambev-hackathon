if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)

options(shiny.maxRequestSize = 50*1024^2)

source("../src/HWdata.r")
source("../src/PRdata.r")

principal <- htmlTemplate(filename = "../app/www/index.html", document_ = "auto", 
                          inputButton = fileInput("inputButton",label = "Coloque o arquivo aqui"
                                                  , multiple = FALSE, accept = ".csv"),
                          HWplot =  htmlOutput("HWplot",inline = FALSE),
                          inputTime = numericInput("TimeHW", label = "Quantidade de Meses a serem previstos",
                                                   value = 0,width = validateCssUnit("25%"))
                          
)

SobreNos <- htmlTemplate(filename = "../app/www/sobre.html", document_ = "auto"

)

recomendacao <- htmlTemplate(filename = "../app/www/recomendacao.html", document_ = "auto",
                                   inputFileCP = fileInput("dtInputCP", label = "Coloque o arquivo aqui", 
                                                           multiple = FALSE,accept = ".csv"),
                                   inputClientCP = numericInput("idInputCP",label = "Digite o Id:",
                                                                value=0,width = validateCssUnit("25%")),
                                   inputMaxCP = numericInput("MaxCP",label = "Máximo de ocorrências:",
                                                             value=0,width = validateCssUnit("25%")),
                                   inputMinCP = numericInput("MinCP",label = "Minimo de ocorrências:",
                                                             value=0,width = validateCssUnit("25%")),
                                   PRplot = htmlOutput("PRplot",inline = FALSE),
)

router <- make_router(
  route("/", principal),
  route("recomendacao", recomendacao),
  route("Sobre-nos", SobreNos)
)


ui <- fluidPage(
  tags$div(class="navbar navbar-expand-md",
           tags$div(class="container",
                    tags$div(class="collapse navbar-collapse",id="navbarNav",
                             tags$ul( class ="navbar-nav ml-auto",
                                      tags$li( class="nav-item active",
                                               tags$a(class="nav-link", href= route_link("/"),
                                                      "Página Inicial")
                                      ),
                                      tags$li(class="nav-item",
                                              tags$a(class="nav-link",href= route_link("recomendacao"),
                                                     "Recomendação")
                                      ),
                                      tags$li(class="nav-item",
                                              tags$a(class="nav-link",href= route_link("Sobre-nos"),
                                                     "Sobre nós")
                                      )
                            )
                    )
              )
      ),
    router$ui
)


server <- function(input, output,session) {
  router$server(input, output,session)
  
  df <- reactive({
    req(input$inputButton, file.exists(input$inputButton$datapath))
    read.csv(input$inputButton$datapath)      
  })
  
  MesesTime <-reactiveValues()
  
  observeEvent(eventExpr = input$TimeHW,#IDcode
               handlerExpr = {
                 MesesTime$meses <- input$TimeHW
               })
  
  output$HWplot <- renderUI({
    req(df())
    req(MesesTime$meses)
    HWdata(df(),MesesTime$meses)
  })
  
  #########################
  
  dfPR <- reactive({
    req(input$dtInputCP, file.exists(input$dtInputCP$datapath))
    read.csv(input$dtInputCP$datapath)      
  })
  
  values <-reactiveValues()
  
  observeEvent(eventExpr = input$idInputCP,#IDcode
               handlerExpr = {
                 values$number <- input$idInputCP
  })
  
  observeEvent(eventExpr = input$MinCP,#MinValue
               handlerExpr = {values$number1 <- input$MinCP}
               )
  
  observeEvent(eventExpr = input$MaxCP,#MaxValue
               handlerExpr = {values$number2 <- input$MaxCP}
  )
  
  output$PRplot <- renderUI({
    req(dfPR())
    req(values$number)
    req(values$number1)
    req(values$number2)
    PRdata(dfPR(),values$number,values$number1,values$number2)
  })
}

shinyApp(ui = ui, server = server)