library(tidyverse)
library(tidymodels)
library(knitr)
library(parsnip)
tidymodels_prefer()

spotify <- read_csv("data/genres.csv") %>% 
  janitor::clean_names()
skimr::skim(spotify)

ggplot(spotify, aes(genre)) +
  geom_bar() +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 50, vjust = .75),
    legend.position = "none"
  ) +
  ggtitle("Song Distribution Per Genre")

ggplot(spotify, aes(danceability, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(energy, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(loudness, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(speechiness, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(acousticness, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(instrumentalness, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(liveness, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(valence, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(tempo, color = genre)) +
  geom_freqpoly() +
  theme_minimal()

ggplot(spotify, aes(energy, loudness, color = genre, fill = genre), alpha = 0.2) +
  geom_point() +
  labs(
    x = "Energy",
    y = "Loudness",
    title = "Loudness vs. Energy"
  ) +
  theme_dark()

ggplot(spotify, aes(danceability, speechiness, color = genre, fill = genre), alpha = 0.2) +
  geom_point() +
  labs(
    x = "Danceability",
    y = "Speechiness",
    title = "Danceability vs. Speechiness"
  ) +
  theme_dark()