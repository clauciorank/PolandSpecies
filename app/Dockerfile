# get shiny server and R from the rocker project
FROM rocker/r-base:4.1.1

# system libraries
RUN apt-get update && apt-get install -y \
            libxml2-dev \
            libudunits2-dev \
            libssh2-1-dev \
            libcurl4-openssl-dev \
            libsasl2-dev \
            libgdal-dev \
            libgeos-dev \
            libproj-dev \
            libv8-dev \
            libsodium-dev

WORKDIR /srv/shiny/R

COPY . .

RUN chmod -R 755 .

# install R packages required
RUN Rscript requirements.R

EXPOSE 3838

# run app
CMD ["R",  "-e", "shiny::runApp('app.R', port = 3838, host = '0.0.0.0')"]
