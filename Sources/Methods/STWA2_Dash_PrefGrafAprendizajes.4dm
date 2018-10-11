//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 04-09-18, 12:37:58
  // ----------------------------------------------------
  // Método: STWA2_Dash_PrefGrafAprendizajes
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_OBJECT:C1216($o_raiz;$o_nodo;$o_pref)
C_BOOLEAN:C305($b_enabled)

$t_accion:=$1
$y_Names:=$2
$y_Data:=$3
$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$t_grafico:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"grafico")
$b_enabled:=Choose:C955(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"enabled")="true";True:C214;False:C215)

$o_pref:=PREF_fGetObject ($userID;"prefGraficos")

Case of 
	: ($t_accion="guardaPrefencia")
		If (OB Is defined:C1231($o_pref))
			$o_nodo:=OB Get:C1224($o_pref;String:C10($userID);Is object:K8:27)
			OB SET:C1220($o_nodo;$t_grafico;$b_enabled)
		Else 
			OB SET:C1220($o_nodo;$t_grafico;$b_enabled)
			OB SET:C1220($o_pref;String:C10($userID);$o_nodo)
		End if 
		
		PREF_SetObject ($userID;"prefGraficos";$o_pref)
		$o_nodo:=OB Get:C1224($o_pref;String:C10($userID))
		$0:=$o_nodo
		
	: ($t_accion="LeePreferencia")
		$o_pref:=PREF_fGetObject ($userID;"prefGraficos")
		If (Not:C34(OB Is defined:C1231($o_pref)))
			OB SET:C1220($o_nodo;$t_grafico;$b_enabled)
			OB SET:C1220($o_pref;String:C10($userID);$o_nodo)
			PREF_SetObject ($userID;"prefGraficos";$o_pref)
		End if 
		$o_nodo:=OB Get:C1224($o_pref;String:C10($userID))
		$0:=$o_nodo
End case 

