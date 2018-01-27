*******************************************************************************;

**************** 80-character banner for column width reference ***************;

* (set window width to banner width to calibrate line length to 80 characters *;

*******************************************************************************;

*

This file prepares the dataset described below for analysis.

[Dataset Name] Public Schools and Districts Data Files

[Experimental Units] California public schools

[Number of Observations] 17,813

[Number of Features] 49

[Data Source] https://www.cde.ca.gov/ds/si/ds/pubschls.asp

The dataset was obtained from California department of education. It is dynamically

driven and reflect real-time data,

and contains all active, pending, closed, and merged public schools and districts.

[Data Dictionary] https://www.cde.ca.gov/schooldirectory/report?rid=dl1&tp=xlsx

[Unique ID Schema] The column "CDSCode" is a primary key.

;

* setup environmental parameters;

%let inputDatasetURL =
https://github.com/ldai4-stat6250/hello-world/blob/master/pubschls1.xlsx?raw=true
;

* load raw pubschls dataset over the wire;
filename LD_file "temp.xlsx";
proc http
    method="get"
	url="&inputDatasetURL."
	out= LD_file
	;
run;
proc import
    file=LD_file
	out=WORK.LD_sample
	DBMS=xlsx REPLACE;

	
run;
filename LD_file clear;

* check raw pubschls dataset for duplicates with respect to its composite key;
proc sort data=LD_sample out=pubschls_raw;
    by CDSCode NCESDist;
run;

*build analytic dataset from pubschls datasetwith the leastcolumns and minimal
cleaning/transformation neededto analyze research queations in corresponding data
-analysis files;
data pubschls_analytic_file;
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
	set pubschls_raw;
run;


