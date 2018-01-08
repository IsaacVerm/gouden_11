# keep plots together for easier saving at the end
plots = list()

# price histogram

price_histogram = ggplot(data = season,
                         aes(x = opening_price)) +
  geom_histogram(binwidth = 1)

# relation between price of player and his total score
price_vs_total = ggplot(data = season,
                        aes(x = opening_price, y = total)) +
  geom_point() +
  geom_count()

season = season %>%
  mutate(attribution = total/opening_price) %>%
  arrange(desc(attribution))

attribution = ggplot(data = season,
                     aes(x = attribution)) +
  geom_histogram()
  
