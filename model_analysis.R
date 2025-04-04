set.seed(710)
spotify_split <- initial_split(spotify, prop = 0.8, strata = genre)
spotify_train <- training(spotify_split)
spotify_test <- testing(spotify_split)

# decision trees
tree_model <- 
  decision_tree(min_n = tune()) %>% 
  set_engine("rpart") %>% 
  set_mode("classification")

# k-nearest neighbor model
knn_model <- nearest_neighbor(neighbors = tune()) %>%
  set_engine("kknn") %>%
  set_mode("classification")

# recipe building
spotify_recipe <- recipe(
  genre ~ danceability + energy + key + loudness + mode + speechiness + acousticness + instrumentalness + liveness + valence + tempo, data = spotify_train
) %>% 
  step_normalize(all_numeric_predictors())

spotify_folds <- vfold_cv(spotify_train, v = 5, repeats = 3)

# model workflows
tree_wflow <- workflow() %>%
  add_recipe(spotify_recipe) %>%
  add_model(tree_model)

tree_fit <- fit(tree_wflow, spotify_train)

knn_wflow <- workflow() %>%
  add_recipe(spotify_recipe) %>%
  add_model(knn_model)

spotify_train_ds <- spotify_train %>%
  sample_n(10000)
knn_fit <- fit(knn_wflow, spotify_train_ds)

# parameters & grids
tree_params <- parameters(tree_model)
tree_grid <- grid_regular(min_n(range = c(2, 20)))

knn_params <- parameters(knn_model)
knn_grid <- grid_regular(neighbors(range = c(1, 20)))

load("results/tree_tuned.rds")
load("results/knn_tuned.rds")

collect_metrics(tree_tuned)
collect_metrics(knn_tuned)

tree_best <- select_best(tree_tuned, "roc_auc")
knn_best <- select_best(knn_tuned, "roc_auc")

best_tree <- show_best(tree_tuned, metric = "roc_auc")[1,]
best_knn <- show_best(knn_tuned, metric = "roc_auc")[1,]

best_roc <- tibble(model = c("Tree", "KNN"),
                   ROC_AUC = c(best_tree$mean, best_knn$mean),
                   se = c(best_tree$std_err, best_knn$std_err)
)

best_roc

knn_pred <- predict(knn_fit, new_data = spotify_test) %>%
  bind_cols(spotify_test) %>%
  select(genre, starts_with(".pred"))
knn_pred

conf_mat <- knn_pred %>% 
  mutate(genre = as.factor(genre)) %>% 
  conf_mat(genre, starts_with(".pred_"))
conf_mat