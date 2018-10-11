//%attributes = {}
  //AL_LoadLic


C_LONGINT:C283($err)

AL_CargaEventosConducta ("licencias";->[Alumnos_Licencias:73]Alumno_numero:1;->[Alumnos_Licencias:73]Desde:2;->[Alumnos_Licencias:73]Año:9)
ARRAY BOOLEAN:C223(<>aCdtaMod;0)
ARRAY LONGINT:C221(<>aCdtaLong1;0)
ARRAY BOOLEAN:C223(<>aCdtaMod;Records in selection:C76([Alumnos_Licencias:73]))
ARRAY LONGINT:C221(<>aCdtaLong1;Records in selection:C76([Alumnos_Licencias:73]))
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Licencias:73];<>aCdtaRecNo;[Alumnos_Licencias:73]Desde:2;<>aCdtaDate;[Alumnos_Licencias:73]Hasta:3;<>aCdtaDate2;[Alumnos_Licencias:73]Tipo_licencia:4;<>aCdtaText1;[Alumnos_Licencias:73]Observaciones:5;<>aCdtaText2)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_CdtaBehaviourFilter ("createListLic")
ARRAY POINTER:C280(<>aCdtaPtrs;6)
<>aCdtaPtrs{1}:=-><>aCdtaDate
<>aCdtaPtrs{2}:=-><>aCdtaDate2
<>aCdtaPtrs{3}:=-><>aCdtaText1
<>aCdtaPtrs{4}:=-><>aCdtaText2
<>aCdtaPtrs{5}:=-><>aCdtaRecNo
<>aCdtaPtrs{6}:=-><>aCdtaMod
_O_DISABLE BUTTON:C193(bdelLine)

xALSet_AL_Licencias 