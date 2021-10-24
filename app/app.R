if(!require(shiny)) install.packages("shiny");require(shiny)
if(!require(shiny.router)) install.packages("shiny.router");require(shiny.router)
  if(!require(shiny.semantic)) install.packages("shiny.semantic");require(shiny.semantic)

style <- includeCSS("../resources/css/style.css")
fontawesome <- includeCSS("../resources/css/fontawesome.min.css")
animate <- includeCSS("../resources/css/animate.css")
bootstrap_drop <- includeCSS("../resources/css/bootstrap-dropdownhover.min.css")
bootstrap <- includeCSS("../resources/css/bootstrap.min.css")
aos <- includeCSS("../resources/css/aos.css")


bootstrapjs <- includeScript("../resources/js/bootstrap.min.js")
fontawesomejs <- tags$script(src="../resources/js/fontawesome.js") 
bootstrapdropjs <- includeScript("../resources/js/bootstrap-dropdownhover.min.js") 
aosjs <- includeScript("../resources/js/aos.js")
customjs <- includeScript("../resources/js/custom.js")

principal <- htmlTemplate(filename = "../resources/index.html", document_ = "auto", 
                          style = style,
                          fontawesome = fontawesome,
                          bootstrap_min = bootstrap,
                          animate= animate,
                          bootstrap_dropdownhover = bootstrap_drop,
                          aos = aos,
                          bootstrap_js =  bootstrapjs,
                          fontawesome_js  = fontawesomejs,
                          bootstrapdrop_js = bootstrapdropjs,
                          aos_js = aosjs,
                          custom_js = customjs
)

SobreNos <- htmlTemplate(filename = "../resources/aboutUs.html", document_ = "auto"

)

cestaPersonalizada <- htmlTemplate(filename = "../resources/cestaPersonalizada.html", document_ = "auto"

)

router <- make_router(
  route("/", principal),
  route("cesta-personalizada", cestaPersonalizada),
  route("Sobre-nos", SobreNos)
)


ui <- fluidPage(
  titlePanel(
    title = tags$head(tags$link(rel="icon", href="../resources/img/favicon.png")),
),
  
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
                                              tags$a(class="nav-link",href= route_link("cestaPersonalizada"),"Cesta personalizada")
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
    # df -> input$dtInput 
}

shinyApp(ui = ui, server = server)