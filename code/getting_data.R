library(sf)
library(dplyr)
library(tidyverse)

# facebook <- read.csv("arg_general_2020_csv/arg_general_2020.csv")
# facebook <- facebook %>% 
#   st_as_sf(coords = c('longitude', 'latitude'), crs =4326)
# 
# facebook <- st_read("arg_general_2020_geotiff/arg_general_2020.tif")
# 
# facebook <- facebook %>% 
#   st_transform(crs=4326)
# 
ejido <- st_read("ejido-municipal_iAEC1kw/EjidoMunicipal.shp")
ejido <- ejido %>%
  st_transform(crs= 4326)
# 
# face_cba <- st_intersects(facebook, ejido)
# 
# st_write(face_cba, "face_cba.shp")


library(raster)
library(sf)
library(stars)

# Leer el archivo GeoTIFF de los radios censales de Argentina como un objeto RasterLayer
r <- raster("arg_general_2020_geotiff/arg_general_2020.tif")

# Convertir el objeto RasterLayer en un objeto stars
s <- st_as_stars(r)

# Convertir el objeto stars en un objeto sf
sf_radios_censales <- st_as_sf(s, as.points = TRUE)

# Leer el archivo SHP del polígono de la ciudad de Córdoba como un objeto sf
sf_cordoba <- st_read("cordoba.shp")

# Utilizar la función st_intersection() de la librería sf para quedarse solo con los radios censales de Córdoba
sf_radios_censales_cordoba <- st_intersection(sf_radios_censales, sf_cordoba)
