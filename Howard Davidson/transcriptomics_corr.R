library(tidyverse)
library(pheatmap)
library(skimr)
library(glmnet)
library(knitr)
library(igraph)
library(networkD3)
library(car)
library(performance)
library(caret)
library(parallel)
library(doParallel)
setwd("~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/TEDDY data")
load("./Data_Clean/time_0.RData")
# Clean data (standard pipeline)
data_preprocces = function(df,missing_cutoff = 0.8,cv_cutoff = NULL,
                           log_transform = F,scale = T,
                           outcome = "y",id_cols = c("id","time")){
  # Get predictors
  pred = colnames(df)[which(!(colnames(df) %in% c(outcome,id_cols)))]
  # Predictors with too much missing data
  if(!is.null(missing_cutoff)){
    missing = pred[which(colMeans(is.na(df[,pred]))>=missing_cutoff)]
  } else {missing = c()}
  # Predictors with high CV
  if(!is.null(cv_cutoff)){
    cvs = sapply(df[,pred], function(c){
      sd(c,na.rm = T) / mean(c,na.rm = T)
    })
    high_cv = pred[which(cvs > cv_cutoff)]
  } else {high_cv = list()}
  # Remove columns
  initial_set = setdiff(pred,c(missing,high_cv))
  df = df[,c(id_cols,initial_set,outcome)]
  # Remove rows with all missing
  rows_missing = rowSums(is.na(df[,initial_set]))
  df = df[which(rows_missing < length(initial_set)),]
  # Log transform
  if(log_transform){
    df[,initial_set] = lapply(df[,initial_set],log)
    if(any(df == -Inf)){warning("-Inf present after log transform")}
  }
  # Scale
  if(scale){
    df[,initial_set] = lapply(df[,initial_set],scale)
  }
  return(df)
}
# Cluster variables according to DIFAcTO pipeline.
# If optimize_corr = T, this will override the manual corr_cutoff. Correlation
# cutoff should be optimized for all assays, but does not need to be run every time.
corr_cluster = function(df,parallel_ratio = 0.25,folds = 5,
                        outcome = "y",id_cols = c("id","ID","time"),
                        optimize_corr = T, corr_cutoff = NULL,
                        heatmap = T,heatmap_params = list(show_rownames = T,show_colnames = T),
                        network = T){
  # Get predictors
  pred = setdiff(colnames(df),c(id_cols,outcome))
  # Outcome is binary
  df[,outcome] = factor(df[,outcome])
  # Complete
  df = df[complete.cases(df),]
  # Correlations between predictors
  corr_mat = cor(df[,pred],use = "pairwise.complete.obs")
  # Get pairs
  var_cor = corr_mat*lower.tri(corr_mat)
  # Find best correlation cutoff
  if(optimize_corr){
    rs = seq(0,1,by = 0.01)
    # Parallel
    cl <- makeCluster(detectCores()*parallel_ratio,type = "FORK")
    model_perf = parLapply(cl,rs, function(r){
      # Correlation cutoff
      check_cor = which(abs(var_cor) >= r, arr.ind=TRUE)
      # Convert correlated pairs into graph clusters
      graph_cor = graph.data.frame(check_cor, directed = FALSE)
      # Get names
      groups_cor = split(unique(as.vector(check_cor)), clusters(graph_cor)$membership)
      groups = lapply(groups_cor,FUN=function(list_cor){rownames(var_cor)[list_cor]})
      # Find highest correlation within each group
      # Use logistic model estimate instead of correlation
      best_cor = lapply(groups, function(g){
        assocs = lapply(g, function(v){
          form = as.formula(paste0(outcome,"~",v))
          mod = glm(form,df,family = "binomial")
          coefs = summary(mod)$coefficients
          return(abs(coefs[2,1]))
        })
        return(g[which.max(assocs)])
      })
      best_cor = as.character(best_cor)
      if(length(best_cor)>0){
        # CV with caret
        set.seed(1017)
        cv = trainControl(method = "cv",number = folds)
        # Model
        form = as.formula(paste0(outcome,"~",paste0(best_cor,collapse = "+")))
        # CV
        mod = train(
          form, data = df,
          method = "glm",
          family = "binomial",
          trControl = cv,
          tuneLength = 25
        )
        return(mod$results$Accuracy)
      } else {return(NA)}
    })
    stopCluster(cl)
    opt_r = rs[which.max(model_perf)]
  } else {opt_r = corr_cutoff}
  # final groups
  # Correlation cutoff
  check_cor = which(abs(var_cor) >= opt_r, arr.ind=TRUE)
  # Convert correlated pairs into graph clusters
  graph_cor = graph.data.frame(check_cor, directed = FALSE)
  # Get names
  groups_cor = split(unique(as.vector(check_cor)), clusters(graph_cor)$membership)
  groups = lapply(groups_cor,FUN=function(list_cor){rownames(var_cor)[list_cor]})
  # Find highest correlation within each group
  best_cor = lapply(groups, function(g){
    assocs = lapply(g, function(v){
      form = as.formula(paste0(outcome,"~",v))
      mod = glm(form,df,family = "binomial")
      coefs = summary(mod)$coefficients
      return(abs(coefs[2,1]))
    })
    return(g[which.max(assocs)])
  })
  best_cor = as.character(best_cor)
  # Plots
  if(heatmap){
    heatmap_params[["mat"]] = corr_mat
    heat = do.call(pheatmap,heatmap_params)
  }
  if(network){
    # Interactive plot
    int_plot_df = check_cor
    int_plot_df[,1] = rownames(corr_mat)[int_plot_df[,1]]
    int_plot_df[,2] = colnames(corr_mat)[as.numeric(int_plot_df[,2])]
    # Node DF
    nodes <- data.frame(name = unique(c(int_plot_df[,1], int_plot_df[,2])), 
                        stringsAsFactors = FALSE)
    nodes$id <- 0:(nrow(nodes) - 1)
    # Edges DF
    edges <- int_plot_df %>% data.frame(.) %>%
      left_join(nodes, by = c("row" = "name")) %>%
      select(-row) %>%
      rename(source = id) %>%
      left_join(nodes, by = c("col" = "name")) %>%
      select(-col) %>%
      rename(target = id)
    # Plot parameters
    edges$width <- 1
    # Color by group
    nodes$group = sapply(nodes$name, function(n){
      l = lapply(groups, function(x){
        n %in% x
      })
      as.numeric(which(l == TRUE))
    })
    # Plot
    p = forceNetwork(Links = edges, Nodes = nodes, 
                     Source = "source",
                     Target = "target",
                     NodeID ="name",
                     Group = "group",
                     Value = "width",
                     zoom = TRUE,
                     opacity = 1,
                     height = 720,
                     width = 720)
  }
  if(heatmap & network){
    return(list("best" = best_cor,"r_cutoff" = opt_r,"heatmap" = heat,"network" = p))
  } else if (heatmap & !network){
    return(list("best" = best_cor,"r_cutoff" = opt_r,"heatmap" = heat))
  } else if (!heatmap & network){
    return(list("best" = best_cor,"r_cutoff" = opt_r,"network" = p))
  } else {return("best" = best_cor,"r_cutoff" = opt_r,)}
}
transcript = data_preprocces(X$transcriptomics)
transcript_best = corr_cluster(transcript,heatmap=F,network=F,optimize_corr = T)
save(transcript_best,file = "./Data_Clean/transcript_best.RData")