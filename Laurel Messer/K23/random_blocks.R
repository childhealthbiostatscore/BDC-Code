# Seed must be different between testing and production in REDCap
set.seed(1017)
# Enter randomization parameters
block_randomize = function(total_n,strat_ratio = c(2,1),max_block_size = 12) {
  strat_levels = length(strat_ratio)
  # n for each stratification group
  strat_ns = unlist(lapply(strat_ratio, function(x){x*total_n/sum(strat_ratio)}))
  # Create block size options
  block_sizes = seq(from = 1,to = max_block_size)
  # Multiple of sum(strat_ratio)
  block_sizes = block_sizes[which(block_sizes %% sum(strat_ratio)==0)]
  # Multiple of strat_levels
  block_sizes = block_sizes[which(block_sizes %% strat_levels==0)]
  # Factor of ns
  block_sizes = unlist(lapply(block_sizes, function(x){
    if (sum(strat_ns %% x) == 0){x}
  }))
  if(length(block_sizes) < 2){
    stop(paste("This function requires at least two compatible block sizes. Current block sizes:",
               paste(block_sizes,collapse = ", ")))
    }
  # Empty DF
  table = data.frame(matrix(nrow = total_n,ncol = 2))
  colnames(table) = c("treatment","strat")
  # Stratification column
  table$strat = unlist(lapply(1:strat_levels, function(x){rep(x,strat_ns[x])}))
  # Treatment column
  table$treatment = unlist(lapply(1:strat_levels, function(x){
    strat_length = strat_ratio[x]*(total_n/sum(strat_ratio))
    blocks = c()
    while (sum(blocks) < strat_length) {
      blocks = c(blocks,min(sample(block_sizes,1),strat_length - sum(blocks)))
    }
    t = unlist(lapply(blocks, function(x){
      perm = sample(c(unlist(lapply(1:strat_levels, function(y){
        rep(y,strat_ratio[y]*(x/sum(strat_ratio)))
      }))),replace = F)
      perm
    }))
    t
  }))
  print(table(table$treatment,table$strat))
  return(table)
}
# Repeat twice
df = rbind(block_randomize(total_n = 120,strat_ratio = c(1,1),max_block_size = 12),
           block_randomize(total_n = 120,strat_ratio = c(1,1),max_block_size = 12))
