
***Table A1 - Summary statistics***

sum TotalFarmHK1682 TotalFarmHK1834 TotalFarmHK1850 TotalFarmHK1860 TotalFarmHK1873 TotalFarmHK1885 TotalFarmHK1895 TotalFarmNr1682_c TotalFarmNr1834_c TotalFarmNr1850_c TotalFarmNr1860_c TotalFarmNr1873_c TotalFarmNr1885_c TotalFarmNr1895_c if Theil_1834c!=.

sum Theil_*c gini* Pop_1769 Pop_1834 Pop_1850 Pop_1860 Pop_1870 Pop_1880 Pop_1890 fertility_* migrated_1850 if year==1850 & Theil_1834c!=.

sum Køer1837 SvinGr1837 total_seedings_fe1837 total_seedings_HK1837 total_seedings_kcal1837 if year==1834 & Theil_1834c!=. 

sum  køer Grise_ialt total_seedings_fe1861 total_seedings_HK1861 total_seedings_kcal1861 if year==1860 & Theil_1834c!=. 


sum BygLG MLmean AreaSogn DistCPH DistHamborg Lat Long DistCoast  if year==1850 & Theil_1834c!=.
sum TotalEmigration if year==1850 & Theil_1834c!=. 