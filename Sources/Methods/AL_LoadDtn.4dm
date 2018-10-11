//%attributes = {}
  //AL_LoadDtn


AL_CargaEventosConducta ("castigos";->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos_Castigos:9]Fecha:9;->[Alumnos_Castigos:9]Año:5)

ARRAY LONGINT:C221(<>aCdtaLong1;0)
ARRAY LONGINT:C221(<>aCdtaLong1;Records in selection:C76([Alumnos_Castigos:9]))
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Castigos:9];<>aCdtaRecNo;[Alumnos_Castigos:9]Fecha:9;<>aCdtaDate;[Alumnos_Castigos:9]Motivo:2;<>aCdtaText1;[Alumnos_Castigos:9]Observaciones:3;<>aCdtaText2;[Profesores:4]Nombre_comun:21;<>aCdtaText3;[Alumnos_Castigos:9]Horas_de_castigo:7;<>aCdtaNum1;[Alumnos_Castigos:9]Castigo_cumplido:4;<>aCdtaBool;[Alumnos_Castigos:9]Profesor_Numero:6;<>aCdtaLong1)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_CdtaBehaviourFilter ("createListDtn")
ARRAY POINTER:C280(<>aCdtaPtrs;8)
<>aCdtaPtrs{1}:=-><>aCdtaDate
<>aCdtaPtrs{2}:=-><>aCdtaText1
<>aCdtaPtrs{3}:=-><>aCdtaText2
<>aCdtaPtrs{4}:=-><>aCdtaText3
<>aCdtaPtrs{5}:=-><>aCdtaNum1
<>aCdtaPtrs{6}:=-><>aCdtaBool
<>aCdtaPtrs{7}:=-><>aCdtaLong1
<>aCdtaPtrs{8}:=-><>aCdtaRecNo
_O_DISABLE BUTTON:C193(bdelLine)
xALSet_AL_Castigos 


