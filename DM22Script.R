# Hello plot! -------------------------------------------------------------

## Load packages
library(tidyverse)
## Load data
data(mpg)
## Inspect data
mpg %>%
  print(n = 4, width = 70)

## Generate plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  labs(x = "Engine Size", y = "Highway MPG") +
  theme_bw()


# R Objects ---------------------------------------------------------------

## Scalar
vec_one <- 4
vec_one[1] # 1-indexed!
## Vector 
num_vec <- c(1, 9, 8)
int_vec <- c(1L, 9L, 8L)
chr_vec <- c("S","Oli","S")
bool_vec <- c(TRUE, FALSE)
map(list(num_vec,int_vec, chr_vec, bool_vec), class)

## Matrix (column major ordering!)
small_matrix <- matrix(c(1:6), ncol = 2)
small_matrix[1,2]
true_vector %*% small_matrix

## Array
small_array <- array(c(1:12), dim = c(3, 2, 2))
small_array[1,2,1]
true_vector %*% small_array[,,1]

## Lists
small_list <- list(first = 1:3, second = letters[1:4])
small_list[[1]] # small_list[["first"]] also works
small_list$second


## Data Frame
small_df <- data.frame(list(Name = c("John", "Jane"),
                            Age = c(36, 38),
                            Student = c(TRUE, FALSE)))
summary(small_df)

## Tibbles
small_tbl <- as_tibble(small_df)
small_tbl


# Importing data ----------------------------------------------------------

# Read data in 
turnout <- read_csv("https://bit.ly/ANESTurnout")

# Quick view of data set
glimpse(turnout, width=70)

# Filter data to only midterms between 1984 and 2000
anes_sub <- filter(turnout,
                   (year %in% seq(1984, 2000, by=4)))
glimpse(anes_sub)

# Arrange data by TO estimate, then descending by year
(anes_ord <- arrange(turnout, # Notice that tibble always comes first!
                     ANES, desc(year)))

## Select columns
(anes_sub2 <- select(turnout,
                     matches("V.P"), year, felons:overseas))

## Create new variables
turnout <- mutate(turnout,
                  TO_VEP = total/VEP,
                  TO_VEP = TO_VEP * 100)


# Merging data ------------------------------------------------------------

## Load data
(dates <- read_csv("https://bit.ly/DM22_dates"))
(works <- read_csv("https://bit.ly/DM22_works"))

## Do inner join
dates_works <- inner_join(dates, works) 
dates_works

## Do left join (keep all x)
dates_someworks <- left_join(dates, works) 
dates_someworks

## Do right join (keep all y)
dates_allworks <- right_join(dates, works) 
print(dates_allworks, width=70)

## Dor full join (all x and all y)
alldates_allworks <- full_join(dates, works) 
print(alldates_allworks, width=70)



# Pivoting data -----------------------------------------------------------

## See bad wide data
table4a

## Pivot to long
new_tab_long <- pivot_longer(table4a,
                             cols = c(`1999`, `2000`),
                             names_to = "year",
                             values_to = "cases")
new_tab_long

## See bad long data
table2

## Pivot to wide
new_tab_wide <- pivot_wider(table2, 
                            names_from = type,
                            values_from = count)
new_tab_wide



# Piping ------------------------------------------------------------------

## Multiple operations
new_tab_wide <- table2 %>% 
  pivot_wider(names_from = type,
              values_from = count) %>% 
  filter(country %in% c("Brazil", "China"))

new_tab_wide

## Multiple operations (new pipe)

new_tab_wide_NP <- table2 |> 
  pivot_wider(names_from = type,
              values_from = count) |>
  filter(country %in% c("Brazil", "China"))

new_tab_wide_NP









# Create TO rate, in percentage, by VEP
turnout <- mutate(turnout,
                  TO_VEP = total/VEP,
                  TO_VEP = TO_VEP * 100)
