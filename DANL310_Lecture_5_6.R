# Loading packages
library(tidyverse)
library(skimr)   # a better summary of data frame
library(scales)  # scales for ggplot

# setting the theme
theme_set(theme_minimal()) # setting the minimal theme for ggplot

# gapminder data
library(gapminder)
gapminder

# descriptive statistics
skim(gapminder)


# mappings link data to things you see
p <- ggplot(data = gapminder)

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p

p + geom_point()

p + geom_smooth()

p + geom_point() + geom_smooth()

p + geom_point() + geom_smooth(method = "lm")

p + geom_point() + 
    geom_smooth(method = "gam") +
    scale_x_log10()

p + geom_point() + 
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar)

p <-  ggplot(data = gapminder,
             mapping = aes(x = gdpPercap, y = lifeExp,
                           color = continent))
p

p <-  ggplot(data = gapminder,
             mapping = aes(x = gdpPercap, y = lifeExp,
                           color = "purple"))

p + geom_point() +
    geom_smooth(method = "loess") +
    scale_x_log10()

p <-  ggplot(data = gapminder,
             mapping = aes(x = gdpPercap, 
                           y = lifeExp))

p + geom_point(color = "purple") +
    geom_smooth(method = "loess") +
    scale_x_log10()

p + geom_point(alpha = 0.3) +
    geom_smooth(color = "orange", se = FALSE, size = 8, method = "lm") +
    scale_x_log10()

p + geom_point(alpha = 0.3) +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar) +
  labs(x = "GDP Per Capita", y = "Life Expectancy in Years",
       title = "Economic Growth and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent))

p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          fill = continent))

p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()

p <- ggplot(data = gapminder, 
            mapping = aes(x = gdpPercap, y = lifeExp))

p + geom_point(mapping = aes(color = continent)) +
  geom_smooth(method = "loess") +
  scale_x_log10()

p + geom_point(mapping = aes(color = log(pop))) +
  scale_x_continuous(trans = scales::log_trans())  # natural log scale

knitr::opts_chunk$set(fig.width=8, fig.height=5) 

p + geom_point()

ggsave(filename = "my_figure.png")

ggsave(filename = "my_figure.pdf")

p_out <- p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()
ggsave("my_figure.pdf", plot = p_out)

library(here)
ggsave(here("figures", "lifexp_vs_gdp_gradient.pdf"), plot = p_out)
  

p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPercap))

p + geom_line() 

p + geom_line(aes(group=country))

p + geom_line(aes(group=country)) + facet_wrap(~ continent)

p + geom_line(color="gray70", aes(group = country)) +
  geom_smooth(size = 1.1, method = "loess", se = FALSE) +
  scale_y_log10(labels=scales::dollar) +
  facet_wrap(~ continent, ncol = 5) +
  labs(x = "Year", y = "GDP per capita",
       title = "GDP per capita on Five Continents")


# Facet to make small mulitples
# The facet_wrap() function is best used when you want a series of small multiples 
# based on a single categorical variable.

p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPerCap))

p + geom_line(color="gray70", aes(group = country)) +
  geom_smooth(size = 1.1, method = "loess", se = FALSE) +
  scale_y_log10(labels=scales::dollar) +
  facet_wrap(~ continent, ncol = 5) +
  labs(x = "Year", y = "GDP per capita",
       title = "GDP per capita on Five Continents") + 
  theme(axis.text.x = element_text(angle = 45),
        axis.title.x = element_text(margin = margin(t = 25)))

install.packages("socviz")
library(socviz)

?gss_sm
glimpse(gss_sm)
skim(gss_sm)
view(gss_sm)


# The facet_grid() function is best used when you cross-classify some data by two categorical variables.

e.g., the relationship between the age and the number of children by sex and race

p <- ggplot(data = gss_sm,
            mapping = aes(x = age, y = childs))

p + geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_grid(sex ~ race)


p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion))
p + geom_bar()


# If we want a chart of relative frequencies rather than counts, 
# we will need to get the prop statistic instead.
# Our call to statistic from the aes() function generically looks like this: 
# <mapping> = <..statistic..>.

p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion))
p + geom_bar(mapping = aes(y = ..prop..))



# We need to tell ggplot to ignore the x-categories when calculating denominator
# of the proportion, and use the total number observations instead.
# To do so we specify group = 1 inside the aes() call.


p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion))
p + geom_bar(mapping = aes(y = ..prop.., group = 1)) 


table(gss_sm$religion)



# If we map religion to color, 
#only the border lines of the bars will be assigned colors, 
# and the insides will remain gray.

p <- ggplot(data = gss_sm,
            mapping = aes(x = religion, color = religion))
p + geom_bar()



# If the gray bars look boring and we want to fill them with color instead, 
# we can map the religion variable to fill in addition to mapping it to x.
# The default legend is about the color variable, which is redundant.

