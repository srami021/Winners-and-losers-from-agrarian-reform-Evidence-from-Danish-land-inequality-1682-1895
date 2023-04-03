cd "C:\Users\ninaboberg\Dropbox\Danish land inequality\Stata data\replication package\"

use "WinnersandLosers_finaldata.dta", clear

*Tables in main text*
do "Table_1.do"
do "Fig6andTable2.do"
do "Table_3.do"

*Figures in main text*
do "Figure_5.do"
do "Figure_6.do"
do "Figure_7.do"
do "Figure_9.do"

*Appendix*
do "Table_A1.do"
do "Figure_A2.do"
do "Table_A3.do"
do "Table_A4.do"
do "Table_A5.do"
do "Table_A6.do"
do "Table_A7_col1.do"


use "WinnersandLosers_taxdata.dta", clear

do "Figure_11.do"
do "Table_A1_tax.do"
do "Figure_A4.do"
do "Table_A7_cols2to4.do"















		


		



	

	

	

	
	
	
	




