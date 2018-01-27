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


* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-01_w18-team-7_project1_data_preparation.sas';

%let inputDatasetURL =
https://github.com/stat6250/team-7_project1/blob/initial-buildout-of-data-prep/pubschls%20(1).xlsx.xls?raw=true
;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile TEMP;
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    public_raw,
    https://github.com/stat6250/team-7_project1/blob/initial-buildout-of-data-prep/pubschls%20(1).xlsx.xls?raw=true,
    xls
)
;

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
Methodology: Use PROC FREQ to create a table that shows the number of each status for 
different types of education. 

Limitations: The table does not show the geographical distribution of where all these differenct schools locate.
Some counties might tend to have higher number of closing schools than others. Or some counties merged more school than others.

Possible Follow-up Steps: To acheieve this goeal, I should gather up the information of county's closing number for different education types. 

;
proc format;
    value $Educational_Option_Type_bins
	 	"Alternative Schools of Choice"="Alternative Schools of Choice"
        "Community Day School"="Community Day School"
        "Continuation School"="Continuation School"
        "County Community School"="County Community School"
        "District Special Education Consortia School"="District Special Education Consortia School"
        "Home and Hospital"="Home and Hospital"
        "Juvenile Court School"="Juvenile Court School"
        "Opportunity School"="Opportunity School"
        "Special Education School"="Special Education School"
        "State Special School"="State Special School"
        "Youth Authority School"="Youth Authority School"
        other
        ="Traditional";
	value $status
	 	"Active"="Actice"
		"Closed"="Closed"
		"Pending"="Pending"
		"Merged"="Merged";
	value ClosedDate
	 	low-'30DEC1995'd=">20 years ago"
		'01JAN1996'd-'30DEC2000'd='1996-2000'
		'01JAN2001'd-'30DEC2005'd='2001-2005'
		'01JAN2006'd-'30DEC2010'd='2006-2010'
		'01JAN/2011'd-'30DEC2015'd='2011-2015'
		'01JAN2016'd-'30DEC2018'd='2016-2018';
run;
proc freq data=Public_raw;
 	table EdOpsName*StatusType/missing list;
	format 
 		EdOpsName $Educational_Option_Type_bins.
		StatusType $status.;
run;
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
'Moreover, Los Angeles also has the highes number of closing for community day school. I think that there might be some esstential factors causing the relative high tendency of closing schools.'
;
*
Methodology: Use PROC FREQ to create a table that shows each county's number of closed Traditional and Community Day schools. 

Limitations: It might be true that Los Angeles has higher number of closing schools than other country. However, it could be just due to 
relative higher of schools in Los Angeles. The table does not show what the percentage of closing schools is among all the schools in a specific county. 

Possible Follow-up Steps: To acheieve this goeal, I should calculate the total number of schools in each county and compute the percentage of closing schools. 
In this way, it is more objective to analyze if Los Angeles has the highest percentage of closing schools overall. 
;	
data Public_2;
    retain
        County
		EdOpsName
		StatusType
    ;
    keep
        County
		EdOpsName
		StatusType
    ;
    set Public_raw;
run;
proc freq data=Public_2 order=freq;
 	table EdOpsName*County*StatusType/missing nocum;
 	where StatusType contains 'Closed' and (EdOpsName  = 'Traditional' or EdOpsName ='Community Day School');
 	format 
 		EdOpsName $Educational_Option_Type_bins.;
run;
data Public_3;
    retain
	 	ClosedDate
        County
		EdOpsName
		StatusType
    ;
    keep
	 	ClosedDate
        County
		EdOpsName
		StatusType
    ;
    set Public_raw;
run;
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
Methodology: Use PROC FREQ to create a table to show each county's number of closed Traditional and Community Day schools in different periods of time?

Limitations: It does not show the duration of each school. Some schools might have last hundreds of years.

Possible Follow-up Steps: 

;
proc freq data=Public_3 order=freq;
 	table EdOpsName*ClosedDate*County/missing nocum;
 	where StatusType contains 'Closed' and (EdOpsName  = 'Traditional' or EdOpsName ='Community Day School');
 	format 
 		EdOpsName $Educational_Option_Type_bins.
 		ClosedDate ClosedDate.;
run;


