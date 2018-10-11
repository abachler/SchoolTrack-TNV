//%attributes = {}
  //AL_LoadAnt


C_LONGINT:C283($err)


AL_CargaEventosConducta ("Anotaciones";->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos_Anotaciones:11]Fecha:1;->[Alumnos_Anotaciones:11]Año:11)


SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
  //20130124 ASM Para solucionar un problema en la eliminación de las anotaciones
  //SELECTION TO ARRAY([Alumnos_Anotaciones];alSTRal_RecNumItemAnotacion;[Alumnos_Anotaciones]Fecha;adSTRal_FechaAnotacion;[Alumnos_Anotaciones]Motivo;atSTRal_MotivoAnotacion;[Alumnos_Anotaciones]Observaciones;atSTRal_NotasAnotacion;[Profesores]Nombre_común;atSTRal_NombreProfesorAnot;[Alumnos_Anotaciones]Profesor_Numero;alSTRal_NoProfesorAnot;[Alumnos_Anotaciones]Categoria;atSTRal_CategoriaAnotacion;[Alumnos_Anotaciones]Puntos;alSTRal_PuntosAnotacion;[Alumnos_Anotaciones]Signo;atSTRal_TipoAnotacion)
SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];<>aCdtaRecNo;[Alumnos_Anotaciones:11]Fecha:1;adSTRal_FechaAnotacion;[Alumnos_Anotaciones:11]Motivo:3;atSTRal_MotivoAnotacion;[Alumnos_Anotaciones:11]Observaciones:4;atSTRal_NotasAnotacion;[Profesores:4]Nombre_comun:21;atSTRal_NombreProfesorAnot;[Alumnos_Anotaciones:11]Profesor_Numero:5;alSTRal_NoProfesorAnot;[Alumnos_Anotaciones:11]Categoria:8;atSTRal_CategoriaAnotacion;[Alumnos_Anotaciones:11]Puntos:9;alSTRal_PuntosAnotacion;[Alumnos_Anotaciones:11]Signo:7;atSTRal_TipoAnotacion)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_CdtaBehaviourFilter ("createListAnt")
ARRAY POINTER:C280(<>aCdtaPtrs;8)
<>aCdtaPtrs{1}:=->adSTRal_FechaAnotacion
<>aCdtaPtrs{2}:=->atSTRal_CategoriaAnotacion
<>aCdtaPtrs{3}:=->atSTRal_MotivoAnotacion
<>aCdtaPtrs{4}:=->atSTRal_NotasAnotacion
<>aCdtaPtrs{5}:=->alSTRal_PuntosAnotacion
<>aCdtaPtrs{6}:=->atSTRal_NombreProfesorAnot
<>aCdtaPtrs{7}:=->alSTRal_NoProfesorAnot
<>aCdtaPtrs{8}:=-><>aCdtaRecNo
  //<>aCdtaPtrs{8}:=-><>aCdtaRecNo
_O_DISABLE BUTTON:C193(bdelLine)
xALSet_AL_Anotaciones 
