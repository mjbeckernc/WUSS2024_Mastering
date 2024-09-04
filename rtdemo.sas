* arm sex age race ;

libname save "C:\temp\WUSS 2024\Mastering Clinical Trial Reporting\adam data";

options ls=140 ps=60;

proc format;
  value orderf 1="Age (years)"
               2="Gender, n(%)"
	           3="Race, n(%)";
run;

data adsl;
  set save.adsl;
  keep usubjid trt01pn arm sex age race;
run;

proc sort data=adsl;
  by trt01pn;

proc univariate data=adsl noprint;
  by trt01pn;
  var age;
  output out=stats n=n1 mean=mean1 median=median1 min=min1 max=max1;
run;

proc freq data=adsl noprint;
  by trt01pn;
  tables sex / out=stats1;
  tables race / out=stats2;
run;

proc transpose data=stats out=tran_stats;
  id trt01pn;
  var n1 mean1 median1 min1 max1;
run;

proc sort data=stats1;
  by sex;

proc transpose data=stats1 out=tran_sex;
  by sex;
  id trt01pn;
  var count;
run;

proc sort data=stats2;
  by race;

proc transpose data=stats2 out=tran_race;
  by race;
  id trt01pn;
  var count;
run;

data final;
  set tran_stats(in=x) tran_sex(in=y) tran_race(in=z);
  length lefttext descrip $50;
  if x then do;
    sortord=1;
	lefttext="Age (Years)";
	descrip=trim(left(_label_));
  end;
  else if y then do;
    sortord=2;
    lefttext="Gender";
	descrip=trim(left(sex));
  end;
  else if z then do;
    sortord=3;
	lefttext="Race";
	descrip=trim(left(race));
  end;
run;

ods _all_ close;
ods listing;

proc report data=final;
  column sortord lefttext descrip _0 _54 _81;
  define sortord / order noprint;
  define lefttext / group " " width=15;
  define  descrip / " " display width=40;
  define _0 / "Placebo" display width=15;
  define _54 / "Xanomeline Low Dose" display width=15;
  define _81 / "Xanomeline High Dose" display width=15;
  compute before sortord;
    line " ";
  endcomp;
run;
