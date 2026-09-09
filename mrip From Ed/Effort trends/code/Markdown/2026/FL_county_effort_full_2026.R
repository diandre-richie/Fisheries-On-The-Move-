### Screwing around with running Rmarkdown from R, which I think you'll want to do when you're looping documents
#	This piece of code creates a list from an input dataframe, which might be useful if you had really large number of items and don't want to manually create lists
#	NOTE	In this format, each county would require the same number of input, i.e. I don't think this would work with a ragged array thing
#	NOTE 	As always, this must work with a specific .Rmd, in this case one that calls parameters as "tmplist$<column name>"

rm(list = ls())
library(rmarkdown)

### Control Panel ###
	# Determine if running on desktop or from server
	online <- "U:/UF/Extension specific/CFEE/"
	offline <- "C:/Users/edvcamp/Desktop/running files offline Summer 2026/FL/"
	wd_location <- offline

### Data ###
	setwd(paste0(wd_location, "Effort trends/code/Markdown/2026")) #set working directory to where any input files exist
		countlist <- read.csv("countlist_parms_eff_full.csv", header=T, colClasses=c("character")) #this reads in a csv of parameters for each county. It reads them all in as characters
		
		#testing a single county out of loop
		countlist <- countlist[which(countlist$county==c("Pinellas")),]


### Model ###

	#apparently R can't find pandoc so need to tell it where to look
	Sys.setenv(RSTUDIO_PANDOC="C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools")


	for(i in 1:length(countlist$county)){   #this steps through each county at a time
		#tryCatch({
			tmplist <- as.list(countlist[i,])   #this is the what does it--the "templist" creates a list object with $ operators for each row (county) in the input file. This means tmplist$county returns "Brevard"
		  	rmarkdown::render( 					#this calls render from markdown
		    	'FL_county_effort_full_2026.Rmd', output_file = paste0('2025_Effort_', tmplist$county, '_full.docx') #this first item is the input file--you need a "general" .Rmd files with any parameters called as such--so if you want the ouput to say "Brevard", the input should say `r templist$county`
			)
		#}, error=function(e){})     								#note that the above must create a unique name for each file, otherwise it will overwrite.
	}


###test and to use as debugging
# tmplist <- as.list(countlist[which(countlist$county=="Monroe"),])
#   rmarkdown::render( 					#this calls render from markdown
#     'county_effort_2pp.Rmd', output_file = paste0('2021_Effort_', tmplist$county, '_2pp.docx') #this first item is the input file--you need a "general" .Rmd files with any parameters called as such--so if you want the ouput to say "Brevard", the input should say `r templist$county`
# 	)   

