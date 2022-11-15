library(caret)
load("~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/R01/Data_Raw/JDRFCAV_preprocessed.Rdata")
# Base recipe
# Need to use role updating for large dimension datasets
cpep_recipe <- recipe(df) %>%
  update_role(cpep_model_decayrate,new_role = "outcome") %>%
  update_role(-one_of("cpep_model_decayrate"),new_role = "predictor") %>%
  step_zv(all_predictors()) %>%
  step_nzv(all_predictors()) %>%
  step_YeoJohnson(all_predictors()) %>%
  step_normalize(all_predictors()) %>%
  step_corr(all_predictors()) %>% 
  prep()
# Save transformed data
transformed_df <- bake(transformed,df)
save(transformed_df,file = "~/UCD/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Howard Davidson/R01/Data_Raw/JDRFCAV_preprocessed_transformed.Rdata")