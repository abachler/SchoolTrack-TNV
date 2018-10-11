//%attributes = {}
  //AS_Observaciones

  //`xShell, Alberto Bachler
  //Metodo: AS_Observaciones
  //Por abachler
  //Creada el 02/10/2005, 09:19:34
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($idAsignatura;$idAlumno;$periodo;$nivel;$1;$3;$4;$5;hlObservaciones;hl_ObservacionesAlumno;$subList)
C_TEXT:C284($asignatura;$2;$alumno;$6)

  //****INICIALIZACIONES****
$idAsignatura:=$1
vlSTR_CurrentAsignaturaID:=$idAsignatura
$asignatura:=$2
$nivel:=$3
$periodo:=$4
$idAlumno:=$5
$alumno:=$6
vlSTR_CurrentAlumnoID:=$idAlumno
HL_ClearList (hl_ObservacionesAlumno;$subList)

  //****CUERPO****

QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;=;$idAsignatura;*)
QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;=;$idAlumno;*)
QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Periodo:3;=;$periodo)
SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]Categoría:4;atSTR_ObsEval_Categoria;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;atSTR_ObsEval_Observacion;[Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10;alSTR_ObsEval_RefObs)
AT_MultiLevelSort (">>";->atSTR_ObsEval_Categoria;->atSTR_ObsEval_Observacion;->alSTR_ObsEval_RefObs)

  // Construccion de la lista de observaciones
hl_ObservacionesAlumno:=New list:C375
$newRefCategoria:=-1
For ($I;1;Size of array:C274(alSTR_ObsEval_RefObs))
	$found:=HL_FindElement (hl_ObservacionesAlumno;atSTR_ObsEval_Categoria{$i})
	If ($found=-1)
		$subList:=New list:C375
		APPEND TO LIST:C376($subList;atSTR_ObsEval_Observacion{$i};alSTR_ObsEval_RefObs{$i})
		SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;alSTR_ObsEval_RefObs{$i};False:C215;0;0)
		APPEND TO LIST:C376(hl_ObservacionesAlumno;atSTR_ObsEval_Categoria{$i};$newRefCategoria;$sublist;True:C214)
		SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;$newRefCategoria;False:C215;1;0)
		$newRefCategoria:=$newRefCategoria-1
	Else 
		GET LIST ITEM:C378(hl_ObservacionesAlumno;$found;$RefCategoria;$categoria;$sublist)
		APPEND TO LIST:C376($subList;atSTR_ObsEval_Observacion{$i};alSTR_ObsEval_RefObs{$i})
		SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;alSTR_ObsEval_RefObs{$i};False:C215;0;0)
		SET LIST ITEM:C385(hl_ObservacionesAlumno;$RefCategoria;$categoria;$RefCategoria;$sublist;True:C214)
		SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;$RefCategoria;False:C215;1;0)
	End if 
End for 
_O_REDRAW LIST:C382(hl_ObservacionesAlumno)
SET LIST PROPERTIES:C387(hl_ObservacionesAlumno;2;0;16;1)

  // Construcción del texto de las observaciones
$lastCategoria:=""
vtSTR_Observaciones:=""
For ($i;1;Size of array:C274(atSTR_ObsEval_Categoria))
	If (atSTR_ObsEval_Categoria{$i}#$lastCategoria)
		$lastCategoria:=atSTR_ObsEval_Categoria{$i}
		If (vtSTR_Observaciones#"")
			vtSTR_Observaciones:=vtSTR_Observaciones+"\r"+atSTR_ObsEval_Categoria{$i}+"\r"+atSTR_ObsEval_Observacion{$i}+"\r"
		Else 
			vtSTR_Observaciones:=atSTR_ObsEval_Categoria{$i}+"\r"+atSTR_ObsEval_Observacion{$i}+"\r"
		End if 
	Else 
		vtSTR_Observaciones:=vtSTR_Observaciones+atSTR_ObsEval_Observacion{$i}+"\r"
	End if 
End for 

$title:=__ ("Observaciones para ")+$alumno
WDW_OpenFormWindow (->[Alumnos_ObservacionesEvaluacion:30];"Observaciones";-1;Movable form dialog box:K39:8;$title)
DIALOG:C40([Alumnos_ObservacionesEvaluacion:30];"Observaciones")
CLOSE WINDOW:C154

$lastCategoria:=""
vtSTR_Observaciones:=""
QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;=;$idAsignatura;*)
QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;=;$idAlumno;*)
QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Periodo:3;=;$periodo)
SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]Categoría:4;atSTR_ObsEval_Categoria;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;atSTR_ObsEval_Observacion;[Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10;alSTR_ObsEval_RefObs)
AT_MultiLevelSort (">>";->atSTR_ObsEval_Categoria;->atSTR_ObsEval_Observacion;->alSTR_ObsEval_RefObs)
  //SORT ARRAY(atSTR_ObsEval_Categoria;atSTR_ObsEval_Observacion;alSTR_ObsEval_RefObs;>)
For ($i;1;Size of array:C274(atSTR_ObsEval_Categoria))
	If (atSTR_ObsEval_Categoria{$i}#$lastCategoria)
		$lastCategoria:=atSTR_ObsEval_Categoria{$i}
		If (vtSTR_Observaciones#"")
			vtSTR_Observaciones:=vtSTR_Observaciones+"\r"+atSTR_ObsEval_Categoria{$i}+"\r"+atSTR_ObsEval_Observacion{$i}+"\r"
		Else 
			vtSTR_Observaciones:=atSTR_ObsEval_Categoria{$i}+"\r"+atSTR_ObsEval_Observacion{$i}+"\r"
		End if 
	Else 
		vtSTR_Observaciones:=vtSTR_Observaciones+atSTR_ObsEval_Observacion{$i}+"\r"
	End if 
End for 


$0:=vtSTR_Observaciones

  //****LIMPIEZA****
HL_ClearList (hl_ObservacionesAlumno;$subList)





