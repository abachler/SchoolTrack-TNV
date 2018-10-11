//%attributes = {}
  //ACTexe_MarcarAfectoApdos

C_BOOLEAN:C305($value;$go)
C_TEXT:C284($event;$display)
If (USR_GetMethodAcces (Current method name:C684))
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
		READ WRITE:C146([Personas:7])
		$found:=BWR_SearchRecords 
		If ($found#-1)
			$r:=CD_Dlog (0;__ ("Por favor indique la acción a realizar sobre la opción Afecto a Intereses en apoderados de cuenta:");__ ("");__ ("Marcar");__ ("Desmarcar");__ ("Cancelar"))
			Case of 
				: ($r=1)
					$value:=True:C214
					$go:=True:C214
					$event:="Se marcaron todos los apoderados de cuenta seleccionados como afectos a intereses"+"."
					$procID:=IT_UThermometer (1;0;__ ("Marcando apoderados de cuenta como afectos a intereses..."))
				: ($r=2)
					$value:=False:C215
					$go:=True:C214
					$event:="Se marcaron todos los apoderados de cuenta seleccionados como no afectos a intere"+"ses."
					$procID:=IT_UThermometer (1;0;__ ("Marcando apoderados de cuenta como no afectos a intereses..."))
				: ($r=3)
					$go:=False:C215
			End case 
			If ($go)
				  //0xDev_AvoidTriggerExecution (True)
				DELAY PROCESS:C323(Current process:C322;10)
				ARRAY LONGINT:C221($RNPersonas;0)
				LONGINT ARRAY FROM SELECTION:C647([Personas:7];$RNPersonas;"")
				For ($p;1;Size of array:C274($RNPersonas))
					GOTO RECORD:C242([Personas:7];$RNPersonas{$p})
					[Personas:7]ACT_AfectoIntereses:64:=$value
					SAVE RECORD:C53([Personas:7])
					READ WRITE:C146([ACT_CuentasCorrientes:175])
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
					CREATE SET:C116([ACT_CuentasCorrientes:175];"apdoNormal")
					READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
					QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2;"")
					CREATE SET:C116([ACT_CuentasCorrientes:175];"exApdos")
					UNION:C120("apdoNormal";"exApdos";"apdoNormal")
					USE SET:C118("apdoNormal")
					SET_ClearSets ("apdoNormal";"exApdos")
					If ($value=False:C215)
						APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]AfectoIntereses:28:=False:C215)
					End if 
					KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				End for 
				  //0xDev_AvoidTriggerExecution (False)
				KRL_UnloadReadOnly (->[Personas:7])
				IT_UThermometer (-2;$procID)
				LOG_RegisterEvt ($event)
			End if 
		Else 
			CD_Dlog (0;__ ("Primero debe seleccionar los Apoderados a modificar."))
		End if 
	Else 
		CD_Dlog (0;__ ("Este comando sólo puede ser ejecutado desde la lengueta Apoderados."))
	End if 
End if 