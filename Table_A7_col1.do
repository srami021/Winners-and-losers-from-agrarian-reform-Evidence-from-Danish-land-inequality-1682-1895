
***Table A7 column (1)***
eststo emig1: reg LnTotalEmigration L.Theil_c ln_area LnDistCPH Lat Long LnDistCoast i.region if year_1==5, vce(robust) 

esttab emig1, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(15) model(16) wrap keep(L.Theil_c) mtitles("ln(TotalEmigration)") stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc 2)) indicate("Region FE = 1.region" "Geography = LnDistCPH" , labels(Y N)) label