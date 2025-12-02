library(shiny)

ui <- fluidPage(
  titlePanel("Patient Data Entry"),

  sidebarLayout(
    sidebarPanel(
      selectInput("sex", "Sex:", choices = c("", "Male", "Female", "Other")),

      selectInput(
        "race",
        "Race:",
        choices = c(
          "",
          "White",
          "Black or African American",
          "Asian",
          "Hispanic or Latino",
          "Native American",
          "Other"
        )
      ),

      selectInput("fdr_status", "FDR Status:", choices = c("", "Yes", "No")),

      selectInput(
        "ab_status",
        "AB Status:",
        choices = c("", "Positive", "Negative")
      ),

      numericInput("age", "Age:", value = NULL, min = 0, max = 120),

      numericInput(
        "mean_glucose",
        "Mean Glucose (mg/dL):",
        value = NULL,
        min = 0,
        max = 500
      ),

      br(),
      actionButton("add_data", "Add Entry", class = "btn-primary"),
      actionButton("clear_data", "Clear All Data", class = "btn-warning"),
      br(),
      br(),
      downloadButton("download_data", "Download Data")
    ),

    mainPanel(
      h3("Stored Data"),
      tableOutput("data_table"),
      br(),
      textOutput("row_count")
    )
  )
)

server <- function(input, output, session) {
  # Initialize reactive dataframe
  data_store <- reactiveVal(data.frame(
    Sex = character(),
    Race = character(),
    FDR_Status = character(),
    AB_Status = character(),
    Age = numeric(),
    Mean_Glucose = numeric(),
    stringsAsFactors = FALSE
  ))

  # Add data to dataframe
  observeEvent(input$add_data, {
    # Validation
    if (
      input$sex == "" ||
        input$race == "" ||
        input$fdr_status == "" ||
        input$ab_status == "" ||
        is.null(input$age) ||
        is.null(input$mean_glucose)
    ) {
      showModal(modalDialog(
        title = "Missing Data",
        "Please fill in all fields before adding an entry.",
        easyClose = TRUE
      ))
      return()
    }

    # Create new row
    new_row <- data.frame(
      Sex = input$sex,
      Race = input$race,
      FDR_Status = input$fdr_status,
      AB_Status = input$ab_status,
      Age = input$age,
      Mean_Glucose = input$mean_glucose,
      stringsAsFactors = FALSE
    )

    # Add to existing data
    current_data <- data_store()
    updated_data <- rbind(current_data, new_row)
    data_store(updated_data)

    # Reset inputs
    updateSelectInput(session, "sex", selected = "")
    updateSelectInput(session, "race", selected = "")
    updateSelectInput(session, "fdr_status", selected = "")
    updateSelectInput(session, "ab_status", selected = "")
    updateNumericInput(session, "age", value = NA)
    updateNumericInput(session, "mean_glucose", value = NA)
  })

  # Clear all data
  observeEvent(input$clear_data, {
    showModal(modalDialog(
      title = "Confirm Clear",
      "Are you sure you want to clear all data?",
      footer = tagList(
        modalButton("Cancel"),
        actionButton("confirm_clear", "Clear Data", class = "btn-danger")
      )
    ))
  })

  observeEvent(input$confirm_clear, {
    data_store(data.frame(
      Sex = character(),
      Race = character(),
      FDR_Status = character(),
      AB_Status = character(),
      Age = numeric(),
      Mean_Glucose = numeric(),
      stringsAsFactors = FALSE
    ))
    removeModal()
  })

  # Display data table
  output$data_table <- renderTable({
    data_store()
  })

  # Display row count
  output$row_count <- renderText({
    paste("Total entries:", nrow(data_store()))
  })

  # Download data
  output$download_data <- downloadHandler(
    filename = function() {
      paste("patient_data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(data_store(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)
