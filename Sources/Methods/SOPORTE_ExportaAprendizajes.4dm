//%attributes = {}
  // SOPORTE_ExportaAprendizajes()
  //
  // Descripción
  // Exporta los registros actuales de una copia de la base de datos
  // El archivo con los datos exportados puede ser utilizado para importar las evaluaciones en otra copia de la BD
  // El método para importar los datos es SOPORTE_RestauraAprendizajes
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 14/12/12, 10:28:59
  // ---------------------------------------------
C_LONGINT:C283($i;$l_IdProceso)
C_TIME:C306($h_refArchivo)
C_TEXT:C284($t_record)


  // CODIGO
STR_ReadGlobals 

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Asignaturas:18]Asignatura:3;>;[Alumnos:2]apellidos_y_nombres:40;>;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;>;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;>;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;>)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

ARRAY LONGINT:C221(aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];aRecNums;"")



$h_refArchivo:=Create document:C266("";"TEXT")
$l_IdProceso:=IT_Progress (1;0;0;"Exportando registros de evaluación de aprendizajes...")
SEND PACKET:C103($h_refArchivo;String:C10(Size of array:C274(aRecNums))+Char:C90(Carriage return:K15:38))
For ($i;1;Size of array:C274(aRecNums))
	GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];aRecNums{$i})
	$t_record:=[Alumnos_EvaluacionAprendizajes:203]Key:8+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]LlaveAlumno:92+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]LlaveAsignatura:93+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]LLaveCalificaciones:76+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)+Char:C90(Tab:K15:37)
	
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79+Char:C90(Tab:K15:37)
	
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80+Char:C90(Tab:K15:37)
	
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81+Char:C90(Tab:K15:37)
	
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82+Char:C90(Tab:K15:37)
	
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83+Char:C90(Tab:K15:37)
	
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+String:C10([Alumnos_EvaluacionAprendizajes:203]Final_Real:59)+Char:C90(Tab:K15:37)
	$t_record:=$t_record+[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84+Char:C90(Tab:K15:37)
	
	SEND PACKET:C103($h_refArchivo;$t_record+Char:C90(Carriage return:K15:38))
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274(aRecNums);"Exportando registros de evaluaciones de aprendizajes...")
End for 
CLOSE DOCUMENT:C267($h_refArchivo)
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
ALERT:C41("Exportacion terminada")

