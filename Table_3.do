
***Table 3***
eststo clear
eststo agri1: qui ivregress 2sls Dtotal_seedings_fe ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year==1682, vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
eststo agri2: qui ivregress 2sls Dtotal_seedings_HK ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year==1682, vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
eststo agri3: qui ivregress 2sls Dtotal_seedings_kcal ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year==1682, vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 	

eststo agri4: qui ivregress 2sls DlnCows ln_area LnDistCPH Lat Long LnDistCoast i.region butter_to_grain (ln_TotalFarmHK = MLmean) if year==1860 & lnPigs1837!=. & lnPigs1861!=., vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
eststo agri5: qui ivregress 2sls DlnCows lnCows1837 ln_area LnDistCPH Lat Long LnDistCoast i.region butter_to_grain (ln_TotalFarmHK = MLmean) if year==1860 & lnPigs1837!=. & lnPigs1861!=., vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
eststo agri6: qui ivregress 2sls DlnPigs ln_area LnDistCPH Lat Long LnDistCoast i.region butter_to_grain (ln_TotalFarmHK = MLmean) if year==1860, vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	
eststo agri7: qui ivregress 2sls DlnPigs lnPigs1837 ln_area LnDistCPH Lat Long LnDistCoast i.region butter_to_grain (ln_TotalFarmHK = MLmean) if year==1860, vce(robust) 
	estat firststage 
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
		
esttab agri*, se star(* 0.10 ** 0.05 *** 0.01) b(3)	r2 var(15) model(16) wrap keep(ln_TotalFarmHK lnPigs1837 lnCows1837 butter_to_grain) mtitles("D.seedings (FE)" "D.seedings (HK)" "D.seedings (kcal)" "D.lnCows" "D.lnCows" "D.lnPigs" "D.lnPigs") order(ln_TotalFarmHK lnCows1837 lnPigs1837 butter_to_grain) stats(N r2 Fstat, labels("Observations" "R-squared" "KP F-statistic") fmt(%9.0fc 2 2)) indicate("Region FE = 2.region" "Geography = LnDistCPH" , labels(Y N)) label