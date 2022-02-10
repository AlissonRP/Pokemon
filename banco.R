library(tidyverse)
nome <- read.delim("pokemonname.txt")
library(gtrendsR)
library(reshape2)


popu <- data.frame(keyword=character(), hits=numeric())
google.trends = gtrends(nome$x[11:15], gprop = "web", time = "now 7-d", low_search_volume = TRUE)[[1]] %>% 
  group_by(keyword) %>% 
  mutate(hits = fct_recode(hits, "0.9" = "<1"), keyword = factor(keyword, unique(keyword)), hits = as.numeric(hits)) %>% 
  summarise(rate = mean(hits)) %>% 
  select(keyword, rate) %>%
  add_row(popu,.)
popu <- google.trends %>% 
  group_by(keyword) %>% 
  mutate(hits = fct_recode(hits, "0.9" = "<1"), keyword = factor(keyword, unique(keyword)), hits = as.numeric(hits)) %>% 
  summarise(rate = mean(hits)) %>% 
  select(keyword, rate) %>%
  add_row(popu,.)
popu <- popu |> add_row(p)

i=1
while(i <= nrow(nome)){
  google.trends = gtrends(nome$x[i:i+4], gprop = "web", time = "now 7-d", low_search_volume = TRUE)[[1]]
  popu <- google.trends %>% 
    #group_by(keyword) %>% mutate(hits = ifelse(hits == "<1", '0.9', hits)) %>%
    #mutate(keyword = factor(keyword, unique(keyword)), hits = as.numeric(hits)) %>% 
    #summarise(rate = mean(hits)) %>% 
    select(keyword, hits) %>%
    add_row(popu,.)
  i = i +5
}
                                                                                                                                                                      