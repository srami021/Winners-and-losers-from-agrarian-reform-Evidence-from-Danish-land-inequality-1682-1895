***Table A6***

tab region, gen(nregion)

eststo clear
eststo fiv1: ols_spatial_HAC ln_TotalFarmHK MLmean ln_area LnDistCPH LnDistCoast Lat Long nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(10) lag(1) 
predict ln_TotalFarmHK_hat
label var ln_TotalFarmHK_hat ln_TotalFarmHK

eststo spatial1: ols_spatial_HAC D.Theil_c ln_TotalFarmHK_hat ln_area LnDistCPH Lat Long LnDistCoast nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(10) lag(1)

drop ln_TotalFarmHK_hat
eststo fiv2: ols_spatial_HAC ln_TotalFarmHK MLmean ln_area LnDistCPH Lat Long LnDistCoast  nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(25) lag(1)
predict ln_TotalFarmHK_hat
label var ln_TotalFarmHK_hat ln_TotalFarmHK

eststo spatial2: ols_spatial_HAC D.Theil_c ln_TotalFarmHK_hat ln_area LnDistCPH Lat Long LnDistCoast nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(25) lag(1)

drop ln_TotalFarmHK_hat
eststo fiv3: ols_spatial_HAC ln_TotalFarmHK MLmean ln_area LnDistCPH Lat Long LnDistCoast nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(50) lag(1)
predict ln_TotalFarmHK_hat
label var ln_TotalFarmHK_hat ln_TotalFarmHK

eststo spatial3: ols_spatial_HAC D.Theil_c ln_TotalFarmHK_hat ln_area LnDistCPH Lat Long LnDistCoast nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(50) lag(1)

drop ln_TotalFarmHK_hat 
eststo fiv4: ols_spatial_HAC ln_TotalFarmHK MLmean ln_area LnDistCPH Lat Long LnDistCoast nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(100) lag(1)
predict ln_TotalFarmHK_hat
label var ln_TotalFarmHK_hat ln_TotalFarmHK

eststo spatial4: ols_spatial_HAC D.Theil_c ln_TotalFarmHK_hat ln_area LnDistCPH Lat Long LnDistCoast nregion2 nregion3 nregion4 if year==1834, lat(Lat) lon(Long) timevar(year_1) panelvar(ID) dist(100) lag(1)

drop ln_TotalFarmHK_hat 
	
esttab spatial1 spatial2 spatial3 spatial4, se star(* 0.10 ** 0.05 *** 0.01) b(3) r2 var(25) model(13) wrap stats(N, labels("Observations") fmt(%9.0fc %9.0fc 2)) mtitles("10km" "25km" "50km" "100km") keep(ln_TotalFarmHK_hat) 	indicate("Region FE = nregion2" "Geography = LnDistCPH" , labels(Y N)) label	
		