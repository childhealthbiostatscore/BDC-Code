library(shiny)
library(JMbayes2)
library(tidyverse)
load(
  "/Users/tim/Library/CloudStorage/OneDrive-UW/UWMDI/Andrea Steck/Advanced CGM and OGTT/Data_Clean/final_model.RData"
)
ui <- fluidPage(
  titlePanel("Patient Data Entry"),

  sidebarLayout(
    sidebarPanel(
      selectInput("sex", "Sex:", choices = c("Male", "Female")),

      selectInput(
        "race",
        "Race:",
        choices = c(
          "Non-Hispanic White",
          "Other"
        )
      ),

      selectInput("fdr_status", "FDR Status:", choices = c("FDR", "GP")),

      selectInput(
        "ab_status",
        "AB Status:",
        choices = c("Single", "Multiple")
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
      textOutput("row_count"),
      br(),
      h3("Age vs Mean Glucose"),
      plotOutput("scatter_plot"),
      br(),
      h3("Dynamic Prediction"),
      plotOutput("dynamic_pred")
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

  # Scatter plot
  output$scatter_plot <- renderPlot({
    data <- data_store()

    if (nrow(data) == 0) {
      plot(
        1,
        type = "n",
        xlab = "Age",
        ylab = "Mean Glucose (mg/dL)",
        main = "No data available",
        xlim = c(0, 100),
        ylim = c(0, 300)
      )
      text(50, 150, "Add entries to see the plot", cex = 1.2, col = "gray")
    } else {
      plot(
        data$Age,
        data$Mean_Glucose,
        xlab = "Age",
        ylab = "Mean Glucose (mg/dL)",
        main = "Age vs Mean Glucose",
        pch = 19,
        col = "steelblue",
        cex = 1.5
      )
      grid()
    }
  })

  # Dynamic predictions
  output$dynamic_pred <- renderPlot({
    data <- data_store()
    if (nrow(data) == 0) {
      plot(
        1,
        main = "No data available"
      )
      text(50, 150, "Add entries to see the plot", cex = 1.2, col = "gray")
    } else {
      data = data |>
        rename(
          sex = Sex,
          Race_Ethn2 = Race,
          screen_FDR_GP = FDR_Status,
          maxAB_group = AB_Status,
          mean_glucose = Mean_Glucose
        ) |>
        mutate(
          sex = factor(sex, levels = c("Female", "Male")),
          Race_Ethn2 = factor(
            Race_Ethn2,
            levels = c("Other", "Non-Hispanic White"),
            labels = c("Other", "NHW")
          ),
          maxAB_group = factor(
            maxAB_group,
            levels = c("Single", "Multiple"),
            labels = c("2", "3")
          ),
          screen_FDR_GP = factor(screen_FDR_GP, levels = c("FDR", "GP"))
        )
      data$event <- 0
      data$AgeEndpoint <- ceiling(max(data$Age))
      data$ID = "A"

      predLong1 <- predict(
        best_model,
        newdata = data,
        return_newdata = TRUE,
        process = "longitudinal",
        type = "mean_subject"
      )
      predSurv <- predict(
        best_model,
        newdata = data,
        process = "event",
        type = "mean_subject",
        times = seq(16, 20, length.out = 51),
        return_newdata = TRUE
      )
      plot(predLong1, predSurv)
    }
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
