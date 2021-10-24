if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)


principal <- htmlTemplate(filename = "../resources/index.html"

)

SobreNos <- htmlTemplate(filename = "../resources/aboutUs.html"

)

cestaPersonalizada <- htmlTemplate(filename = "../resources/index.html"

)

router <- make_router(
  route("/", principal),
  route("cesta-personalizada", cestaPersonalizada),
  route("Sobre-nos", SobreNos)
)


ui <- fluidPage(
  theme = "../resources/css/style.css", #importar tema CSS
  
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
                                              tags$a(class="nav-link",href= route_link("Sobre-nos"),"Sobre nós"))
                            )
                    )
              )
      ),
    router$ui
  
  # tags$div(class="collapse navbar-collapse",id="navbarNav",
  #          tags$ul( class ="navbar-nav ml-auto",
  #                   tags$li( class="nav-item active",
  #                            tags$a()
  #                            )
  #                   )
  #   )
  
  
  # <div class="navbar navbar-expand-md"> 
  #   <div class="container">
  #   <a href="index.html" class="navbar-brand"></a>
  #   <!--<img alt="" align="left" src="img/logo.png" height="100" width="30"> --> 
  #   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
  #   <i class="fas fa-align-justify"></i>
  #   </button>
  #   <div class="collapse navbar-collapse" id="navbarNav">
  #   <ul class="navbar-nav ml-auto">
  #   <li class="nav-item active">
  #   <a class="nav-link" href="index.html">Página Inicial <span class="sr-only">(current)</span></a>
  #   </li>
  #   <li class="nav-item">
  #   <a class="nav-link" href="aboutUs.html">Sobre nós</a>
  #   </li>
  #   </ul>
  #   </div>
  #   </div>
  #   </div>
)


server <- function(input, output,session) {
   router$server(input, output,session)
    # df -> input$dtInput 
}

shinyApp(ui = ui, server = server)