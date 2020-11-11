library(tidyverse)
library(httr)

trends <- rtweet::get_trends()
dplyr::glimpse(trends)

# 1. Vamos tuitar!
rtweet::post_tweet(
  "Estou tuitando no curso de Web Scraping da @curso_r, usando o pacote {rtweet}! #rstats"
)

# 2. Pegando a timeline
da_timeline <- rtweet::get_timeline("allison_horst")

head(da_timeline$text)

# 3. Pegando as menções
da_mencoes <- rtweet::get_mentions()

head(da_mencoes$text)

# 4. Encontrar amigos

da_users <- rtweet::search_users("#rstats", n = 100)

da_users %>% 
  dplyr::select(screen_name, text)
