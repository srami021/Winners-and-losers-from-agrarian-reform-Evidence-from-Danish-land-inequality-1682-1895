
***Table A7 - columns (3)-(4)***

eststo clear
eststo tax1: reg taxpayers_farms1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870 , vce(robust) 
	
eststo tax2: reg taxableincome_farms1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870, vce(robust) 
	
eststo tax3: reg taxbytaxpayers_farms1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870, vce(robust) 

esttab tax*, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(16) wrap keep(LTheil) mtitles("taxpayers/\# farms" "avrg.tax/ \# farms" "taxable income/ \# farms") stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc 2)) indicate("Region FE = 1.Region" "Geography = LnDistCPH" , labels(Y N)) label 	
	