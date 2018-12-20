create_comb_list <- function(ratings, n = 10)
{
  r <- expand.grid(rep(list(0:n), length(ratings))) 
  r = subset(r, rowSums(r) == n) 
  colnames(r) <- paste0('R', ratings)
  r
}

get_combs_with_target_rating <- function(ratings, target = 85, cost = c(), pre = NULL)
{
  combs = create_comb_list(ratings, 11 - length(pre))

  if (length(cost) == 0)
      cost = 1:length(ratings)
    
  squad_ratings = apply(combs, 1, function(c)
  {
    team_total = sum(pre)
    for (r in 1:length(ratings))
    {
      team_total = team_total + (ratings[r] * c[r])
    }
    
    avg_rating = team_total/11.0
    total_excess = if (!is.null(pre)) pre - avg_rating else 0
    total_excess = sum (total_excess[total_excess > 0])
    for (r in 1:length(ratings))
    {
      if (c[r] != 0 && ratings[r] > avg_rating)
        total_excess = total_excess + ((ratings[r] - avg_rating)* c[r])
    }
  
    real_rating = round(team_total + total_excess) / 11.0
    floor(real_rating)
  })
  
  estCost = apply(combs, 1, function(c) sum(c * cost))
  
  result = cbind(combs, data.frame(Rating =squad_ratings, EstCost = estCost))
  result = subset(result, Rating >= target)
  result[order(result$EstCost),]
}
     
#Get rating combinations for target 85, containing 84,85 or 86-rated players with ALREADY included 88-rated player	 
#get_combs_with_target_rating(ratings = c(84,85,86), target = 85, pre = 88)