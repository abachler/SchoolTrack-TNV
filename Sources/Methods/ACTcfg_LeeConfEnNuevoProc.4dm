//%attributes = {}
  //ACTcfg_LeeConfEnNuevoProc

C_BOOLEAN:C305($vb_hayCambio;$0;$sem1;$vb_ProcesoPago)
C_TEXT:C284($vt_accion;$1;$vt_accion2)
$vt_accion:=$1
Case of 
	: ($vt_accion="LeeConfEnOtroProceso")
		$sem1:=Semaphore:C143("TerminaProceso")
		$vt_accion2:="BuscaProcIngresoPago"
		$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"LeyendoConfACT";$vt_accion2)
		DELAY PROCESS:C323(Current process:C322;10)
		While (Test semaphore:C652("ConfLeida"))
		End while 
		GET PROCESS VARIABLE:C371($proc;vb_ProcesoPago;$vb_ProcesoPago)
		CLEAR SEMAPHORE:C144("TerminaProceso")
		$vb_hayCambio:=$vb_ProcesoPago
		
	: ($vt_accion="BuscaProcIngresoPago")
		$sem1:=Semaphore:C143("ConfLeida")
		C_LONGINT:C283($vlNbTareas;$i;$vlStado;$vlHora)
		C_TEXT:C284($vt_procName)
		C_BOOLEAN:C305(vb_ProcesoPago)
		vb_ProcesoPago:=False:C215
		$vlNbTareas:=Count tasks:C335
		For ($i;1;$vlNbTareas)
			If (Process state:C330($i)>=Executing:K13:4)
				PROCESS PROPERTIES:C336($i;$vt_procName;$vlStado;$vlHora)
				C_TEXT:C284($vt_procNameVD)
				ACTpgs_OpcionesVR ("ObtieneNombreProceso";->$vt_procNameVD)
				If (($vt_procName="Ingreso de Pagos") | ($vt_procName="Documentar Deudas") | ($vt_procName=$vt_procNameVD))
					$i:=$vlNbTareas
					vb_ProcesoPago:=True:C214
				End if 
			End if 
		End for 
		CLEAR SEMAPHORE:C144("ConfLeida")
		While (Test semaphore:C652("TerminaProceso"))
		End while 
		
	: ($vt_accion="GuardaConfiguracion")
		$vb_hayCambio:=ACTcfg_LeeConfEnNuevoProc ("LeeConfEnOtroProceso")
		If (Not:C34($vb_hayCambio))
			ACTcfg_SaveConfig (8)
			If (vlACTdt_numLineasOrg#vlACTdt_numLineas)
				LOG_RegisterEvt ("Cambio en número de líneas desplegadas en documentos tributarios. Cambió de "+String:C10(vlACTdt_numLineasOrg)+" a "+String:C10(vlACTdt_numLineas)+".")
				vlACTdt_numLineasOrg:=vlACTdt_numLineas
			End if 
		Else 
			CD_Dlog (0;__ ("Mientras se estaba en la configuración se produjeron cambios en la numeración de algunos documentos tributarios. Los posibles cambios recientes efectuados en la configuración no fueron almacenados."))
		End if 
		
End case 
$0:=$vb_hayCambio