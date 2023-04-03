
***Figure 5***

eststo clear	
foreach x in 1682 1834 1850 1860 1873 1885 1895 {
    qui ivregress 2sls ln_Theil_`x'c ln_area LnDistCPH Lat Long LnDistCoast i.region (ln_TotalFarmHK`x' = MLmean) if year==`x', vce(clust ID)
	estimates store coef`x' 
}		
	coefplot coef*, vert yline(0) keep(ln_TotalFarmHK*) graphregion(color(white)) ciopts(recast(rcap) lcol(black)) mcolor(black) ///
	xtick(1(1)7) xlabel(1 "1682" 2 "1834" 3 "1850" 4 "1860" 5 "1873" 6 "1885" 7 "1895", ) grid(b) legend(off)
	