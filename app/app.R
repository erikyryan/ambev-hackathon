if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)

options(shiny.maxRequestSize = 50*1024^2)
source("../src/HWdata.r")

principal <- htmlTemplate(filename = "../resources/index.html", document_ = "auto", 
                          style = includeCSS("../resources/css/style.css"),
                          fontawesome = includeCSS("../resources/css/fontawesome.min.css"),
                          bootstrap_min = includeCSS("../resources/css/bootstrap.min.css"),
                          animate = includeCSS("../resources/css/animate.css"),
                          bootstrap_dropdownhover = includeCSS("../resources/css/bootstrap-dropdownhover.min.css"),
                          aos = includeCSS("../resources/css/aos.css"),
                          bootstrap_js =  includeScript("../resources/js/bootstrap.min.js"),
                          fontawesome_js  = tags$script(src="../resources/js/fontawesome.js"),
                          bootstrapdrop_js = includeScript("../resources/js/bootstrap-dropdownhover.min.js"),
                          aos_js =  includeScript("../resources/js/aos.js"),
                          custom_js = includeScript("../resources/js/custom.js"),
                          inputButton = fileInput("tidtInput", label = "Coloque o arquivo aqui", multiple = FALSE,
                                                  accept = ".csv"),
                          HWplot = plotOutput('HWplot')
)

SobreNos <- htmlTemplate(filename = "../resources/aboutUs.html", document_ = "auto"

)

cestaPersonalizada <- htmlTemplate(filename = "../resources/cestaPersonalizada.html", document_ = "auto",
                                   style = includeCSS("../resources/css/style.css"),
                                   fontawesome = includeCSS("../resources/css/fontawesome.min.css"),
                                   bootstrap_min = includeCSS("../resources/css/bootstrap.min.css"),
                                   animate = includeCSS("../resources/css/animate.css"),
                                   bootstrap_dropdownhover = includeCSS("../resources/css/bootstrap-dropdownhover.min.css"),
                                   aos = includeCSS("../resources/css/aos.css"),
                                   bootstrap_js =  includeScript("../resources/js/bootstrap.min.js"),
                                   fontawesome_js  = tags$script(src="../resources/js/fontawesome.js"),
                                   bootstrapdrop_js = includeScript("../resources/js/bootstrap-dropdownhover.min.js"),
                                   aos_js =  includeScript("../resources/js/aos.js"),
                                   custom_js = includeScript("../resources/js/custom.js"),
                                   inputFileCP = fileInput("dtInputCP", label = "Coloque o arquivo aqui", multiple = FALSE,
                                                           accept = ".csv"),
                                   inputClientCP = textInput("idInputCP",label = "Digite o Id do cliente",width = validateCssUnit("25%")),
                                   

)

router <- make_router(
  route("/", principal),
  route("Cesta-personalizada", cestaPersonalizada),
  route("Sobre-nos", SobreNos)
)


ui <- fluidPage(
  tags$head(tags$link(rel="icon", href="../resources/img/favicon.png")),
    
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
    
  reactive({
    df <- input$dtInput
    if(!is.null(df)){
    read.csv(df$datapath, header = input$header, stringsAsFactors = FALSE)    
    }
  })
  output$Hwplot <- renderPlot({
    HWdata(df)
  })
  
}

shinyApp(ui = ui, server = server)