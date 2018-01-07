# packages
library(dplyr)
library(ggplot2)
library(rlang)

# connect to database
setwd("/home/isaac/")
con <- DBI::dbConnect(RSQLite::SQLite(), "gouden_11")

# get players table
players <- tbl(con, "players")
players_df <- as.data.frame(players)

# keep plots togehter for easier saving at the end
plots = list()

# over whole season

## matchday as integer
season = players_df %>% # df since tibble throws strange SQL error
  mutate(matchday = recode(matchday, "previous season" = "-1")) %>%
  mutate(matchday = as.integer(matchday)) %>%
  arrange(matchday)

## calculate by season

season %>%
  group_by(name, season) %>%
  summarise(team = first(team),
            avg_price = mean(price),
            opening_price = first(price),
            goal = sum(goal),
            assist = sum(assist),
            yellow = sum(yellow),
            red = sum(red),
            clean_sheet = sum(clean_sheet),
            goal_conceded = sum(goal_conceded),
            half_time = sum(half_time),
            team_performance = sum(team_performance))

## total
total_var = c("goal","assist","yellow","red","clean_sheet","goal_conceded",
              "half_time","team_performance")
total_expression = paste(total_var, collapse = '+')

season = season %>%
  mutate(total = !!parse_quosure(total_expression))


# price histogram

price_histogram = ggplot(data = season,
                         aes(x = opening_price)) +
  geom_histogram(binwidth = 1)

# relation between price of player and his total score
price_vs_total = ggplot(data = season,
                        aes(x = opening_price, y = total)) +
  geom_point() +
  geom_count()

season = season %>%
  mutate(attribution = total/opening_price) %>%
  arrange(desc(attribution))

attribution = ggplot(data = season,
                     aes(x = attribution)) +
  geom_histogram()
  
