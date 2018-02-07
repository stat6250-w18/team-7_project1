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


* load external file that generates analytic dataset public_school_dataset;
%include ".\stat6250-01_w18-team-7_project1_data_preparation.sas";



title1
'Research Question: What are the top five school districts with the most school closings?'
;

title2
'Rationale: This would help to find the factors of low enrollment.'
;

footnote1
'Based on the above output,we can find top five districts with the most change.'
;

*
Methodology: use PROC SORT to count the numbers of close schools in each school 
districts, and use PROC PRINT to get variables what I need.

Limitations: This methodology does not account for observations with missing 
values.

Follow-up Setps: other statistical methods are necessary.  
;

proc freq 
        data=school_analysis order=freq 
	;
        table NCESDist / out=school_analysis_NCESDist 
	;
run;
title;
footnote;




title1
'Research Question: Which county has the most change in open, closed or merged schools?'
;

title2
'Rationale: This would help to show the trend of the enrollment.'
;

footnote1
"Based on the data analysis, it is difficult to draw conclusion that which factor caused the school's enrollment."
;

footnote2
'But we know that the enrollment is dependent on social situations.'
;

*
Methodology: use PROC FREQ to count open, closed or merged schools in every county 
predicting the trend of enrollment.

Limitations: the PROC freq only display a table.

Follow-up Setps: use separatly SORT and FREQ statements to display variables what 
you need.
;

proc freq 
        data=school_analysis order=freq
    ;
        tables county / out=school_analysis_countyfreq
    ;
run;
title;
footnote;




title1
'Research Question: Can the closure, open and merge of schools predict local demographic 
structure and economic status change?'
;

title2
'Rationale: This would help to analyze what factors influence the enrollment.'
;

footnote1
'Based on output, these five counties,Los Angeles,San Diego,Orange,San Bernardino, and Santa Clara, have the most open, closed, and merged schools.'
;

footnote2
'So we may draw a conclusion that enrollment is related to local demographic structure and economic status change.' 
;

footnote3
'Also, We may predict the future enrollment by using more effective statistics and data analysis.'
;

*
Methodology: use PROC FREQ to count open, closed or merged schools in every county 
predicting the trend of enrollment.

Limitations: the PROC freq only display a table.

Follow-up Setps: use separatly SORT and FREQ statements to display variables what 
you need.
;

proc print 
        data=school_analysis_countyfreq (obs=10)
    ;
run;
title;
footnote;


