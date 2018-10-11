//%attributes = {}
  //QR_AluEvAprendizaje_GetData
  //MONO 03-10-2016 ticket 165579
  //Para informes y registro de actividades

C_LONGINT:C283($l_idObj;$l_tipo)
C_POINTER:C301($y_enunciado;$2;$y_tipo;$3;$y_orden;$4)
C_TEXT:C284($t_enunciado;$t_tipo;$t_uuid;$1)
_O_C_INTEGER:C282($i_orden)
$t_uuid:=$1

$l_tipo:=KRL_GetNumericFieldData (->[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_uuid;->[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4)

Case of 
	: ($l_tipo=Eje_Aprendizaje)
		$l_idObj:=KRL_GetNumericFieldData (->[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_uuid;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
		KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$l_idObj)
		$t_enunciado:=[MPA_DefinicionEjes:185]Nombre:3
		$i_orden:=[MPA_DefinicionEjes:185]OrdenamientoNumerico:9
		$t_tipo:=__ ("Eje")
		
	: ($l_tipo=Dimension_Aprendizaje)
		$l_idObj:=KRL_GetNumericFieldData (->[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_uuid;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
		KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->$l_idObj)
		$t_enunciado:=[MPA_DefinicionDimensiones:188]Dimensión:4
		$i_orden:=[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20
		$t_tipo:=__ ("Dimensión")
		
	: ($l_tipo=Logro_Aprendizaje)
		$l_idObj:=KRL_GetNumericFieldData (->[Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_uuid;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
		KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionCompetencias:187]ID:1;->$l_idObj)
		$t_enunciado:=[MPA_DefinicionCompetencias:187]Competencia:6
		$i_orden:=[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25
		$t_tipo:=__ ("Competencia")
		
End case 

If (Count parameters:C259>=2)
	$y_enunciado:=$2
	$y_enunciado->:=$t_enunciado
End if 

If (Count parameters:C259>=3)
	$y_tipo:=$3
	$y_tipo->:=$t_tipo
End if 

If (Count parameters:C259>=4)
	$y_orden:=$4
	$y_orden->:=$i_orden
End if 

