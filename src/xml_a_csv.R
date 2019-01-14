require(XML)
library(dplyr)
library(readr)


xml_path_to_csv_path <- function(path) {
  paste0(file_path_sans_ext(path), ".csv")
}

convertir <- function(path) {
  xmlParse(path) %>% 
    xmlToList %>% 
    purrr::map_df(~as.vector(.x)) %>% 
    write_csv(xml_path_to_csv_path(path))
}


list.files('./xml/data/xml/', full.names=TRUE) %>%
  purrr::walk(convertir)