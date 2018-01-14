# load data
setwd("/home/isaac/SpiderOak Hive/gouden_11/data/code/preparation")
source('player_score_by_season.R')

# packages
library(lpSolve)

# select only current season
player_score_by_season = player_score_by_season %>%
  filter(season == "2016-2017")

# biggest contribution by position
contribution_by_position = player_score_by_season %>%
  arrange(desc(contribution)) %>%
  top_n(100)

# 
profitability_positions = ggplot(data = contribution_by_position,
                                 aes(x = name, y = contribution, fill = position)) +
  geom_col()

plot(profitability_positions)

# # setup problem
# # x1 + 9 x2 + x3 subject to
# # x1 + 2 x2 + 3 x3 <= 9
# # 3 x1 + 2 x2 + 2 x3 <= 15
# #
# f.obj <- c(1, 9, 1)
# f.con <- matrix (c(1, 2, 3, 3, 2, 2), nrow=2, byrow=TRUE)
# f.dir <- c("<=", "<=")
# f.rhs <- c(9, 15)
# #
# # Now run.
# #
# lp ("max", f.obj, f.con, f.dir, f.rhs)
# ## Not run: Success: the objective function is 40.