If we set guides(fill = "none"), the legend is removed.

p <- ggplot(data = gss_sm,
            mapping = aes(x = religion, fill = religion))
p + geom_bar() + guides( fill = "none" )


# A more appropriate use of the fill aesthetic with geom_bar() is to 
#cross-classify two categorical variables.
# The default output of such geom_bar() is a stacked bar chart, with counts on the y-axis.

p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion, fill = religion))
p + geom_bar()


# An alternative choice is to set the position argument to "fill".
# It is to compare proportions across groups.

p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion, fill = religion))
p + geom_bar(position = "fill")


# We can use position="dodge" to make the bars within each region of the 
# country appear side by side.

p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion, fill = religion))
p + geom_bar(position = "dodge",
             mapping = aes(y = ..prop..))


# In this case our grouping variable is religion, so we might try mapping that 
# to the group aesthetic.

p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion, fill = religion))
p + geom_bar(position = "dodge",
             mapping = aes(y = ..prop.., group = religion))


# Instead, we can ask ggplot to give us a proportional bar chart of religious affiliation, 
# and then facet that by region.
# The proportions are calculated within each panel, which is the breakdown we wanted.

p <- ggplot(data = gss_sm,
            mapping = aes(x = religion))
p + geom_bar(position = "dodge",
             mapping = aes(y = ..prop.., group = bigregion)) +
  facet_wrap(~ bigregion, ncol = 1)


# The ggplot package comes with a dataset, midwest, containing information on 
# counties in several midwestern states of the USA.

?midwest
glimpse(midwest)
skim(midwest)
view(midwest)


# By default, the geom_histogram() function will choose a bin size for us based on a rule of thumb.

p <- ggplot(midwest,
            aes(x = area))
p + geom_histogram()


# When drawing histograms it is worth experimenting with bins and also optionally the origin of the x-axis.

p <- ggplot(midwest,
            aes(x = area))
p + geom_histogram(bins = 10)


# We can facet histograms by some variable of interest, 
# or as here we can compare them in the same plot using the fill mapping.
# We subset the data here to pick out just two states.
# The %in% operator is a convenient way to filter on more than one term 
# in a variable when using subset()

oh_wi <- c("OH", "WI")

p <- ggplot(data = subset(midwest, subset = state %in% oh_wi),
            mapping = aes(x = percollege, fill = state))
p + geom_histogram(alpha = 0.8, bins = 20)


# When working with a continuous variable, an alternative to binning the data 
# and making a histogram is using the geom_density() function.
# It calculates a kernel density estimate of the underlying distribution.
# The area under the whole curve is usually 1.

p <- ggplot(data = midwest,
            mapping = aes(x = area))
p + geom_density()


# We can use color (for the lines) and fill (for the body of the density curve).
# These figures often look quite nice.
# When there are several filled areas on the plot, 
# as in this case, the overlap can become hard to read.

p <- ggplot(data = midwest,
            mapping = aes(x = area, fill = state, color = state))
p + geom_density(alpha = 0.3)


# For geom_density(), the stat_density() function can return its default ..density.. statistic, or ..scaled.., 
# which will give a proportional density estimate.
# It can also return a statistic called ..count.., which is the density times the number of points. 
# This can be used in stacked density plots.

oh_wi <- c("OH", "WI")
p <- ggplot(subset(midwest, subset = state %in% oh_wi),
            aes(x = area, fill = state, color = state))
p + geom_density(alpha = 0.3, mapping = (aes(y = ..scaled..)))


# The socviz package includes the titanic data frame.
# the aggregated data on who survived the Titanic disaster by sex.

?titanic
titanic


# We can tell geom_bar() not to do any work on the variable before plotting it.
# stat = "identity" means “don’t do any summary calculations”.

p <- ggplot(data = titanic,
            mapping = aes(x = fate, y = percent, fill = sex))

p + geom_bar(position = "dodge", stat = "identity") + theme(legend.position = "top")


# The socviz package also includes the oecd_sum data frame.
# The oecd_sum table information on average life expectancy at birth within the United States, 
# and across other OECD countries.

?oecd_sum
oecd_sum


# For convenience ggplot also provides a related geom, geom_col(), 
# which has exactly the same effect as geom_bar() but its default stat is stat = "identity".
# The position argument in geom_bar() and geom_col() can also take the value of "identity".
# position = "identity" means “just plot the values as given”.

p <- ggplot(data = oecd_sum,
            mapping = aes(x = year, y = diff, fill = hi_lo))
p + geom_col() + guides( fill = "none" ) + 
  labs(x = NULL, y = "Difference in Years",
       title = "The US Life Expectancy Gap",
       subtitle = "Difference between US and OECD
                   average life expectancies, 1960-2015",
       caption = "Data: OECD. After a chart by Christopher Ingraham,
                  Washington Post, December 27th 2017.")






