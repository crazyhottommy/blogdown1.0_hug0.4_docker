This docker image is built with hugo0.42 and blogdown1.19. 
It also has Rstudio server and tidyverse installed.

```bash
cd blogdown1.0_hug0.4_docker 

docker build -t my-rstudio-blogdown .

```

```
docker run -d -p 8787:8787 -p 8080:8080 \
    -v ~/githup_repo/DivingIntoGeneticsAndGenomics:/home/rstudio/my_blog \
    -v ~/R/host-site-library:/usr/local/lib/R/host-site-library \
    -v ~/blog_data:/home/rstudio/blog_data \
    -e USER=rstudio \
    -e PASSWORD=test \
    --name my-rstudio-hugo-container my-rstudio-blogdown
```


need to specify the port (which we mapped to local 8080) and the host. If you do not specify the host to be `0.0.0.0`, you can not access the website either.

```r
blogdown::serve_site(port = 8080, host = '0.0.0.0')

```

go to your web browser and type localhost:8080 you should see the blogdown website!

My blog uses hugo0.42, and blogdown1.0 can render the website, but the Rstudio add-in for creating a new post does not work. 

Manully create a post inside the `content/post` folder using file name format "2024-08-11-my-test.Rmd" and use the yaml header with a format below: 

```yaml

---
title: "Your Post Title"
author: "Your Name"
date: "2024-08-11"
output:
  blogdown::html_page:
    self_contained: false
tags: ["tag1", "tag2"]
categories: ["category1"]
---
```

### push the docker image to dockerhub

```bash
docker login

docker tag my-rstudio-blogdown crazyhottommy/my-rstudio-blogdown:latest

docker push crazyhottommy/my-rstudio-blogdown:latest

```

