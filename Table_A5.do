		
***Table A5***
eststo clear
eststo ols1: qui reg D.Theil_c barleysuit ln_area LnDistCPH Lat Long LnDistCoast i.region if year==1834, vce(robust)

eststo ols2: qui reg D.AggTheil_c barleysuit ln_area LnDistCPH Lat Long LnDistCoast i.region i.year if year==1834, vce(robust)

eststo fiv1: qui reg barleysuit MLmean ln_area LnDistCPH Lat Long LnDistCoast i.region if year==1834 & ln_TotalFarmHK!=., vce(robust)
	
eststo ivdiff1: qui ivregress 2sls D.Theil_c ln_area LnDistCPH Lat Long LnDistCoast i.region (barleysuit = MLmean) if year==1834, vce(robust)
	estat firststage
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
eststo ivdiff2: qui ivregress 2sls D.AggTheil_c ln_area LnDistCPH Lat Long LnDistCoast i.region (barleysuit = MLmean) if year==1834, vce(robust)
	estat firststage
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
esttab ols1 fiv1 ivdiff1 ivdiff2, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(11) wrap keep(MLmean barleysuit) mtitles("OLS" "first stage" "second stage (diffTheil)" "second stage (diffAggTheil)") stats(N r2 Fstat, labels("Observations" "R-squared" "KP F-statistic") fmt(%9.0fc 2 2)) indicate("Region FE = 2.region" "Geography = LnDistCPH" , labels(Y N)) label
	
