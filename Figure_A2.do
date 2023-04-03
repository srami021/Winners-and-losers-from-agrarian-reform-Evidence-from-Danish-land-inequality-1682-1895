
***Figure A2***

***Panel (a)***
xtset ID year_1
gen DTheil_c = D.Theil_c			 
*save 1834 distribution of Theil*
preserve
	keep if year==1834	
	keep DTheil_c 
	gen ranid=_n
	rename DTheil_c RandomDTheil_c
	gen year=1834
	count
	save "DTheil1834.dta", replace
restore

putexcel set "Betas10000.xlsx", modify

set more off

forval k=1(1)10000{

preserve

     gen RandomNumb = runiform() if year==1834
     sort RandomNumb
	 gen ranid=_n if year==1834
		replace ranid=_n+5000 if ranid==.
     merge 1:1 ranid year using "DTheil1834.dta"
	 drop if _merge==2
	 sort ID year
	 forvalues i=1/10 {
		replace RandomDTheil_c=RandomDTheil_c[_n-`i'] if RandomDTheil_c==. & RandomDTheil_c[_n-`i']!=. & ID==ID[_n-`i'] 
	 }
	 forvalues i=1/10 {
		replace RandomDTheil_c=RandomDTheil_c[_n+`i'] if RandomDTheil_c==. & RandomDTheil_c[_n+`i']!=. & ID==ID[_n+`i'] 
	 }
	 
	ivregress 2sls RandomDTheil_c ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = MLmean) if year==1834, vce(robust)

     mat beta=r(table)
     scalar b=beta[1,1]
     scalar tval=beta[3,1]
                     
     putexcel A`k'=(b) B`k'=(tval) 

restore
}

*generate figure*
clear
import excel using "betas10000.xlsx", first
rename B tvalue
label var tvalue "t-value" 
hist tvalue, norm bin(90) xscale(r(-4 6)) addplot(pci 0 4.01 0.34 4.01, lc(red)) text(0.36 4.01 "estimated t-value") graphregion(color(white)) bgcolor(white) ylab( ,nogrid) xlab(-4(2)6) col(gs8) normop(lc(gs4)) leg(off)

	
***Panel (b)***
preserve
	keep if year==1834	
	keep ln_TotalFarmHK 
	gen ranid=_n
	rename ln_TotalFarmHK ln_RandomTotalFarmHK
	gen year=1834
	count
	save "TotalHK1834.dta", replace
restore

putexcel set "Betas10000TotalHK.xlsx", modify

set more off

forval k=1(1)10000{

preserve

     gen RandomNumb = runiform() if year==1834
     sort RandomNumb
	 gen ranid=_n if year==1834
		replace ranid=_n+5000 if ranid==.
     merge 1:1 ranid year using "TotalHK1834.dta"
	 drop if _merge==2
	 sort ID year
	 forvalues i=1/10 {
		replace ln_RandomTotalFarmHK=ln_RandomTotalFarmHK[_n-`i'] if ln_RandomTotalFarmHK==. & ln_RandomTotalFarmHK[_n-`i']!=. & ID==ID[_n-`i'] 
	 }
	 forvalues i=1/10 {
		replace ln_RandomTotalFarmHK=ln_RandomTotalFarmHK[_n+`i'] if ln_RandomTotalFarmHK==. & ln_RandomTotalFarmHK[_n+`i']!=. & ID==ID[_n+`i'] 
	 }
	 
ivregress 2sls DTheil_c ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_RandomTotalFarmHK = MLmean) if year==1834 & balanced==1 & dropit==0, vce(robust)
     mat beta=r(table)
     scalar b=beta[1,1]
     scalar tval=beta[3,1]
                     
     putexcel A`k'=(b) B`k'=(tval) 

restore
}

*generate figure*
clear
import excel using "betas10000TotalHK.xlsx", first
rename B tvalue
label var tvalue "t-value"
hist tvalue, norm bin(90) xscale(r(-4 6)) addplot(pci 0 4.01 0.4 4.01, lc(red)) text(0.43 4.01 "estimated t-value") graphregion(color(white)) bgcolor(white) ylab( ,nogrid) xlab(-4(2)6) col(gs8) normop(lc(gs4)) leg(off)
	
	
***Panel (c)***
preserve
	keep if year==1834	
	keep MLmean 
	gen ranid=_n
	rename MLmean RandomMLmean
	gen year=1834
	count
	save "MLmean1834.dta", replace
restore

putexcel set "Betas10000MLmean.xlsx", modify

set more off

forval k=1(1)10000{

preserve

     gen RandomNumb = runiform() if year==1834
     sort RandomNumb
	 gen ranid=_n if year==1834
		replace ranid=_n+5000 if ranid==.
     merge 1:1 ranid year using "MLmean1834.dta"
	 drop if _merge==2
	 sort ID year
	 forvalues i=1/10 {
		replace RandomMLmean=RandomMLmean[_n-`i'] if RandomMLmean==. & RandomMLmean[_n-`i']!=. & ID==ID[_n-`i'] 
	 }
	 forvalues i=1/10 {
		replace RandomMLmean=RandomMLmean[_n+`i'] if RandomMLmean==. & RandomMLmean[_n+`i']!=. & ID==ID[_n+`i'] 
	 }
	 
	ivregress 2sls DTheil_c ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK = RandomMLmean) if year==1834, vce(robust)

     mat beta=r(table)
     scalar b=beta[1,1]
     scalar tval=beta[3,1]
                     
     putexcel A`k'=(b) B`k'=(tval) 

restore
}

*generate figure*
clear
import excel using "betas10000MLmean.xlsx", first
rename B tvalue
label var tvalue "t-value"
hist tvalue, norm bin(90) addplot(pci 0 4.01 0.72 4.01, lc(red)) text(0.76 4.01 "estimated t-value") graphregion(color(white)) bgcolor(white) ylab( ,nogrid) xlab(-4(2)6) col(gs8) normop(lc(gs4)) leg(off)