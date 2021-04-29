get_data_set <- function(text_input){
  if(!is.null(text_input)){
    file <- text_input
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == c("xlsx","csv"), "Please upload a .csv or a .xlsx file"))
    data_set <- read_csv(file$datapath)
  }
  else{
    data_set <- read_csv("../data/test.csv")
  }
  return(data_set)
}