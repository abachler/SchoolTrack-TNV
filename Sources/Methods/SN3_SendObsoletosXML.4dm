//%attributes = {}
  //SN3_SendObsoletosXML

C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

$currentErrorHandler:=SN3_SetErrorHandler ("set")
$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Obsoletos;"sax";->$refXMLDoc)
SN3_BuildFileHeader ($refXMLDoc;SN3_Obsoletos;"obsoletos";$todos;$useArrays)
Error:=0
$p:=IT_UThermometer (1;0;"Generando documento con registros obsoletos...")
SN3_BuildObsoletosXML (SN3_EventosAgenda;$refXMLDoc;"eventosagenda")
SN3_BuildObsoletosXML (SN3_Calificaciones;$refXMLDoc;"calificaciones")
SN3_BuildObsoletosXML (SN3_Anotaciones;$refXMLDoc;"anotaciones")
SN3_BuildObsoletosXML (SN3_Atrasos;$refXMLDoc;"atrasos")
SN3_BuildObsoletosXML (SN3_Castigos;$refXMLDoc;"castigos")
SN3_BuildObsoletosXML (SN3_Inasistencias;$refXMLDoc;"inasistencia")
SN3_BuildObsoletosXML (SN3_InasistenciaxHoraAcum;$refXMLDoc;"inasisthoraacum")
SN3_BuildObsoletosXML (SN3_InasistenciaxHoraDetalle;$refXMLDoc;"inasisthoradetalle")
SN3_BuildObsoletosXML (SN3_Suspensiones;$refXMLDoc;"suspensiones")
SN3_BuildObsoletosXML (SN3_Condicionalidad;$refXMLDoc;"condicionalidad")
SN3_BuildObsoletosXML (SN3_Horarios;$refXMLDoc;"horarios")
SN3_BuildObsoletosXML (SN3_ObsAsignatura;$refXMLDoc;"obsasignatura")
SN3_BuildObsoletosXML (SN3_ObsJefatura;$refXMLDoc;"obsprofjefe")
SN3_BuildObsoletosXML (SN3_PlanesDeClase;$refXMLDoc;"planes")
SN3_BuildObsoletosXML (SN3_Documentos;$refXMLDoc;"documentos")
SN3_BuildObsoletosXML (SN3_EventosEnfermeria;$refXMLDoc;"eventosenfermeria")
SN3_BuildObsoletosXML (SN3_ControlesMedicos;$refXMLDoc;"controlesmedicos")
SN3_BuildObsoletosXML (SN3_Actividades_Evaluaciones;$refXMLDoc;"actividadesevaluaciones")
SN3_BuildObsoletosXML (SN3_Aprendizajes_Evaluacion;$refXMLDoc;"aprendizajesevaluaciones")
SN3_BuildObsoletosXML (SN3_ACT_Avisos;$refXMLDoc;"avisos")
SN3_BuildObsoletosXML (SN3_ACT_Pagos;$refXMLDoc;"pagos")
SN3_BuildObsoletosXML (SN3_MT_Prestamos;$refXMLDoc;"prestamos")
SN3_BuildObsoletosXML (SN3_Alumnos;$refXMLDoc;"alumnos")
SN3_BuildObsoletosXML (SN3_Profesores;$refXMLDoc;"profesores")
SN3_BuildObsoletosXML (SN3_Cursos;$refXMLDoc;"cursos")
SN3_BuildObsoletosXML (SN3_Asignaturas;$refXMLDoc;"asignaturas")
SN3_BuildObsoletosXML (SN3_Familias;$refXMLDoc;"familias")
SN3_BuildObsoletosXML (SN3_RelacionesFamiliares;$refXMLDoc;"relaciones")
SN3_BuildObsoletosXML (SN3_Actividades;$refXMLDoc;"actividades")
SN3_BuildObsoletosXML (SN3_DefinicionMapas;$refXMLDoc;"defmapas")
SN3_BuildObsoletosXML (SN3_Subasignaturas;$refXMLDoc;"subasignaturas")

  //20160219 RCH
SN3_BuildObsoletosXML (10013;$refXMLDoc;"guias")

IT_UThermometer (-2;$p)

SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
If (Error=0)
	SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con registros obsoletos.")
Else 
	SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros obsoletos no pudo ser generado.";Error)
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)