*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Campus Closing at CA schools

Dataset Name: Public_raw created 
STAT6250-01_w18-team-7_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup; 

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file public_school_dataset;
%include '.\STAT6250-01_w18-team-7_project1_data_preparation.sas';





title1
'Research Question: What is number of the four status for each type of education?'
;

title2
'Rationale: This should help identify which type of education has the highest frequency of closing, which encourages more investiagtions on the highest closing frequency school' 
;

footnote1
'According to the result, traditional schools have the highest number of closing, which is around 4000. However, what is interesting is that the number of closing for Community Day school is higher than its active.'
;
*
Methodology: Use PROC FREQ to create a table that shows the number of each 
status for different types of education. 

Limitations: The table does not show the geographical distribution of where 
all these differenct schools locate. Some counties might tend to have higher
number of closing schools than others. Or some counties merged more school
than others.

Possible Follow-up Steps: To acheieve this goeal, I should gather up the 
information of county's closing number for different education types. 
;
proc freq data=Public_raw;
 	table EdOpsName*StatusType/missing list;
	format 
 		EdOpsName $Educational_Option_Type_bins.
		StatusType $status.;
run;
title;
footnote;




title1
'Research Question: Which county has the most closing frequency in Traditional and Community Day School (The two highest number of closing types of education)?'
;

title2
'Rationale: This should help identify which county needs more resources on maintaining school operations' 
;

footnote1
'According to the result, Los Angeles has the highest number of closing for traditional school, which is 222 and the number is three times higher than the second highest.'
;
footnote2
'Moreover, Los Angeles also has the highest number of closing for community day school. I think that there might be some esstential factors causing the relative high tendency of closing schools.'
;
*
Methodology: Use PROC FREQ to create a table that shows each county's number of
closed Traditional and Community Day schools. 

Limitations: It might be true that Los Angeles has higher number of closing 
schools than other country. However, it could be just due to relative higher of
schools in Los Angeles. The table does not show what the percentage of closing
schools is among all the schools in a specific county. 

Possible Follow-up Steps: To acheieve this goeal, I should calculate the total 
number of schools in each county and compute the percentage of closing schools. 
In this way, it is more objective to analyze if Los Angeles has the highest 
percentage of closing schools overall. 
;	
proc freq data=Public_raw order=freq;
 	table EdOpsName*County*StatusType/missing nocum;
 	where StatusType contains 'Closed' 
    and (EdOpsName  = 'Traditional' or EdOpsName ='Community Day School');
 	format 
 		EdOpsName $Educational_Option_Type_bins.;
run;
title;
footnote;





title1
'Research Question: Which period of time has the most closing frequency in Traditional and Community Day School in each county'
;

title2
'Rationale: Often we only pay more attention to issues that happened more recent. For school closing isssues, we should pay more attenetion to county that has higher frequency of closing schools in recent years.' 
;

footnote1
'According to the result, 2011-2015 has relative higher number of closing tradional and community day school. Los Angeles closed 94 traditioal schools in that period of time.';

footnote2
'However, from 2016 to 2018, Los Angeles closed 59 traditional shools in two years. It could be very interestig to dig ing more details on why this happened.'
;
*
Methodology: Use PROC FREQ to create a table to show each county's number of 
closed Traditional and Community Day schools in different periods of time?

Limitations: It does not show the duration of each school. Some schools might
have last hundreds of years.

Possible Follow-up Steps: I should subtract the OpenedDate and ClosedDate and 
compute how many days or months each school last. However, due to the difficulty
of reformatting the OpenedDate, I was not able to compute that. 
;
proc freq data=Public_raw order=freq;
 	table EdOpsName*ClosedDate*County/missing nocum;
 	where StatusType contains 'Closed' 
    and (EdOpsName  = 'Traditional' or EdOpsName ='Community Day School');
 	format 
 		EdOpsName $Educational_Option_Type_bins.
 		ClosedDate ClosedDate.;
run;
title;
footnote;


