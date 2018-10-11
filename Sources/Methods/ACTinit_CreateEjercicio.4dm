//%attributes = {}
  //ACTinit_CreateEjercicio

  //ejercicio
SET BLOB SIZE:C606(xBlob;0)
<>vdACT_InicioEjercicio:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
<>vdACT_TerminoEjercicio:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
BLOB_Variables2Blob (->xBlob;0;-><>vdACT_InicioEjercicio;-><>vdACT_TerminoEjercicio)
xBlob:=PREF_fGetBlob (0;"ACT_PreferenciasGenerales";xBlob)
BLOB_Blob2Vars (->xBlob;0;-><>vdACT_InicioEjercicio;-><>vdACT_TerminoEjercicio)
SET BLOB SIZE:C606(xBlob;0)