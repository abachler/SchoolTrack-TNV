//%attributes = {}
  //DIAP_InscribeCargaAluAsig
C_BOOLEAN:C305($b_cargado)
C_LONGINT:C283($id_alu;$1;$i;$id_asig;$fia)
C_POINTER:C301($y_orden;$y_abrev;$y_id_asig;$y_asignatura;$y_id_tipoExamen;$y_tipoExamen;$y_id_dioma;$y_idioma;$y_uuid;$2;$3;$4;$5;$6;$7;$8;$9;$10)

$id_alu:=$1
$y_orden:=$2
$y_abrev:=$3
$y_id_asig:=$4
$y_asignatura:=$5
$y_id_tipoExamen:=$6
$y_tipoExamen:=$7
$y_id_dioma:=$8
$y_idioma:=$9
$y_uuid:=$10

ARRAY LONGINT:C221($al_id_idioma;0)
ARRAY LONGINT:C221($al_id_tipoexamen;0)
ARRAY TEXT:C222($at_idioma;0)
ARRAY TEXT:C222($at_tipoexamen;0)

READ ONLY:C145([DIAP_AlumnosAsignaturas:225])
QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]ID_Alumno:2=$id_alu;*)
QUERY:C277([DIAP_AlumnosAsignaturas:225]; & ;[DIAP_AlumnosAsignaturas:225]Año:7=<>gyear)
ORDER BY:C49([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Orden:4;>)

If (Records in selection:C76([DIAP_AlumnosAsignaturas:225])>0)
	$b_cargado:=True:C214
	
	SELECTION TO ARRAY:C260([DIAP_AlumnosAsignaturas:225]ID_Asignatura:3;$y_id_asig->;*)
	SELECTION TO ARRAY:C260([DIAP_AlumnosAsignaturas:225]Orden:4;$y_orden->;*)
	SELECTION TO ARRAY:C260([DIAP_AlumnosAsignaturas:225]Auto_UUID:1;$y_uuid->;*)
	SELECTION TO ARRAY:C260([DIAP_AlumnosAsignaturas:225]ID_Idioma:5;$y_id_dioma->;*)
	SELECTION TO ARRAY:C260([DIAP_AlumnosAsignaturas:225]ID_TipoExamen:6;$y_id_tipoExamen->;*)
	SELECTION TO ARRAY:C260
	
	DIAP_ConfigCargaTipoExamen (->$al_id_tipoexamen;->$at_tipoexamen)
	DIAP_ConfigCargaIdiomas (->$al_id_idioma;->$at_idioma)
	
	For ($i;1;Size of array:C274($y_id_asig->))
		$id_asig:=$y_id_asig->{$i}
		APPEND TO ARRAY:C911($y_asignatura->;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asig;->[Asignaturas:18]Asignatura:3))
		APPEND TO ARRAY:C911($y_abrev->;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asig;->[Asignaturas:18]Abreviación:26))
		
		$fia:=Find in array:C230($al_id_tipoexamen;$y_id_tipoExamen->{$i})
		If ($fia>0)
			APPEND TO ARRAY:C911($y_tipoExamen->;$at_tipoexamen{$fia})
		Else 
			APPEND TO ARRAY:C911($y_tipoExamen->;"")
		End if 
		
		$fia:=Find in array:C230($al_id_idioma;$y_id_dioma->{$i})
		If ($fia>0)
			APPEND TO ARRAY:C911($y_idioma->;$at_idioma{$fia})
		Else 
			APPEND TO ARRAY:C911($y_idioma->;"")
		End if 
		
	End for 
	
End if 

$0:=$b_cargado

