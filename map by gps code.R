##
##  Get image of an object by its gps coordinates
##

if (!require(ggmap)) install.packages("ggmap")

# loading the required packages
library(ggplot2)
library(ggmap)

mywd <- "/home/sirorezka/python_proj/geo problems"
setwd(mywd)


# creating a sample data.frame with your lat/lon points
lon <- c(-38.31,-35.5)
lat <- c(40.96, 37.5)
df <- as.data.frame(cbind(lon,lat))

# getting the map
mapgilbert <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 4,
                      maptype = "satellite", scale = 2)


# plotting the map with some points on it
dt_plot <- ggmap(mapgilbert, extent = "device") +
        geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 5, shape = 21) +
        guides(fill=FALSE, alpha=FALSE, size=FALSE) 

dt_plot

ggsave("myplot",dt_plot, device = "png")

?ggmap::ggmap

