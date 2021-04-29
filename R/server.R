server <- function(input, output, session){
  
  get_tidied_table <- reactive({
    messy_data_set <- get_data_set(input$data_set)
    
    if(input$tidy_action == "Spread"){
      req(input$spread_key_column)
      req(input$spread_value_column)
      
      data_set <- spread(messy_data_set, key = input$spread_key_column,
                         value = input$spread_value_column)
      
    } else if(input$tidy_action == "Gather"){
      req(input$gather_key_column)
      req(input$gather_value_column)
      
      data_set <- gather(messy_data_set, key = input$gather_key_column,
                         value = input$gather_value_column)
      
    } else if(input$tidy_action == "Separate"){
      req(input$separate_column)
      req(input$separate_into_column1)
      req(input$separate_into_column2)
      req(input$separate_sep)
      
      data_set <- separate(messy_data_set, col = input$separate_column,
                           into = c(input$separate_into_column1, 
                                    input$separate_into_column2),
                           sep = input$separate_sep)
      
    } else {
      req(input$unite_new_column)
      req(input$unite_sep)
      
      data_set <- unite(messy_data_set, col = input$unite_new_column,
                        sep = input$unite_sep)
    }
    
    return(data_set)
  })
  
  output$data_display <- DT::renderDataTable({
    head(get_data_set(input$data_set), 5)
  })
  
  output$data_tidier <- DT::renderDataTable({
    head(get_tidied_table(), 5)
  })
  
  
}