tree_fit <- fit_resamples(
  tree_wflow,
  spotify_folds,
  metrics = metric_set(roc_auc)
)

tree_params <- parameters(tree_model)
tree_grid <- grid_regular(min_n(range = c(2, 20)))

tree_tuned <- tune_grid(
  tree_wflow,
  resamples = spotify_folds,
  grid = tree_grid,
  metrics = metric_set(roc_auc, precision, f_meas)
)

save(tree_tuned, file = 'results/tree_tuned.rds')
