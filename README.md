# DATA550 Final Project:

## Characteristics to Predict Diabetes

------------------------------------------------------------------------

## File Descriptions

1.  `code/01_make_output.R`

-   generates regression model table and boxplots
-   saves the table as `.rds` object and boxplots as `.png` in `output/` folder

2.  `code/02_render_report.R`

-   renders `final_report.Rmd`

3.  `final_report.Rmd`

-   reads regression table generated by `code/01_make_output.R`
-   reads boxplots generated by `code/01_make_output.R`

4.  `Makefile` contains rules for building the report

-   `make .outputs` will generate the `.rds` and `.png` files needed to compile the report
-   `make report.html` will generate the final report
-   `make clean` will clean all outputs
-   `make install` will synchronize packages with the lockfile
-   `make final_project_image` will build the docker image
-   `make report/final_report.html` will automatically generate the final report for the project

5.  `renv` associated files:

-   `renv.lock` stores the packages information associated specifically with this project
-   `.Rprofile` will load the project-specific packages
-   `activate.R` is a script file to activate the project-specific environment
-   `setting.json` is a configuration file to store project-specific settings and preferences

6.  `Dockerfile` specifies the environment and configuration needed to build the docker image for automated report construction

## Instructions for Packages Synchronization

1.  To check if you have the `renv` package installed

    -   Run `"renv" %in% row.names(installed.packages())` in your R console
    -   If the above command returns `FALSE`, install the `renv` package using `install.packages('renv')`

2.  In your R console, use `setwd` and `getwd` to confirm that the current working directory in the R console is the project directory

3.  Use `make install` rule for restoring the package environment for the project

## Instructions for Automated Report Construction with Docker

1.  Use `make final_project_image` rule which runs `docker build` to build the docker image for this project

2.  Here is the link to the Docker image as a public repository on Dockerhub: https://hub.docker.com/repository/docker/ellaxshen7/final_project/general

3. For Mac users, use `make report/final_report.html` rule directly, of which executes `docker run` to automate the final report building process;<br />
For Windows users, modify the `make report/final_report.html` rule by using `"/$$(pwd)"/report:/project/report` instead to specify the mounting path, and then run the rule to automate the final report building process
