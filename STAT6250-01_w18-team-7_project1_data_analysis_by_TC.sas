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
	value ClosedDate
	 	low-'22/01/2018'd="Closed"
		other="Not Closed";
	value status
	 	"Active"="Actice"
		"Closed"="Merged"
		"Pending"="Pending"
		"Merged"="Merged"
run;
proc freq data=public_raw;
 	table EdOpsName*ClosedDate/missing list nocum;
	format 
 		EdOpsName $Educational_Option_Type_bins.
		ClosedDate ClosedDate.;
run;
proc sort data=have nodupkey;
by County 
run;
 	
