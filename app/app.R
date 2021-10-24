if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)

router <- make_router(
  router("/", principal),
  router("/cesta-personalizada", cestaPersonalizada),
  router("/Sobre-nos", SobreNos)
)

principal <- htmlTemplate(
  
)

cestaPersonalizada <- htmlTemplate(
  
)

SobreNos <- htmlTemplate(
  
)

ui <-  shinyUi(fluidPage(
  tags$div(class="collapse navbar-collapse",id="navbarNav",
           tags$ul( class="navbar-nav ml-auto")
           )
    )
)
# <div class="collapse navbar-collapse" id="navbarNav">
#   <ul class="navbar-nav ml-auto">
#   <li class="nav-item active">
#   <a class="nav-link" href="index.html">Página Inicial <span class="sr-only">(current)</span></a>
#   </li>
#   <li class="nav-item">
#   <a class="nav-link" href="about-us.html">Sobre nós</a>
#   </li>
#   </ul>
#   </div>

server <- function(input, output,session) {
  router$server(input, output,session)
    # df -> input$dtInput 
}

shinyApp(ui = ui, server = server)
