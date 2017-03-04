rm(list = ls())

# load packages 
packages <- c("jsonlite", "purrr", "dplyr")
purrr::walk(packages, library, character.only = TRUE, warn.conflict = FALSE)

fileLoc <- "C:/DataSets/train.json"
data <- fromJSON(txt = fileLoc)

# unlist every variable except `photos` and `features` and convert to tibble
vars <- setdiff(names(data), c("photos","features"))
data <- map_at(data, vars, unlist) %>% tibble::as_tibble(.)

options(tibble.width = Inf)
# options(tibble.print_max = n, tibble.print_min = m): if there are more than n rows, print only the first m rows. Use options(tibble.print_max = Inf) to always show all rows.
# 
# options(tibble.width = Inf) will always print all columns, regardless of the width of the screen.
head(data,10)
# dont used columns in vars (photos & features), pipelieb output to tibble to create as.tibble. From this interim table select listing_id, features and interest_level
# Mutate adds new variables and preserves existing; transmute drops existing variables.
# 

data_txt_col <- map_at(data, vars, unlist) %>% 
  tibble::as_tibble(.) %>%
  select(listing_id, features, interest_level) %>%
  mutate(interest_level = factor(interest_level, c("low", "medium", "high")))
head(data_txt_col)

# write.xlsx(data, "C:/datasets/trainjson.xlsx", sheetName="Sheet1", 
#            col.names=TRUE, row.names=TRUE, append=FALSE, showNA=TRUE)
