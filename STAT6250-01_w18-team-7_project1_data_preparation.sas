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

The dataset was obtained from California department of education. It is dynamically driven and reflect real-time data,

and contains all active, pending, closed, and merged public schools and districts.

[Data Dictionary] https://www.cde.ca.gov/schooldirectory/report?rid=dl1&tp=xlsx

[Unique ID Schema] The column "CDSCode" is a primary key.
;


*setup environmental parameters;
%let inputDatasetURL = 
https://github.com/stat6250/team-7_project1/blob/master/pubschls%20(1).xlsx.xls?raw=true;

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
