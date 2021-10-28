if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)

options(shiny.maxRequestSize = 50*1024^2)
source("../src/HWdata.r")

principal <- htmlTemplate(filename = "../app/www/index.html", document_ = "auto", 
                          inputButton = fileInput("inputButton",label = "Coloque o arquivo aqui", multiple = FALSE, accept = ".csv"),
                          HWplot =  htmlOutput("HWplot",inline = FALSE),
                          
)

SobreNos <- htmlTemplate(filename = "../app/www/aboutUs.html", document_ = "auto"

)

cestaPersonalizada <- htmlTemplate(filename = "../app/www/cestaPersonalizada.html", document_ = "auto",
                                   inputFileCP = fileInput("dtInputCP", label = "Coloque o arquivo aqui", multiple = FALSE,
                                                           accept = ".csv"),
                                   inputClientCP = textInput("idInputCP",label = "Digite o Id:",width = validateCssUnit("25%")),
                                   PRplot = htmlOutput("PRplot",inline = FALSE),
)

router <- make_router(
  route("/", principal),
  route("Cesta-personalizada", cestaPersonalizada),
  route("Sobre-nos", SobreNos)
)


ui <- fluidPage(
  
  tags$head(tags$link(rel="icon", href="img/favicon.ico")),
    
  tags$div(class="navbar navbar-expand-md",
           tags$div(class="container",
                    tags$a(href = route_link("/"),class="navbar-brand"),
                    tags$button(class="navbar-toggler" ,type="button",
                      tags$i(class="fas fa-align-justify")
                          ),
                    tags$div(class="collapse navbar-collapse",id="navbarNav",
                             tags$ul( class ="navbar-nav ml-auto",
                                      tags$li( class="nav-item active",
                                               tags$a(class="nav-link", href= route_link("/"),"Página Inicial")
                                      ),
                                      tags$li(class="nav-item",
                                              tags$a(class="nav-link",href= route_link("Cesta-personalizada"),"Cesta personalizada")
                                      ),
                                      tags$li(class="nav-item",
                                              tags$a(class="nav-link",href= route_link("Sobre-nos"),"Sobre nós")
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
  
  output$HWplot <- renderUI({
    req(df())
    HWdata(df())
  })
  
  
  PRdf <- reactive({
    req(input$inputFileCP, file.exists(input$inputFileCP$datapath))
    read.csv(input$inputFileCP$datapath)
    })
  output$PRplot <- renderUI({
    req(PRdf())
    HWdata(PRdf(),)
  })
  
  ClienteID <-reactive({
    input$idInputCP
  })
}

shinyApp(ui = ui, server = server)