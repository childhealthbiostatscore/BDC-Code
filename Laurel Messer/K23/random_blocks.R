total_n = 120
groups = 2
strat_levels = 2
strat_ratio = c(1,1)
max_block_size = 8
block_sizes = seq(from = strat_ratio*groups,to = max_block_size,by = groups)

table = data.frame(matrix(nrow = 2*total_n,ncol = 2))
colnames(table) = c("treatment","strat")

table$strat = unlist(lapply(1:strat_levels, function(x){
  rep(x,strat_ratio[x]*(total_n/sum(strat_ratio)))
}))

table$treatment = unlist(lapply(1:strat_levels, function(x){
  strat_length = strat_ratio[x]*(total_n/sum(strat_ratio))
  blocks = c()
  while (sum(blocks) < strat_length) {
    blocks = c(blocks,min(sample(block_sizes,1),strat_length - sum(blocks)))
  }
  t = lapply(blocks, function(x){
    perms = expand.grid(rep(list(1:groups),times = x))
    as.numeric(perms[sample(nrow(perms),1),])
  })
  t
}))
