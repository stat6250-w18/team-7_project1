
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding pending, active, closed and merged Campus at CA schools.

Dataset Name: Public_raw created 
STAT6250-01_w18-team-7_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup; 

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates public_school_dataset.xls;
%include '.\STAT6250-01_w18-team-7_project1_data_preparation.sas';



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
'Further analysis to look for the very first CODScode with Schools and Street and how far between them.'
;
*
Methodology: Use PROC FRINT to create a table that shows what are the lowest ten
CODScode of School and where are they loacted in Street.

Limitations: The table does not show the geographical distribution of where all
these differenct schools locate.

Possible Follow-up Steps: To acheieve this goeal, I should gather up the 
information of the very first twenty address, city, zipcode of schools.
;
proc print
        noobs
        data=Public_raw(obs=10)
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
title;
footnote;



title1
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

*
Methodology: Use PROC PRINT to create a table that shows the very first twenty 
address, city, zipcode of school. 

Limitations: In the very first twenty address, city, zipcode of schools, I found 
that Hayward is the place where I want to investigate more detail. 

Possible Follow-up Steps: To acheieve this goeal, I should do the search that 
how many schools loacated in Hayward with lowest SOC to highest.
;	
proc print
        data=Public_raw(obs=20)
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
run;
title;
footnote;



title1
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
*
Methodology: Use PROC PRINT to create a table that shows how many school located
in Hayward with the lowest SOC to highest. 

Limitations: It might be true that Hayward is the place where I concerned about
it and it has higher number of closing schools than other place in North 
Californa. Nevetheless, I should focus on others places rather than only Hayward.

Possible Follow-up Steps: To acheieve this goeal, I should located more place
rather than only Hayward even if it has higher number of closing school in 
California.
;	
proc print
         data=Public_raw noobs
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
run;
title;
footnote;
