FIFA rating combinations calculator

USAGE (in R/RStudio or other R interpreters):

get_combs_with_target_rating(ratings = c(84,85,86), target = 85) #simple
get_combs_with_target_rating(ratings = c(84,85,86), target = 85, pre = 88) #predefined player with rating 88 included
get_combs_with_target_rating(ratings = c(84,85,86), target = 85, pre = 88, cost = c(4000, 6000, 8000)) #players' cost included

where:
ratings = array of player ratings, to search combinations of.
target = target team rating
pre = [OPTIONAL] array of player ratings, ALREADY included to the team (may be NULL)
cost = [OPTIONAL] array of players' prices for optimal SBC price calculation
