***Figure 11***

**Panel (a)**
reg taxpayers_farms1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870 & taxpayers_farms1870<=10, vce(robust) 
avplot LTheil, msize(tiny) graphr(c(white)) ylab( , nogrid)
	
**Panel (b)**	
reg taxableincome_farms1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870 & taxableincome_farms1870<=20000, vce(robust) 
avplot LTheil, msize(tiny) graphr(c(white)) ylab( , nogrid)

**Panel (c)**
reg taxbytaxpayers_farms1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870 & taxbytaxpayers_farms1870<=10, vce(robust) 
avplot LTheil, msize(tiny) graphr(c(white)) ylab( , nogrid)