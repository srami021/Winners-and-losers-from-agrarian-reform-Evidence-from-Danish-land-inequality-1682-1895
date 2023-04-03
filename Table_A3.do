
***Table A3***
eststo clear
foreach x in 1682 1834 {
	eststo ginihk`x': ivregress 2sls gini`x' ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year==`x' & gini1834!=., vce(clust ID)
	estat firststage
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
}

esttab ginihk1682 ginihk1834, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(11) wrap keep(ln_TotalFarmHK) mtitles("2nd stage: Gini diff" "2nd stage: gini 1682" "2nd stage: gini 1834") stats(N r2 Fstat, labels("Observations" "R-squared" "KP F-statistic") fmt(%9.0fc 2 2)) indicate("Region FE = 2.region" "Geography = LnDistCPH" , labels(Y N)) label