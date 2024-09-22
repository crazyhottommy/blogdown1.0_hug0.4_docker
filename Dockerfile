# Use the Rocker RStudio image
FROM rocker/rstudio:4


# Install system dependencies, including fontconfig and freetype
RUN apt-get update && apt-get install -y \
    tzdata \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libsqlite3-0 \
    libclang-dev \
    psmisc \
    sudo \
    wget \
    zlib1g-dev \
    libgit2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    pkg-config \
    libharfbuzz-dev \
    libfribidi-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libbz2-dev

# Set the timezone to avoid interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone to Boston (EST)
RUN echo "America/New_York" > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata


# Install Hugo (ARM64)
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.42/hugo_0.42_Linux-ARM64.tar.gz && \
    tar -xvzf hugo_0.42_Linux-ARM64.tar.gz hugo && \
    mv hugo /usr/local/bin/ && \
    rm hugo_0.42_Linux-ARM64.tar.gz

#make a directory to be mounted to the host machine for installing R packages
RUN mkdir /usr/local/lib/R/host-site-library

RUN echo '.libPaths(c("/usr/local/lib/R/host-site-library", .libPaths()))' > /home/rstudio/.Rprofile

# Install blogdown package
RUN R -e "install.packages('blogdown', version = '1.0', repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('tidyverse')"



# Expose ports for RStudio Server and Hugo
EXPOSE 8787 1313

