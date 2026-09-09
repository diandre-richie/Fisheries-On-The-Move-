# Purpose of this code is to test reading in Rdata and then concatenating to other data


rm(list=ls())

library(data.table)
library(bit64)
library(Hmisc)
library(dplyr)

	#Read in old data
	setwd("U:/UF/Data/NMFS/MRIP data/MRIP/processed files/Rdata_files")
		load("FL_2000_2004.RData")
			fl_2000_2004 <- dt_fl
		load("FL_2005_2009.RData")
			fl_2005_2009 <- dt_fl
		load("FL_2010_2014.RData")
			fl_2010_2014 <- dt_fl
		load("FL_2015_2017.RData")
			fl_2015_2017 <- dt_fl
		load("FL_2018.RData")
			fl_2018 <- dt_fl
		load("FL_2019.RData")
			fl_2019 <- dt_fl
		load("FL_2020.RData")
			fl_2020 <- dt_fl
		load("FL_2021.RData")
			fl_2021 <- dt_fl
		load("FL_2022.RData")
			fl_2022 <- dt_fl
		load("FL_2023.RData")
			fl_2023 <- dt_fl
		load("FL_2024.RData")
			fl_2024 <- dt_fl
		load("FL_2025.RData")
			fl_2025 <- dt_fl

	#Combining all files
		fl_2000_2025 <- rbind(fl_2000_2004, fl_2005_2009, fl_2010_2014, fl_2015_2017, fl_2018, fl_2019, fl_2020, fl_2021, fl_2022, fl_2023, fl_2024, fl_2025)

	#Writing Rdata file
		setwd("U:/UF/Data/NMFS/MRIP data/MRIP/processed files/Rdata_files");
		save(fl_2000_2025, file = "fl_2000_2025.RData")

	#Writing csv file
		setwd("U:/UF/Data/NMFS/MRIP data/MRIP/processed files/csv_files"); 
 		write.csv(fl_2000_2025, file = "fl_2000_2025.csv", row.names=FALSE)

