libname raw "C:\temp\WUSS 2024\Mastering Clinical Trial Reporting\raw data";

Data dm(rename=(racenew=race));
  set raw.dm;
  length domain $2 racenew $100 arm armcd $9 usubjid $25;
  domain='DM';
  racenew=trim(left(racec));
  arm='XMB111';
  armcd='XMB111';
  usubjid=trim(left(studyid))||'-'||trim(left(site))||'-'||trim(left(randomno));
  drop race;
run;


%*Go to:  https://github.com/mjbeckernc/WUSS2024_Mastering.git
