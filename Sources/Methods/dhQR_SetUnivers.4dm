//%attributes = {}
  //dhQR_SetUnivers


C_TEXT:C284($1;$method)
$method:=$1
$manyTable:=$2
Case of 
	: ($method="Find")
		Case of 
			: ($manyTable=Table:C252(->[Alumnos_Inasistencias:10]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_Anotaciones:11]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_Suspensiones:12]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_Castigos:9]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_Atrasos:55]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_Licencias:73]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_EventosEnfermeria:14]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_EventosPersonales:16]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_EventosOrientacion:21]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_ControlesMedicos:99]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_ObsOrientacion:127]))
				STR_BusquedaEspecial (Table:C252($manyTable))
			: ($manyTable=Table:C252(->[Alumnos_EvaluacionValorica:23]))
			: ($manyTable=Table:C252(->[Alumnos_Calificaciones:208]))
			: ($manyTable=Table:C252(->[BBL_FichasCatalograficas:81]))
				ARRAY TEXT:C222(aCardType;0)
				WDW_OpenFormWindow (->[BBL_FichasCatalograficas:81];"ChooseCard";-1;5;__ ("Fichas catalográficas"))
				DIALOG:C40([BBL_FichasCatalograficas:81];"ChooseCard")
				CLOSE WINDOW:C154
		End case 
End case 