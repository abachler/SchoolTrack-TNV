//%attributes = {}
  //UD_v20140307_HabProcAutoDescto

C_BOOLEAN:C305($b_Autorizado)
C_LONGINT:C283($i;$l_elemento;$l_nivelAcceso;$l_numeroTabla;$r;$l_therm)

ARRAY TEXT:C222($at_Detalle;0)
ARRAY TEXT:C222($at_metodo;0)

READ WRITE:C146([xShell_UserGroups:17])
ALL RECORDS:C47([xShell_UserGroups:17])
SELECTION TO ARRAY:C260([xShell_UserGroups:17];aQR_Longint1)

$l_therm:=IT_UThermometer (1;0;"Habilitando proceso autorizado "+ST_Qte ("Modificar Porcentaje de Descuento de Cuentas Corrientes"))
For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
	ARRAY LONGINT:C221($ai_nivelAcceso;0)
	ARRAY LONGINT:C221($ai_numeroTabla;0)
	GOTO RECORD:C242([xShell_UserGroups:17];aQR_Longint1{vQR_Long1})
	BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->$at_Detalle;->$at_metodo)
	APPEND TO ARRAY:C911($at_Detalle;"Modificar Porcentaje de Descuento de Cuentas Corrientes")
	APPEND TO ARRAY:C911($at_metodo;"ACTcc_HabilitarDescuentosCC")
	
	If (Find in array:C230($at_metodo;"ACTcc_HabilitarDescuentosCC ")=-1)
		
		BLOB_Blob2Vars (->[xShell_UserGroups:17]xTableAcces:4;0;->aUserPriv)
		For ($i;1;Size of array:C274(aUserPriv))
			$l_numeroTabla:=Int:C8(aUserPriv{$i})
			$l_nivelAcceso:=Dec:C9(aUserPriv{$i})*10
			$l_elemento:=Find in array:C230($ai_numeroTabla;$l_numeroTabla)
			If ($l_elemento<0)
				APPEND TO ARRAY:C911($ai_numeroTabla;$l_numeroTabla)
				APPEND TO ARRAY:C911($ai_nivelAcceso;$l_nivelAcceso)
			Else 
				If ($l_nivelAcceso>$ai_nivelAcceso{$l_elemento})
					$ai_nivelAcceso{$l_elemento}:=$l_nivelAcceso
				End if 
			End if 
		End for 
		
		  // se determina si el usuario dispone de privilegios para el nivel de acceso requerido
		$r:=Find in array:C230($ai_numeroTabla;Table:C252(->[ACT_CuentasCorrientes:175]))
		$b_Autorizado:=($ai_nivelAcceso{$r}>=4)
		If ($b_Autorizado)
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;->$at_Detalle;->$at_metodo)
			SAVE RECORD:C53([xShell_UserGroups:17])
		End if 
	End if 
	
End for 
IT_UThermometer (-2;$l_therm)
KRL_UnloadReadOnly (->[xShell_UserGroups:17])

