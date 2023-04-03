
***Figure A4***

**Panel (a)**	
reg taxpayers_pop1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870, vce(robust) 
avplot LTheil, msize(vsmall) graphr(c(white)) ylab( , nogrid)

**Panel (b)**
reg taxableincome_pop1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870, vce(robust) 
avplot LTheil, msize(vsmall) graphr(c(white)) ylab( , nogrid)

**Panel (c)**
reg taxbytaxpayers_pop1870 LTheil ln_area LnDistCPH Lat Long LnDistCoast i.Region if year==1870, vce(robust) 
avplot LTheil, msize(vsmall) graphr(c(white)) ylab( , nogrid)