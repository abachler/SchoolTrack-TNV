//%attributes = {}
  //AL_LoadSpn

C_LONGINT:C283($err)
READ ONLY:C145([Alumnos_Suspensiones:12])

AL_CargaEventosConducta ("Suspensiones";->[Alumnos_Suspensiones:12]Alumno_Numero:7;->[Alumnos_Suspensiones:12]Desde:5;->[Alumnos_Suspensiones:12]Año:1)
ARRAY LONGINT:C221(<>aCdtaLong1;0)
ARRAY LONGINT:C221(<>aCdtaLong1;Records in selection:C76([Alumnos_Suspensiones:12]))
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12];<>aCdtaRecNo;[Alumnos_Suspensiones:12]Desde:5;<>aCdtaDate;[Alumnos_Suspensiones:12]Hasta:6;<>aCdtaDate2;[Alumnos_Suspensiones:12]Motivo:2;<>aCdtaText1;[Alumnos_Suspensiones:12]Observaciones:8;<>aCdtaText2;[Profesores:4]Nombre_comun:21;<>aCdtaText3;[Alumnos_Suspensiones:12]Profesor_Numero:4;<>aCdtaLong1)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_CdtaBehaviourFilter ("createListSpn")
ARRAY POINTER:C280(<>aCdtaPtrs;7)
<>aCdtaPtrs{1}:=-><>aCdtaDate
<>aCdtaPtrs{2}:=-><>aCdtaDate2
<>aCdtaPtrs{3}:=-><>aCdtaText1
<>aCdtaPtrs{4}:=-><>aCdtaText2
<>aCdtaPtrs{5}:=-><>aCdtaText3
<>aCdtaPtrs{6}:=-><>aCdtaLong1
<>aCdtaPtrs{7}:=-><>aCdtaRecNo
_O_DISABLE BUTTON:C193(bdelLine)
xALSet_AL_Suspensiones 

