library(tidyverse)
nome <- read.delim("pokemonname.txt")
library(gtrendsR)
library(reshape2)

google.trends = gtrends(nome$x[1:5], gprop = "web", time = "now 7-d", low_search_volume = TRUE)[[1]]

google.trends |> group_by(keyword) |> mutate(keyword = factor(keyword, unique(keyword)), hits = as.numeric(hits)) |> summarise(rate = mean(hits)