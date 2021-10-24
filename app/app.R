if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)


principal <- htmlTemplate(filename = "../resources/index.html", document_ = "auto"
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
  includeCSS("../resources/css/style.css"),

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
    router$ui,
)


server <- function(input, output,session) {
   router$server(input, output,session)
    # df -> input$dtInput 
}

shinyApp(ui = ui, server = server)