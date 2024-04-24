report.html: final_report.Rmd code/02_render_report.R .outputs
	Rscript code/02_render_report.R

.outputs: code/01_make_output.R data/diabetes.csv
	Rscript code/01_make_output.R

.PHONY: clean
clean:
	rm -f output/* && rm -f final_report.html && rm -f .outputs && rm -f Rplots.pdf
	
.PHONY: install
install: 
	Rscript -e "renv::restore()"
	

# Docker Rules

PROJECTFILES = final_report.Rmd code/01_make_output.R code/02_render_report.R data/diabetes.csv Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

# Note: do not use phony rule
# rule to build image
# $(<variable>) references a variable in Make
final_project_image: $(PROJECTFILES) $(RENVFILES)
	docker build -t final_project_image .
	touch $@
	
# rule to build report automatically in container: mount directories
# syntax speficified for mac user, windows user require a additional '/' at the beginning of the pwd
final_report/final_report.html:
	docker run -v "$$(pwd)"/final_report:/project/final_report final_project_image


