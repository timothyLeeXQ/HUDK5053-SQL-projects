#install.packages(c("httr", "jsonlite", "dplyr"))
library(httr)
library(jsonlite)
library(dplyr)

# Function to get data
get_gh_pulls <- function(user, repo_name, token){
  endpoint <- paste0("https://api.github.com/repos/", user, "/", repo_name, "/pulls")
  request <- httr::GET(endpoint, add_headers(Authorization = token))
  raw_data <- fromJSON(content(request, as = 'text'))
  df <- cbind(raw_data, raw_data$user$login) %>%
    select(number, `raw_data$user$login`, created_at, title, body)
  colnames(df) <- c("pr_number", "pr_creator", "pr_created_ts", "pr_title", "pr_message")
    
  df
}

# Authentication Details
user <- "la-process-and-theory"
token <- paste0('token ', Sys.getenv("GH_token"))

# Get Data
neural_nets <- get_gh_pulls(user, "neural-networks", token)
nlp <- get_gh_pulls(user, "natural-language-processing", token)
closing_the_loop <- get_gh_pulls(user, "loop-closing", token)
prediction <- get_gh_pulls(user, "prediction", token)
recommender_systems <- get_gh_pulls(user, "recommender-systems", token)

# Write to CSV
write.csv(neural_nets, "neural_nets.csv")
write.csv(nlp, "nlp.csv")
write.csv(closing_the_loop, "closing_the_loop.csv")
write.csv(prediction, "prediction.csv")
write.csv(recommender_systems, "recommender_systems.csv")
