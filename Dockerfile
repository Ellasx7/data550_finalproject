FROM rocker/r-ubuntu

RUN apt-get update && apt-get install -y pandoc

RUN mkdir /project
WORKDIR /project

COPY final_report.Rmd . 
COPY Makefile . 

RUN mkdir code 
RUN mkdir output
RUN mkdir data
COPY code code 
COPY data/diabetes.csv data

COPY .Rprofile .
COPY renv.lock .
RUN mkdir -p renv
COPY renv/activate.R renv
COPY renv/settings.json renv

RUN Rscript -e "renv::restore(prompt = FALSE)" 

RUN mkdir report

### Finalizing automated build
# add the entry point
CMD make && mv final_report.html report 

