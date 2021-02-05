# The example is based on the shiny modules example from
# the official documentation: https://shiny.rstudio.com/articles/modules.html
library(config)
library(featureflag)
library(shiny)
config <- config::get()


counterButton <- function(id, label = "Counter") {
    ns <- NS(id)
    tagList(
        actionButton(ns("button"), label = label),
        verbatimTextOutput(ns("out"))
    )
}

counterServer <- function(id) {
    moduleServer(
        id,
        function(input, output, session) {
            count <- reactiveVal(0)
            observeEvent(input$button, {
                count(count() + 1)
            })
            output$out <- renderText({
                count()
            })
            count
        }
    )
}

ui <- fluidPage(
    counterButton("counter1", "Always Visible Counter"),

    feature_if(config$extra_counter_flag, {
        counterButton("flagged_counter", "Flagged Counter")
    })
)

server <- function(input, output, session) {
    counterServer("counter1")

    feature_if(config$extra_counter_flag, {
        counterServer("flagged_counter")
    })
}

shinyApp(ui, server)
