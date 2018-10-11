//%attributes = {}
  //fm_BuscaPersonasAEliminar 
  //20110518 RCH Se crea metodo para unificar ejecucion de parte del codigo de fm_delete y fm_deleteSelection

C_LONGINT:C283($i;$vl_familias;$vl_alumnos;$vl_RegistrosCargos;$vl_RegistrosPagos)
C_TEXT:C284($vt_set;$1)
C_POINTER:C301($vy_array;$2)
C_BOOLEAN:C305($wasROnly)

$vt_set:=$1
$vy_array:=$2

$wasROnly:=Read only state:C362([Familia:78])

READ ONLY:C145([Familia:78])

For ($i;1;Size of array:C274($vy_array->))
	QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=$vy_array->{$i};*)
	QUERY:C277([Familia:78]; | [Familia:78]Madre_Número:6=$vy_array->{$i})
	QUERY SELECTION:C341([Familia:78];[Familia:78]Numero:1#[Familia:78]Numero:1)
	$vl_familias:=Records in selection:C76([Familia:78])
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_alumnos)
	QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=$vy_array->{$i};*)
	QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=$vy_array->{$i})
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_RegistrosCargos)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_RegistrosPagos)
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (($vl_alumnos+$vl_familias)=0)
		If ((($vl_RegistrosPagos=0) & ($vl_RegistrosCargos=0)) | (Not:C34(ACT_AccountTrackInicializado )))
			ADD TO SET:C119([Personas:7];$vt_set)
		End if 
	End if 
End for 
KRL_ResetPreviousRWMode (->[Familia:78];$wasROnly)