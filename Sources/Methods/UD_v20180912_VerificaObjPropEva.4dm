//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 12-09-18, 11:32:17
  // ----------------------------------------------------
  // Método: UD_v20180912_VerificaObjPropEva
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($l_indice;$l_indiceArray;$l_indicePeriodo;$l_iteraciones;$l_progress)
C_TEXT:C284($t_nodo)
C_OBJECT:C1216($o_nodo;$o_temporal)

ARRAY TEXT:C222($at_SourceName;0)
ARRAY LONGINT:C221($al_asignaturaRN;0)


READ WRITE:C146([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18];$al_asignaturaRN)

$l_progress:=IT_Progress (1;0;0;"Verificando objeto de propiedades de evaluación...")
For ($l_indice;1;Size of array:C274($al_asignaturaRN))
	$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_asignaturaRN);"Verificando objeto de propiedades de evaluación...")
	GOTO RECORD:C242([Asignaturas:18];$al_asignaturaRN{$l_indice})
	
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	$l_iteraciones:=Size of array:C274(aiSTR_Periodos_Numero)+1
	For ($l_indicePeriodo;1;$l_iteraciones)
		If ($l_indicePeriodo<=Size of array:C274(aiSTR_Periodos_Numero))
			$t_nodo:="P"+String:C10($l_indicePeriodo)
		Else 
			$t_nodo:="Anual"
		End if 
		$o_temporal:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo;Is object:K8:27)
		If (OB Is defined:C1231($o_temporal))
			OB GET ARRAY:C1229($o_temporal;"SourceName";$at_SourceName)
			
			For ($l_indiceArray;1;Size of array:C274($at_SourceName))
				If (($at_SourceName{$l_indiceArray}="Evaluación Ingresable") | ($at_SourceName{$l_indiceArray}="No Ingresable"))
					$at_SourceName{$l_indiceArray}:=Replace string:C233($at_SourceName{$l_indiceArray};"Ingresable";"ingresable")
				End if 
			End for 
			
			OB SET ARRAY:C1227($o_temporal;"SourceName";$at_SourceName)
		End if 
	End for 
	
	OB SET:C1220([Asignaturas:18]Configuracion:63;$t_nodo;$o_temporal)
	SAVE RECORD:C53([Asignaturas:18])
	CLEAR VARIABLE:C89($o_temporal)
End for 
$l_progress:=IT_Progress (-1;$l_progress)
KRL_UnloadReadOnly (->[Asignaturas:18])


