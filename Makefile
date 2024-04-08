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