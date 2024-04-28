### Project-associated Rules

final_report.html: final_report.Rmd code/02_render_report.R .outputs
	Rscript code/02_render_report.R

.outputs: code/01_make_output.R data/diabetes.csv
	Rscript code/01_make_output.R

.PHONY: clean
clean:
	rm -f output/* && rm -f final_report.html && rm -f .outputs && rm -f Rplots.pdf report/final_report.html
	
.PHONY: install
install: 
	Rscript -e "renv::restore()"
	

### Docker Rules

PROJECTFILES = final_report.Rmd code/01_make_output.R code/02_render_report.R data/diabetes.csv Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

# rule to build image
final_project_image: $(PROJECTFILES) $(RENVFILES)
	docker build -t final_project_image .
	touch $@
	
# rule to mount directories and build report automatically in container
# syntax is speficified for mac users, windows users require a additional '/' at the beginning of the $$(pwd)
report/final_report.html:
	docker run -v "$$(pwd)"/report:/project/report final_project_image


