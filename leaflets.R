## http://jsfiddle.net/px9LyL87/6/

install.packages("Rcpp")
library(devtools)
library(Rcpp)
install_github('ramnathv/rMaps')

devtools::install_github('ropensci/git2r')


mywd <- "/home/sirorezka/python_proj/geo problems"
setwd(mywd)

v1 <- c(30,50,10)
v2 <- c(31,51,10)
v3 <- c(32,52,10)

v_all <- rbind(v1,v2,v3)

t1 <- c(33,53,10)
t2 <- c(34,54,10)
t3 <- c(35,55,10)

t_all <- rbind(t1,t2,t3)


v_dat = rjson::toJSONArray2(na.omit(v_all), json = F, names = F)


v_json <- jsonlite::toJSON(v_all[,1:2],"values")
t_json <- jsonlite::toJSON(t_all[,1:2],"values")

v_json
t_json

library(rMaps)


L2 <- Leaflet$new()
L2$setView(c(29.7632836,  50), 6)
L2$tileLayer(provider = "MapQuestOpen.OSM")
L2$addAssets(jshead = c("http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js"))

# Add javascript to modify underlying chart
L2$setTemplate(afterScript = sprintf("
<script>
  var addressPoints = %s
  var heat = L.heatLayer(addressPoints, {radius: 25, minOpacity: 0.5}).addTo(map)           
</script>
", v_json
))

L2

L2$save("some.html")
getwd()
