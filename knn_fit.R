knn_model <- nearest_neighbor(neighbors = tune()) %>%
  set_engine("kknn") %>%
  set_mode("classification")

spotify_train_ds <- spotify_train %>%
  sample_n(10000)
knn_fit <- fit(knn_wflow, spotify_train_ds)

# Create a workflow to tie everything together
knn_wflow <- workflow() %>%
  add_recipe(spotify_recipe) %>%
  add_model(knn_model)

# Define a grid of hyperparameters to search over
knn_grid <- grid_regular(neighbors(range = c(1, 20)))

# Run the model with 5-fold cross-validation and record the metric
knn_tuned <- tune_grid(
  knn_wflow,
  resamples = spotify_folds,
  grid = knn_grid,
  metrics = metric_set(roc_auc, precision, f_meas)
)

save(knn_tuned, file = 'results/knn_tuned.rds')
