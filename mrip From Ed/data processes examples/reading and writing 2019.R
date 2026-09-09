# Initial attempt at building a single csv for ALL STATES from which Florida can be subsetted later


rm(list=ls())

library(data.table)
library(bit64)
library(Hmisc)
library(dplyr)

	# Create a list of the files you want to read in
		setwd("U:/UF/Data/NMFS/MRIP data/MRIP/CSVs/raw/2019/trips") #for whatever reason, it seems that you must re-direct the WD...not sure why
		all.files <- list.files(path = "U:/UF/Data/NMFS/MRIP data/MRIP/CSVs/raw/2019/trips", pattern = ".csv") #this is a test trips from 2018--watch for cap changes with other years
	
	#This is if you are want ALL the columns
		l <- lapply(all.files, fread, sep=",") #read them all in using fread

			#so there can be some issues with the data: colName capitalization changes, variables change, and colClass changes.
			#	the following deals with the issues. 
			for(i in 1:length(l)) {					
				names(l[[i]]) <- tolower(names(l[[i]]))  #changing all the names to lowercase so that you avoid potential conflicts
				l[[i]] <- l[[i]][,list(prim2_common, prim1_common, strat_id, psu_id, year, reg_res, st_res, cnty_res, st, #subsetting the columns you care about
					cnty, intsite , mode_f, mode_fx, area, area_x, hrsf, add_hrs, id_code, sub_reg, wave, catch, 
					boat_hrs, month, kod, county, time, wp_int, var_id, leader)]
				l[[i]] <- l[[i]][, id_code:=as.character(id_code)]		#coercing some columns to character
				l[[i]] <- l[[i]][, leader:=as.character(leader)]

				}


		dt <- rbindlist(l, use.names=TRUE, fill=TRUE)  #this is the data table for all the states

		dt_fl <- dt[st=="12",]									#this is the data table for only Florida

	#Writing out data
		setwd("U:/UF/Data/NMFS/MRIP data/MRIP/processed files/Rdata_files");
		save(dt, file = "All_2019.RData")
		save(dt_fl, file = "FL_2019.RData")

		