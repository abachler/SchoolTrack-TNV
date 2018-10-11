//%attributes = {}
  //DIAP_InscribeAsignatura

C_LONGINT:C283($1;$2;$3;$4)
C_LONGINT:C283($l_id_alumno;$l_id_asignatura;$l_tipo_examen;$l_idioma;$diap;$l_orden)

$l_id_alumno:=$1
$l_id_asignatura:=$2
$l_tipo_examen:=$3
$l_idioma:=$4
If (Count parameters:C259=5)
	$l_orden:=$5
End if 


READ ONLY:C145([DIAP_AlumnosAsignaturas:225])
QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]ID_Alumno:2=$l_id_alumno)
$diap:=Records in selection:C76([DIAP_AlumnosAsignaturas:225])
QUERY SELECTION:C341([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3=$l_id_asignatura)

  //este 5 debe ser configurable por que ahora son 5 asignaturas para el DIAP pero puede cambiar

If (($diap<5) & (Records in selection:C76([DIAP_AlumnosAsignaturas:225])=0))
	
	READ WRITE:C146([DIAP_AlumnosAsignaturas:225])
	CREATE RECORD:C68([DIAP_AlumnosAsignaturas:225])
	[DIAP_AlumnosAsignaturas:225]ID_Alumno:2:=$l_id_alumno
	[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3:=$l_id_asignatura
	If ($l_orden=0)
		[DIAP_AlumnosAsignaturas:225]Orden:4:=$diap+1
	Else 
		[DIAP_AlumnosAsignaturas:225]Orden:4:=$l_orden
	End if 
	
	[DIAP_AlumnosAsignaturas:225]ID_TipoExamen:6:=$l_tipo_examen
	[DIAP_AlumnosAsignaturas:225]ID_Idioma:5:=$l_idioma
	[DIAP_AlumnosAsignaturas:225]Año:7:=<>gyear
	[DIAP_AlumnosAsignaturas:225]Materia_UUID:8:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_id_asignatura;->[Asignaturas:18]Materia_UUID:46)
	SAVE RECORD:C53([DIAP_AlumnosAsignaturas:225])
	KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
	
	$0:=True:C214
	
Else 
	
	$0:=False:C215
	
End if 
