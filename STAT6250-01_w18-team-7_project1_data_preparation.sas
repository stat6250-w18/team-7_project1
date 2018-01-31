*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset Name] Public Schools and Districts Data Files

[Experimental Units] California public schools

[Number of Observations] 17,813

[Number of Features] 49

[Data Source] https://www.cde.ca.gov/ds/si/ds/pubschls.asp
The dataset was obtained from California department of education. 
It is dynamically driven and reflect real-time data,
and contains all active, pending, closed, and merged public schools 
and districts.

[Data Dictionary] https://www.cde.ca.gov/schooldirectory/report?rid=dl1&tp=xlsx

[Unique ID Schema] The column "CDSCode" is a primary key.
;



* environmental setup;

*create out format;
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



*setup environmental parameters;
%let inputDatasetURL = 
https://github.com/stat6250/team-7_project1/blob/master/public_school_dataset.xls?raw=true
;


* load raw FRPM dataset over the wire;
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
    &inputDatasetURL.,
    xls
)

*
Build analytic dataset from pubschls dataset with the leastcolumns and minimal
cleaning/transformation neededto analyze research queations in corresponding 
data analysis files
;

data publicschool_analysis;
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
