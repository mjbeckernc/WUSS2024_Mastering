/* WUSS2024_Mastering / dm_sdtm.sas
   Raw DM -> SDTM DM mapping (study XMB111).
   The original reads raw.dm from a local Windows path
   (libname raw "C:\temp\WUSS 2024\...\raw data"); here a small
   inline raw.dm stands in for that dataset so the mapping runs
   standalone. The DM-derivation DATA step below is unchanged. */

data raw_dm;
  length studyid $12 site $3 racec $30;
  infile datalines dsd dlm='|';
  input randomno site $ racec $ studyid $;
  datalines;
41|701|WHITE|XMB111
42|701|WHITE|XMB111
36|701|WHITE|XMB111
37|701|HISPANIC|XMB111
39|701|BLACK OR AFRICAN AMERICAN|XMB111
40|701|HISPANIC|XMB111
51|701|BLACK OR AFRICAN AMERICAN|XMB111
52|701|WHITE|XMB111
6|701|WHITE|XMB111
2|701|WHITE|XMB111
4|701|HISPANIC|XMB111
12|701|HISPANIC|XMB111
;
run;

Data dm(rename=(racenew=race));
  set raw_dm;
  length domain $2 racenew $100 arm armcd $9 usubjid $25;
  domain='DM';
  racenew=trim(left(racec));
  arm='XMB111';
  armcd='XMB111';
  usubjid=trim(left(studyid))||'-'||trim(left(site))||'-'||trim(left(randomno));
  drop race;
run;

proc print data=dm noobs;
  var usubjid studyid site domain arm armcd race;
run;
