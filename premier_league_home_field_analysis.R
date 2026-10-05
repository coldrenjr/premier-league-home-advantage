library(tidyverse)

season_2526 <- read.csv("Prem25-26.csv") %>%
  rename(
    home_goals = FTHG,
    away_goals = FTAG,
    result = FTR
  )%>%
  select(home_goals, away_goals, result) %>% 
  mutate(season = "2025-26")

season_2425 <- read_csv("Prem24-25.csv") %>%
  rename(
    home_goals = FTHG,
    away_goals = FTAG,
    result = FTR
  )%>%
  select(home_goals, away_goals, result) %>% 
  mutate(season = "2024-25")

season_2324 <- read_csv("Prem23-24.csv") %>%
  rename(
    home_goals = FTHG,
    away_goals = FTAG,
    result = FTR
  )%>%
  select(home_goals, away_goals, result) %>% 
  mutate(season = "2023-24")

games <- bind_rows(season_2324, season_2425, season_2526)

games %>%
  group_by(season) %>%
  summarise(home_win_pct = mean(result == "H") * 100,
            draw_pct     = mean(result == "D") * 100,
            away_win_pct = mean(result == "A") * 100,
            avg_home_goals = mean(home_goals),
            avg_away_goals = mean(away_goals))

ggplot(games, aes(x = result, fill = season)) +
  geom_bar(position = "dodge")

test <- t.test(games$home_goals, games$away_goals, paired = TRUE)

cat("Matches:", nrow(games), "\n")
cat("Home wins:", round(mean(games$result == "H") * 100, 1), "%\n")
cat("Draws:", round(mean(games$result == "D") * 100, 1), "%\n")
cat("Away wins:", round(mean(games$result == "A") * 100, 1), "%\n")
cat("Avg home goals:", round(mean(games$home_goals), 2), "\n")
cat("Avg away goals:", round(mean(games$away_goals), 2), "\n")
cat("Mean difference:", round(test$estimate, 2), "\n")
cat("t-statistic:", round(test$statistic, 2), "\n")
cat("p-value:", format.pval(test$p.value, digits = 3), "\n")

