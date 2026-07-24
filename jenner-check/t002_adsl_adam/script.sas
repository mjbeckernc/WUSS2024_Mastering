/* WUSS2024_Mastering / adsl_adam.sas
   SDTM DM -> ADaM ADSL (subject-level analysis dataset).
   The original reads sdtm.dm from a local Windows path
   (libname sdtm "C:\temp\WUSS 2024\...\sdtm data"); here a small
   inline sdtm.dm stands in for that dataset so the ADSL build runs
   standalone. It mirrors the SDTM DM produced by dm_sdtm.sas
   (arm='XMB111', usubjid = studyid-site-subjid). The ADSL DATA
   step below is unchanged. */

data sdtm_dm;
  length studyid $12 usubjid $25 subjid $8 siteid $3 race $30 arm $9;
  infile datalines dsd dlm='|';
  input studyid $ usubjid $ subjid $ siteid $ race $ arm $;
  datalines;
XMB111|XMB111-701-41|41|701|WHITE|XMB111
XMB111|XMB111-701-42|42|701|WHITE|XMB111
XMB111|XMB111-701-37|37|701|HISPANIC|XMB111
XMB111|XMB111-701-39|39|701|BLACK OR AFRICAN AMERICAN|XMB111
XMB111|XMB111-701-51|51|701|BLACK OR AFRICAN AMERICAN|XMB111
XMB111|XMB111-701-6|6|701|WHITE|XMB111
XMB111|XMB111-701-2|2|701|WHITE|XMB111
XMB111|XMB111-701-12|12|701|HISPANIC|XMB111
;
run;

data adsl;
  set sdtm_dm;
  keep STUDYID USUBJID SUBJID SITEID race arm trt01p;
  length trt01p $25;
  trt01p=arm;
run;

proc print data=adsl noobs;
  var studyid usubjid subjid siteid race arm trt01p;
run;
