#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
load("final_mod.RData")
# Define UI for application that draws a histogram
ui <- fluidPage(
  # Put inputs in a grid at the bottom of the page.   
  sidebarLayout(
    sidebarPanel(
      # Meal bolus
      numericInput(inputId = "m1_dailymealbolus",
                   label = "1 Month Average Daily Meal Bolus",
                   value = NA,min = 0,max = NA),
      # TIR     
      sliderInput(inputId = "m1_sensor_70_180",
                   label = "1 Month TIR (70 - 180 mg/dL)",
                   value = 50,min = 0,max = 100),
      # HFS worry
      sliderInput(inputId = "hfs_worry_low_bg",
                  label = "HFS Low BG Worry/Helplessness",
                  value = 0,min = 0,max = 36),
      p("Higher indicates more worry/helplessness."),
      p("Clinical cutoff >= 13."),
      # Run button.
      actionButton(inputId = "run",
                   label = "Run")),
    # Output panel on righthand side. 
    mainPanel(
      titlePanel("HCL Success Probability"),
      textOutput("final"),
      tags$head(tags$style("#final{color:black;
                         font-size: 200px;
                         font-style: italic;
                         }"
      )
      ))
  )
)
server <- function(input, output, session) {
  # Calculate probability.  
  prob <- eventReactive(input$run,{
    dat = data.frame(m1_sensor_70_180 = input$m1_sensor_70_180,
                     m1_dailymealbolus = input$m1_dailymealbolus,
                     hfs_worry_low_bg = input$hfs_worry_low_bg)
    round(as.numeric(predict(mod,newdata = dat,type = "response"))*100,digits = 1)
  })
  # Print low probability.
  output$final <- renderText({
    paste0(prob(),"%")
  })
}
shinyApp(ui, server)