//%attributes = {}
  //AL_LoadAbs


AL_CargaEventosConducta ("Inasistencias";->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos_Inasistencias:10]Fecha:1;->[Alumnos_Inasistencias:10]Año:8)


SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10];<>aCdtaRecNo;[Alumnos_Inasistencias:10]Fecha:1;<>aCdtaDate;[Alumnos_Inasistencias:10]Justificación:2;<>aCdtaText1;[Alumnos_Inasistencias:10]Observaciones:3;<>aCdtaText2;[Alumnos_Inasistencias:10]Licencia:5;<>aCdtaLong1)

AL_CdtaBehaviourFilter ("createListAbs")
ARRAY POINTER:C280(<>aCdtaPtrs;5)
<>aCdtaPtrs{1}:=-><>aCdtaDate
<>aCdtaPtrs{2}:=-><>aCdtaText1
<>aCdtaPtrs{3}:=-><>aCdtaText2
<>aCdtaPtrs{4}:=-><>aCdtaRecNo
<>aCdtaPtrs{5}:=-><>aCdtaLong1
_O_DISABLE BUTTON:C193(bdelLine)

xALSet_AL_Inasistencias 
