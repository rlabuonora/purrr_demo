library(XML)
library(dplyr)
library(readr)
library(purrr)
library(tools)


xml_path_to_csv_path <- function(path) {
  name <- file_path_sans_ext(basename(path))
  file.path('data', 'csv', paste0(name, '.csv'))
}

convertir <- function(path) {
  xmlParse(path) %>% 
    xmlToList %>% 
    purrr::map_df(~as.vector(.x)) %>% 
    write_csv(xml_path_to_csv_path(path))
}


list.files('./data/xml/', full.names=TRUE) %>%
  purrr::walk(convertir)