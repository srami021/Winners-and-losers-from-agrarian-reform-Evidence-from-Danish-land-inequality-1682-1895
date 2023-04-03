use "C:\Users\ninaboberg\Dropbox\Danish land inequality\Stata data\replication package\WinnersandLosers_finaldata.dta", clear


keep ID Pop_* ln_area AreaSogn LnDistCPH Lat Long LnDistCoast region ln_TotalFarmHK  MLmean fertility* pop_birthamt_1850 migrated_1850 migrated_popshare 
rename AreaSogn AreaSogn_1769
rename ln_area ln_area_1769 
rename LnDistCPH LnDistCPH_1769
rename Lat Lat_1769
rename Long Long_1769
rename LnDistCoast LnDistCoast_1769
rename region region_1769
rename ln_TotalFarmHK ln_TotalFarmHK_1769
rename MLmean MLmean_1769

duplicates drop ID, force

reshape long Pop_ ln_area_ AreaSogn_ LnDistCPH_ Lat_ Long_ LnDistCoast_ region_ ln_TotalFarmHK_  MLmean_ , i(ID) j(year)

sort ID
foreach x in ln_area_ AreaSogn_ LnDistCPH_ Lat_ Long_ LnDistCoast_ region_ ln_TotalFarmHK_  MLmean_  {
  forvalues i=1/10 {
	replace `x'=`x'[_n-`i'] if `x'==. & `x'[_n-`i']!=. & ID==ID[_n-`i'] 
	}
	forvalues i=1/10 {
	replace `x'=`x'[_n+`i'] if `x'==. & `x'[_n+`i']!=. & ID==ID[_n+`i']   
	}
}

gen popdensity = Pop_/AreaSogn

gen year_1 = 1 if year==1769
	replace year_1 = 2 if year==1787
	replace year_1 = 3 if year==1801
	replace year_1 = 4 if year==1834
	replace year_1 = 5 if year==1840
	replace year_1 = 6 if year==1845
	replace year_1 = 7 if year==1850
	replace year_1 = 8 if year==1855
	replace year_1 = 9 if year==1860
	replace year_1 = 10 if year==1870
	replace year_1 = 11 if year==1880
	replace year_1 = 12 if year==1890
	replace year_1 = 13 if year==1901
	replace year_1 = 14 if year==1906
	replace year_1 = 15 if year==1911
	
label define years 1 "1769" 2 "1787" 3 "1801" 4 "1834" 5 "1840" 6 "1845" 7 "1850" 8 "1855" 9 "1860" 10 "1870" 11 "1880" 12 "1890" 13 "1901" 14 "1906" 15 "1911" 
label values year_1 years

xtset ID year_1

forvalues x = 1/15 {
	gen D`x'popdensity = popdensity - popdensity[_n-`x'] if ID==ID[_n-`x'] 
}

gen ln_pop = ln(Pop_)

forvalues x = 1/15 {
	gen D`x'lnpop = ln_pop - ln_pop[_n-`x'] if ID==ID[_n-`x'] 
}

gen Pop_1769=Pop_ if year_1==1
forvalues x = 1/15 {
	replace Pop_1769 = Pop_1769[_n-`x'] if ID==ID[_n-`x'] 
}


***Figure 6: estimations underlying figure***
eststo clear
forvalues x = 1/12 {
	eststo iv`x': qui ivregress 2sls D`x'lnpop ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year_1==`x'+1 , vce(robust)		
	estat firststage
	mat fstat = r(singleresults)
	estadd scalar Fstat = fstat[1,4] 
	}
	
esttab iv*, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(12) wrap keep(ln_TotalFarmHK*) mtitles("1769/1787" "1769/1801" "1769/1834" "1769/1840" "1769/1845" "1769/1850" "1769/1855" "1769/1860" "1769/1870" "1769/1880" "1769/1890" "1769/1901") stats(N, labels("Observations") fmt(%9.0fc)) indicate("Region FE = 2.region*" "Geography = LnDistCPH*" , labels(Y N)) label


**fertility vs. migration**
gen fertility = fertility_1787 if year==1787
	replace fertility = fertility_1801 if year==1801
	replace fertility = fertility_1834 if year==1834
	replace fertility = fertility_1850 if year==1850
	
gen ln_fertility = ln(fertility)

gen ln_popdensity = ln(popdensity)

gen ln_migrated = ln(migrated_popshare)
	
gen year_2 = 1 if year==1787
	replace year_2 = 2 if year==1801
	replace year_2 = 3 if year==1834
	replace year_2 = 4 if year==1850
	replace year_2 = 5 if year==1870
keep if year_2!=.

tempvar q
bysort ID: gen `q' = [_N]
gen byte balanced3 = 0
replace balanced3 = 1 if `q'==5
drop if balanced3==0
drop balanced3
bysort ID: egen koo = count(ln_fertility)
bysort ID: egen foo = count(ln_pop)
bysort ID: egen roo = count(ln_migrated)

gen byte balanced3 = 0
replace balanced3 = 1 if koo==4 & foo==5 & roo==5

tab balanced3
drop if balanced3==0
drop koo foo roo

xtset ID year_2

*Part of Table A1*
sum fertility* migrated_popshare if year==1850


*Table 2*
eststo clear
eststo mech1: reg ln_pop L.ln_fertility ln_area LnDistCPH Lat Long LnDistCoast i.region i.year_2, vce(clust ID)
eststo mech3: reg ln_pop L.ln_fertility ln_area LnDistCPH Lat Long LnDistCoast i.region if year==1870, vce(robust)
eststo mech4: reg ln_pop L.ln_migrated ln_area LnDistCPH Lat Long LnDistCoast i.region if year==1870, vce(robust)
eststo mech5: reg ln_pop L.ln_fertility L.ln_migrated ln_area LnDistCPH Lat Long LnDistCoast i.region if year==1870, vce(robust)

esttab mech*, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(11) wrap stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc 2 2)) keep(*ln_fertility *ln_migrated) mtitles("1787-1850, levels" "1870" "1870" "1870") indicate("Year FE = 3.year_2" "Region FE = 1.region_" "Geography = LnDistCPH_" , labels(Y N)) label
		

