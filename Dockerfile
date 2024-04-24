FROM rocker/r-ubuntu

RUN apt-get update && apt-get install -y pandoc

RUN mkdir /project
WORKDIR /project

# dot specifies we store the file to current path
COPY final_report.Rmd . 
COPY Makefile . 

# here we use relative paths
# then copy local code folder into code folder in container
RUN mkdir code 
RUN mkdir output
RUN mkdir data
COPY code code 
COPY data/diabetes.csv data

### Manually copy wanted renv files only
COPY .Rprofile .
COPY renv.lock .
RUN mkdir -p renv
COPY renv/activate.R renv
COPY renv/settings.json renv

### sync packages from lockfile inside the image
RUN Rscript -e "renv::restore(prompt = FALSE)" 

RUN mkdir final_report
RUN make

### Finalizing automated build
# add the entry point
CMD mv final_report.html final_report 

