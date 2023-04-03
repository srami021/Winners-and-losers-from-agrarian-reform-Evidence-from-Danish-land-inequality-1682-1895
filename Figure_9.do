
***Figure 9: regressions underlying figure***

eststo clear
forvalues x = 1/6 {
eststo hsr`x': qui ivregress 2sls D`x'HouseShare_c ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year_1==`x'+1 , vce(robust)		
	estat firststage 
	}	
	
esttab hsr*, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(12) wrap keep(ln_TotalFarmHK) mtitles("1682/1834" "1682/1850" "1682/1860" "1682/1873" "1682/1885" "1682/1895") stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc 2 2)) indicate("Region FE = 2.region" "Geography = LnDistCPH" , labels(Y N)) label
	
***Figure 10 !!!corresponds to table A7 but not to figure in paper, same in published version???***
eststo emig1: reg LnTotalEmigration L.Theil_c ln_area LnDistCPH Lat Long LnDistCoast i.region if year_1==5, vce(robust) 

avplot L.Theil_c, msize(tiny) graphr(c(white)) ylab( , nogrid)