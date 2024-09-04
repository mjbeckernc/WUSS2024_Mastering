* usubjid rfstdtc rfendtc age sex race ethnic arm;

libname sdtm "C:\temp\WUSS 2024\Mastering Clinical Trial Reporting\sdtm data";

options ls=140 ps=60;

proc sort data=sdtm.dm out=dm;
  by arm usubjid;

data dm;
  set dm;
  by arm usubjid;
  page=int(_n_/50)+1;
run;

ods _all_close;
ods listing;

proc report data=dm headline headskip nowindows split='|' missing spacing=1;
  column page arm usubjid rfstdtc rfendtc age sex race ethnic;
  define page / order noprint;
  define arm / order 'Treatment | Group' width=25;
  define usubjid / order 'Subject' width=12;
  define rfstdtc / display "Treatment|Start|Date" width=12;
  define rfendtc / display "Treatment|End|Date" width=12;
  define age / display 'Age|(Years)' format=4.1 width=8;
  define sex / display 'Gender' width=8;
  define race / display 'Race' width=30;
  define ethnic / display "Ethnicity" width=25;
  break after page / page;
  compute before usubjid;
    line " ";
  endcomp;
run;
