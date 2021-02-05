# The example is based on the shiny modules example from
# the official documentation: https://shiny.rstudio.com/articles/modules.html
library(featureflag)
library(shiny)

FLAGS <- list(
    extra_counter_flag = create_bool_feature_flag(value = FALSE)
)

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

    feature_if(FLAGS$extra_counter_flag, {
        counterButton("flagged_counter", "Flagged Counter")
    })
)

server <- function(input, output, session) {
    counterServer("counter1")

    feature_if(FLAGS$extra_counter_flag, {
        counterServer("flagged_counter")
    })
}

shinyApp(ui, server)
