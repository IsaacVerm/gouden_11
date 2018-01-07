# packages
library(dplyr)
library(purrr)

# connect to database
setwd("/home/isaac/")
con <- DBI::dbConnect(RSQLite::SQLite(), "gouden_11")

# get players table
players <- tbl(con, "players")

# no missing values
no_missing_values = all(complete.cases(as.data.frame(players)))
if (no_missing_values) {
  print("There are no missing values.")
} else {
  print("Missing values exist.")
}

# does each player feature in all matchdays?
nr_of_matchdays_by_player = players %>%
  group_by(name) %>%
  summarise(count = n()) %>%
  pull(count)

feature_in_all_matchdays = function(nr_of_matchdays_player, total_nr_of_matchdays) {
  nr_of_matchdays_player == total_nr_of_matchdays
}

each_player_all_matchdays = all(map_lgl(nr_of_matchdays_by_player,
                                        feature_in_all_matchdays,
                                        total_nr_of_matchdays = 22))

if (each_player_all_matchdays){
  print("Each player has data for all matchdays.")
} else {
  print("At least one player doesn't have data for all matchdays.")
}



  