
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

PROC IMPORT OUT= UNIVERSITY
			
            DATAFILE= " C:\Users\qx2863\Desktop\pubschls.xlsx.xls "

            DBMS=EXCEL REPLACE;
title1
'Research Question: What are the lowest ten CODScode with School and Street?'
;

title2
'Rationale: This should help identify where are the School and Street in the lowest CODScode levels.'
;


footnote1
'Based on the above output, there are three schools located in the same county and two in the same street.'
;

footnote2
'Moreover, we can see that virtually all of the lowest 10 CODScode of school prepare to active, pending, closed, and merged.'
;

footnote3
'Further analysis to look for the very first CODScode with Schools and Street and how far between them. '
;

proc print
       
        data=UNIVERSITY(obs=10)
    ;
    id
        CDSCode
    ;
    var
        School
    ;
	var 
	    Street;
run;
title1;
footnote1;

proc print
       
        data=UNIVERSITY(obs=20)
		NOOBS
    ;
    id
		
		School
    ;
    var
        StreetAbr
    ;
	var 
	    Street

    ;
	var 
		City
	;
	var 
	   State
	;
	var 
		Zip
	;

title2
'Research Question: What are the very first twenty address, city, zipcode of school?'
;
title2
'Rationale: This should help identify where are the first twenty Schools located in the same area.'
;

footnote1
'Based on the above output, there are three schools located in the same county and two in the same street.'
;

footnote2
'Moreover, we can see that virtually there are six area of school prepare to active, pending, closed, and merged, whic are Hayward, Berkeley, Newark, Oakland, Waterford, and San Leandro'
;

footnote3
'Further analysis, there are six schools from Oakland, which is taking the most part of school in the very first twenty.'
;
run;
title2;
footnote2;
proc print
       
        data=UNIVERSITY noobs
    ;
	where City in ('Hayward');
    id
        School
    ;
	var City
	;
    var
        SOC
    ;



title3
'Research Question: How many school located in Hayward with the lowest SOC to highest?'
;
title2
'Rationale: This should help identify how many total school in Hayward.'
;

footnote1
'Based on the above output, there are all schools located in the Hayward and SOC scores ranges from 09 to 98.'
;

footnote2
'Moreover, we can see that the highest SOC score school is 98, which are Eden Area ROP and Hayward-Newhaven Rop/Roc.'
;

footnote3
'At the same time, we can see that three schools have same SOC score 10, whihc are Technical, Agricultural & Nat, Alameda County Community and Whiteford School (TMR). '
;
run;
title3;
footnote3;
