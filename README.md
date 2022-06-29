# Poland Species Visualization

This project consists of a shiny app for the visualization of the observed species in Poland. Data comes from the Global Biodiversity Information Facility and it is avaliable at https://drive.google.com/file/d/1l1ymMg-K_xLriFv1b8MgddH851d6n2sU/view?usp=sharing.

## **Steps**

### **Preprocessing**

The downloaded csv is about 21GB large and was too big for my RAM memory so I needed to process it with an alternative method to filter only `country == "Poland"` from the dataset. I decided to do it with `{disk.frame}`, a package that I used before to process this kind of big data. One cool thing about `{disk.frame}` package is that it accepts `{dplyr}` and `pipe` syntaxe.

After extracting the data from Poland and a quick exploratory analysis I decided to work with Poland provinces. The location of the points only followed a pattern in the `latitudeDecimal` and `longitudeDecimal`, the other ones referred to this topic were almost useless. To find the province of each point was necessary to find the intersection of the point with the province polygons ([poland.geojson](https://github.com/ppatrzyk/polska-geojson/blob/master/wojewodztwa/wojewodztwa-medium.geojson)) using the package `{sf}` and the function `st_intersects()`.

### **The App**

The app consists in a modularized shiny app with only one selectize input that provides matching the `vernacularName` and the `scientificName` of the desired species. The data and the map geometries are processed reactively and used as input for two functions (`make_leaflet()` and `make_timeline()`) that return the desired outputs:
- A map built with `{leaflet}` that shows how many observations were made in each province and also the points where the observation occurred.
- A bar plot that shows when the observations were made (in years).

I made some little design modifications in the app, like changing the font and background colors with [CSS style](app/www/styles.css).

### **Tests**
For testing I used `shinytest2::record_test()`. The results are available in the repo. To avoid cover edge cases I perform a sample of 5 species inputs:
- 1 from the minimum value of observations.
- 1 from the maximum.
- 3 random samples from all the observations.

Expecting values from the 2 plots.

### **Deploy**

The app is deployed at [shinyapps.io](https://clauciorank.shinyapps.io/PolandSpecies/) and despite not being deployed in a cloud service the structure for it with `shinyproxy` and `Docker` is also available in the repository.

### **Next steps**

For the app improvement, adding pop-ups in each point showing some information like the date of the observation or the species photography and more filters and visualizations using the species taxonomic classification would be great!

Some optimization in the code performance would also be a good idea!
Fast rendering of the leaflet map could be implemented with [`{leafgl}`](https://github.com/r-spatial/leafgl) allowing the use of more points and expanding the countries in the observation scope.

Upload to a cloud service with a CI/CD deployment pipeline would simplify alterations and the app delivery to the final client.