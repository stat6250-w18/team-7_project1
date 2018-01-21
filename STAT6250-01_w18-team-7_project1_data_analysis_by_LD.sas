******************************************************************************************;
*****************80-characters banner for colmn width reference***************************;
** (set window width to banner width to calibrate line length to 80 characters) **********;
******************************************************************************************;

*
This file uses the following analytic dataset to address three research questions regarding 
all active, pending, closed, and merged public schools and districts in California.
Dataset Name: pubschls_analytic_file created in external file 
stat6250-01_w18-team-7_project1_data_preparation.sas, which is assured to be in the 
same directory as this file.

See included fikle for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;

X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset pubschls_analytic_file;
%include ".\stat6250-01_w18-team-7_project1_data_preparation.sas";


*
Research Question: What are the top five school districts with the most school 
closings or openings?

Rationale: This would help to find the factors of low or high enrollment.

Methodology: use PROC SORT

Limitations:

Follow-up Setps:

;

PROC SORT data=pubschls_analytic_file out=sorted;
    by NCESDist StatusType County;
run;

PROC print data=sorted;
    var NCESDist StatusType County;
run;

Research Question: Which year has the most change in open, closed or merged schools?

Rationale: This would help to show the trend of the enrollment.

Methodology:

Limitations:


Follow-up Setps:

;

PROC sort data=pubschls_analytic_file out=sorted
    by NCESDist StatusType openDate closedDate
run;
proc print date=sorted;
    var NCESDist StatusType openDate closedDate
run;


*
Research Question: Can the closure, open and merge of schools predict local demographic 
structure and economic status change? 

Rationale: This would help to analyze the relationship of schools and surrounding environment.

Methodology:

Limitations:

Follow-up Setps:

;

