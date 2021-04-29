ui <- dashboardPage(
  dashboardHeader(
    title = "TidyUP"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home",
        tabName = "home", icon = icon("home")
      ),
      menuItem("Data",
        tabName = "data", icon = icon("th")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home"),
      tabItem(tabName = "data",
              fileInput("data_set", label = "Select a messy data set: ",
                        placeholder = "File", accept = c(".xlsx",".csv")),
              DT::dataTableOutput("data_display"),
              radioButtons("tidy_action", "Tidy action", 
                           choices = c("Spread", "Gather", "Separate", "Unite"),
                           selected = character(0), inline = TRUE),
              #actionButton("spread", "Spread the values across columns"),
              conditionalPanel(condition = "input.tidy_action == 'Spread'",
                               textInput(
                                 "spread_key_column", "Key column", 
                                 placeholder = "Key column to be spread"
                                 ),
                               textInput(
                                 "spread_value_column", "Value column",
                                 placeholder = "Value column to be rearranged"
                                 )
                               ),
              conditionalPanel(condition = "input.tidy_action == 'Gather'",
                               textInput(
                                 "gather_key_column", "Key column", 
                                 placeholder = "Column to be gathered the keys in"
                               ),
                               textInput(
                                 "gather_value_column", "Value column", 
                                 placeholder = "Column to be gathered the values in"
                               )
              ),
              conditionalPanel(condition = "input.tidy_action == 'Separate'",
                               textInput(
                                 "separate_column", "Column to be separated"
                               ),
                               textInput(
                                 "separate_into_column1", "Column to be separated the first part in"
                               ),
                               textInput(
                                 "separate_into_column2", "Column to be separated the second part in"
                               ),
                               textInput(
                                 "separate_sep", "Separator which divided the column in two parts"
                               )
              ),
              conditionalPanel(condition = "input.tidy_action == 'Unite'",
                               textInput(
                                 "unite_new_column", "Column the values should be united in"
                                 ),
                               textInput(
                                 "unite_sep", "Separator which divides the column in two parts"
                                 )
                               ),
              DT::dataTableOutput("data_tidier")
              )
      
    )
  )
)