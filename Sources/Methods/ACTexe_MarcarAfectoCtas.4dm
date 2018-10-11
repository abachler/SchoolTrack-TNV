//%attributes = {}
  //ACTexe_MarcarAfectoCtas

C_BOOLEAN:C305($value;$go)
C_TEXT:C284($event)
If (USR_GetMethodAcces (Current method name:C684))
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		READ WRITE:C146([ACT_CuentasCorrientes:175])
		$found:=BWR_SearchRecords 
		If ($found#-1)
			$r:=CD_Dlog (0;__ ("Por favor indique la acción a realizar sobre la opción Afecta a Intereses en cuentas corrientes:");__ ("");__ ("Marcar");__ ("Desmarcar");__ ("Cancelar"))
			Case of 
				: ($r=1)
					$value:=True:C214
					$go:=True:C214
					$event:="Se marcaron todas las cuentas corrientes seleccionadas como afectas a intereses."
					$procID:=IT_UThermometer (1;0;__ ("Marcando cuentas corrientes como afectas a intereses..."))
				: ($r=2)
					$value:=False:C215
					$go:=True:C214
					$event:="Se marcaron todas las cuentas corrientes seleccionadas como no afectas a interese"+"s."
					$procID:=IT_UThermometer (1;0;__ ("Marcando cuentas corrientes como no afectas a intereses..."))
				: ($r=3)
					$go:=False:C215
			End case 
			If ($go)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]AfectoIntereses:28:=$value)
				KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				IT_UThermometer (-2;$procID)
				LOG_RegisterEvt ($event)
			End if 
		Else 
			CD_Dlog (0;__ ("Primero debe seleccionar las Cuentas Corrientes a modificar."))
		End if 
	Else 
		CD_Dlog (0;__ ("Este comando sólo puede ser ejecutado desde la lengueta Cuentas Corrientes."))
	End if 
End if 