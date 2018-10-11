//%attributes = {}
  // USR_AccesoTablasAgrupadas()
  // Por: Alberto Bachler: 14/03/13, 12:08:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1;$0)

C_LONGINT:C283($l_numeroTabla)
C_POINTER:C301($y_tabla)

If (False:C215)
	C_POINTER:C301(USR_AccesoTablasAgrupadas ;$1)
	C_POINTER:C301(USR_AccesoTablasAgrupadas ;$0)
End if 

$y_tabla:=$1
$l_numeroTabla:=Table:C252($y_tabla)
Case of 
	: ($l_numeroTabla=Table:C252(->[Alumnos_Anotaciones:11]))
		$y_tabla:=->[Alumnos_Conducta:8]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_Atrasos:55]))
		$y_tabla:=->[Alumnos_Conducta:8]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_Castigos:9]))
		$y_tabla:=->[Alumnos_Conducta:8]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_Inasistencias:10]))
		$y_tabla:=->[Alumnos_Conducta:8]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_Licencias:73]))
		$y_tabla:=->[Alumnos_Conducta:8]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_Suspensiones:12]))
		$y_tabla:=->[Alumnos_Conducta:8]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_SintesisAnual:210]))
		$y_tabla:=->[Alumnos:2]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
		$y_tabla:=->[Alumnos_Calificaciones:208]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
		$y_tabla:=->[Alumnos_Calificaciones:208]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
		$y_tabla:=->[Alumnos_Calificaciones:208]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_ControlesMedicos:99]))
		$y_tabla:=->[Alumnos_FichaMedica:13]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_EventosEnfermeria:14]))
		$y_tabla:=->[Alumnos_FichaMedica:13]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_Vacunas:101]))
		$y_tabla:=->[Alumnos_FichaMedica:13]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_EventosOrientacion:21]))
		$y_tabla:=->[Alumnos_Orientacion:15]
		
	: ($l_numeroTabla=Table:C252(->[Alumnos_ObsOrientacion:127]))
		$y_tabla:=->[Alumnos_Orientacion:15]
		
	: ($l_numeroTabla=Table:C252(->[BBL_RegistrosAnaliticos:74]))
		$y_tabla:=->[BBL_Items:61]
		
	: ($l_numeroTabla=Table:C252(->[BBL_Subscripciones:117]))
		$y_tabla:=->[BBL_Items:61]
		
End case 

$0:=$y_tabla
