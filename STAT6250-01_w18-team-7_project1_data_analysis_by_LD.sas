*******************************************************************************;

**************** 80-character banner for column width reference ***************;

* (set window width to banner width to calibrate line length to 80 characters *;

*******************************************************************************;


*
This file uses the following analytic dataset to address three research questions 
regarding all active, pending, closed, and merged public schools and districts in 
California.
Dataset Name: public_raw created in external file 
stat6250-01_w18-team-7_project1_data_preparation.sas, which is assured to be in
the same directory as this file.

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);

X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset public_raw;
%include ".\stat6250-01_w18-team-7_project1_data_preparation.sas";

*
Build analytic dataset from pubschls dataset with the leastcolumns and minimal
cleaning/transformation neededto analyze research queations in corresponding 
data analysis files
;


data public_raw;
    retain
        CDSCode
        NCESDist
        StatusType
        county
        OpenDate
        ClosedDate
    ;
    keep
        CDSCode
        NCESDist
        StatusType
        county
        OpenDate
        ClosedDate
	;
	set public_raw;
run;



PROC print data=public_raw;
    var CDSCode County StatusType openDate closedDate;
    
run;


*
The variable openDate is in wrong date format, useing FORMAT statement to 
recover the date.(tried many times. I didn't know how the new variable can 
replace the original openDate variable.)
;

Data SAS_openDate;
    Set public_raw;
    Format S_date mmddyy10.;
    S_date = OpenDate - 21916;
	
run;

title 'Opendate converted from Excel To SAS Format';

PROC print data=SAS_openDate;
    var CDSCode County StatusType S_date closedDate;
    

run;

*
Research Question: What are the top five school districts with the most school 
closings?

Rationale: This would help to find the factors of low enrollment.

Methodology: use PROC SORT to count the numbers of close schools in each school 
districts, and use PROC PRINT to get variables what I need.

Limitations: This methodology does not account for observations with missing 
values.

Follow-up Setps: other statistical methods are necessary.  

;

PROC sort data=public_raw out=sorted;
    by CDSCode County StatusType openDate closedDate;
run;

title 'Data from file public_raw';

PROC print data=sorted;
    var CDSCode County StatusType openDate closedDate;
run;

PROC sort data=sorted out=sorted_StatusType;
    by StatusType;

title 'Data from file sorted';

PROC print data=sorted_StatusType;
run;

*
Research Question: Which county has the most change in open, closed or merged schools?

Rationale: This would help to show the trend of the enrollment.

Methodology: use PROC FREQ to count open, closed or merged schools in every county 
predicting the trend of enrollment.

Limitations: the PROC freq only display a table.

Follow-up Setps: use separatly SORT and FREQ statements to display variables what 
you need.

;

PROC freq data=sorted;
    tables county / out=countyfreq;

PROC sort data=countyfreq out=sorted_countyfreq;
    by descending count;
run;

data want;
    set countyfreq;
	cumcount + count;
	cumpercent + percent;
run;

title 'Data from file countyfreq';
footnote 'County statustype frequency';

PROC print data=sorted_countyfreq;
run;

*

Analysis: these five counties,Los Angeles,San Diego,Orange,San Bernardino, and
Santa Clara, have the most open, closed, and merged schools. So we may draw a
conclusion that enrollment is related to local demographic structure and economic 
status change. Also, We may predict the future enrollment by using more effective 
statistics and data analysis.

;
