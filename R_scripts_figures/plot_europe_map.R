library ('tidyverse')
library("rnaturalearth")
library("rnaturalearthdata")
library ('rgeos')
library ('ggspatial')
library ('ggplot2')
library ('ggsn')


setwd("~/r_analysis/2nd_chapter_phd/databases/")

stubbs <- read.csv("complete.all.collections.final_vulgaris.csv")

world_2 <- map_data('world')
somerset_map <- ggplot(world_2, aes(long, lat)) +
  theme_bw() + 
  theme(panel.grid = element_line(color = gray(.5), linetype = "dotted", size = 0.5)) +
  geom_map(map=world_2, aes(map_id=region), fill=NA, color="black") + #shows map of the world where countries are filled with color white and borders are in black
  coord_equal(xlim = c(-2.8, -2.2), ylim = c(50.9, 51.42), expand = T) + #localizes map in the Somerset region
  xlab ("Longitude (°W)") + ylab("Latitude (°N)") +
  theme(axis.title = element_text(size = 18)) +
  theme(axis.text = element_text(size = 10)) +
  theme(axis.title=element_blank()) +
  scalebar(x.min = -2.8, x.max = -2.66, y.min = 51.38, y.max = 51.55, transform = T, dist_unit = "km", dist = 5, height = 0.09, st.dist = 0.09) + #add scale 
  geom_point(data = stubbs, aes(x = longitude, y = latitude,  shape = pop_type), size = 7) + scale_shape_manual(values = c(15,16,17)) +
  theme(legend.position = "none")


world <- ne_countries(scale = "large", returnclass = "sf")
ggplot(data = world) +
  coord_sf() 

europe_map <- ggplot(data = world) +
  geom_sf(color = "black", fill = "lightgreen") +
  geom_sf(color = "black", fill = "white") +
  xlab ("Longitude") + ylab("Latitude") +
  theme(axis.title = element_text(size = 18)) +
  theme(axis.text = element_text(size = 11)) +
  theme(panel.grid.major = element_line(color = gray(.5), linetype = "solid", size = 0.5), panel.background = element_rect(fill ='grey90')) +
  coord_sf(xlim = c(-10,40), ylim = c(38, 57), expand = TRUE) +
  geom_point(data = stubbs, aes(x = longitude, y = latitude,  shape = pop_type), size = 7) + scale_shape_manual(values = c(15,16,17)) +
  theme(legend.position = c(0.93, 0.85), legend.direction = "vertical") 
  #geom_text(data = stubbs, aes(x = longitude, y = latitude, label= new_pop_id), size = 5, position = position_jitter(width=1.5, height=1)) +

europe_map + annotation_custom (
  grob = ggplotGrob(somerset_map),
  xmin = -10,
  xmax = 5,
  ymin = 47,
  ymax = 37
)
