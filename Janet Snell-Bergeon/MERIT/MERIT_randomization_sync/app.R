library(shiny)
library(tidyverse)
library(REDCapR)
library(DT)
ui <- fluidPage(
  actionButton("sync", "Click here to sync!"),
  DTOutput("done")
)
server <- function(input, output) {
  diffs <- eventReactive(input$sync, {
    # Pull data from the exercise database
    exercise <- redcap_read(
      redcap_uri = "https://redcap.ucdenver.edu/api/",
      token = "",
      batch_size = 10e6, verbose = F,
      fields = c("record_id", "exercise_order")
    )$data
    exercise <- exercise %>%
      rename(
        participant_id = record_id,
        screening_exercise_order = exercise_order
      )
    # Pull from MERIT
    merit <- redcap_read(
      redcap_uri = "https://redcap.ucdenver.edu/api/",
      token = "",
      batch_size = 10e6, verbose = F,
      fields = c("participant_id", "screening_exercise_order")
    )$data
    merit = merit %>% select(participant_id,screening_exercise_order) %>% 
      distinct()
    # Get differences for printing
    diffs <- setdiff(exercise, merit)
    # Import into MERIT database
    redcap_write_oneshot(exercise,
      redcap_uri = "https://redcap.ucdenver.edu/api/",
      token = "", verbose = F
    )
    as.data.frame(diffs)
  })
  output$done <- renderDT(diffs())
}
shinyApp(ui, server)
