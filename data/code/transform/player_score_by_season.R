# packages
library(dplyr)
library(ggplot2)
library(rlang)

# connect to database
setwd("/home/isaac/SpiderOak Hive/gouden_11/lib")
con <- DBI::dbConnect(RSQLite::SQLite(), "gouden_11")

# get players table
players <- tbl(con, "players")

# summarize by name and season
player_score_by_season = players %>%
  group_by(name, season) %>%
  summarise(team = team,
            position = position,
            avg_price = mean(price),
            opening_price = price,
            goal = sum(goal),
            assist = sum(assist),
            yellow = sum(yellow),
            red = sum(red),
            clean_sheet = sum(clean_sheet),
            goal_conceded = sum(goal_conceded),
            half_time = sum(half_time),
            team_performance = sum(team_performance))

# calculate total score
total_var = c("goal","assist","yellow","red","clean_sheet","goal_conceded",
              "half_time","team_performance")
total_expression = paste(total_var, collapse = '+')

player_score_by_season = player_score_by_season %>%
  mutate(total = !!parse_quosure(total_expression))

# calculate contribution
player_score_by_season = as.data.frame(player_score_by_season) %>% # must be dataframe if not SQL division
  mutate(contribution = total/opening_price) %>%
  as_tibble

# only keep relevant data
rm(list=setdiff(ls(), "player_score_by_season"))

