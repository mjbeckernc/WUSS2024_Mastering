libname sdtm "C:\temp\WUSS 2024\Mastering Clinical Trial Reporting\sdtm data";

data adsl;
  set sdtm.dm;
  keep STUDYID USUBJID SUBJID SITEID race arm trt01p;
  length trt01p $25;
  trt01p=arm;
run;
