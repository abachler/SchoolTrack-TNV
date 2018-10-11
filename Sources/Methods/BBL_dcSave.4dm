//%attributes = {}
  // BBL_dcSave()
  // Por: Alberto Bachler: 17/09/13, 12:34:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_TEXT:C284($t_entradaLog)

If (False:C215)
	C_LONGINT:C283(BBL_dcSave ;$0)
End if 


$0:=0
If (USR_checkRights ("M";->[BBL_Items:61]))
	If ((KRL_RegistroFueModificado (->[BBL_Items:61])) | (vs_idxModified#""))
		If ([BBL_Items:61]Primer_título:4#"")
			If (Is new record:C668([BBL_Items:61]))
				If (<>MTv_AutoCop)
					SAVE RECORD:C53([BBL_Items:61])  //MONO 25/02/2014 - si el registro todavía no existe, cuando se crea la copia y se consultan campos del item con krlgetALGO... estos no son encontrados. 
					BBL_dcCreateCopy 
					LOG_RegisterEvt ("Nuevo item creado "+[BBL_Items:61]Titulos:5+". Media: "+[BBL_Items:61]Media:15+". ID: "+String:C10([BBL_Items:61]Numero:1)+". Con una copia creada automáticamente ID de registro: "+String:C10([BBL_Registros:66]ID:3)+", código de barras: "+[BBL_Registros:66]Código_de_barra:20)
				End if 
			End if 
			
			BBLitm_ActualizaFichasCatalogo 
			[BBL_Items:61]Modificado_por:34:=<>tUSR_CurrentUser
			[BBL_Items:61]Fecha_de_modificacion:37:=Current date:C33
			If (Is new record:C668([BBL_Items:61]))
				LOG_RegisterEvt ("Nuevo item creado "+[BBL_Items:61]Titulos:5+". Media: "+[BBL_Items:61]Media:15+". ID: "+String:C10([BBL_Items:61]Numero:1))
			Else 
				
				$t_entradaLog:=""
				If ([BBL_Items:61]Titulos:5#Old:C35([BBL_Items:61]Titulos:5))
					$t_entradaLog:=$t_entradaLog+__ ("título cambiado de ^0 a ^1.")
					$t_entradaLog:=Replace string:C233($t_entradaLog;"^0";Old:C35([BBL_Items:61]Titulos:5))
					$t_entradaLog:=Replace string:C233($t_entradaLog;"^1";[BBL_Items:61]Titulos:5)
				End if 
				
				If ([BBL_Items:61]Regla:20#Old:C35([BBL_Items:61]Regla:20))
					$t_entradaLog:=$t_entradaLog+", "+__ ("la regla cambiado de ^0 a ^1. ")
					$t_entradaLog:=Replace string:C233($t_entradaLog;"^0";Old:C35([BBL_Items:61]Regla:20))
					$t_entradaLog:=Replace string:C233($t_entradaLog;"^1";[BBL_Items:61]Regla:20)
				End if 
				
				If ($t_entradaLog#"")
					$t_entradaLog:=__ ("En el item ^0 (ID ^1): ")+$t_entradaLog
					$t_entradaLog:=Replace string:C233($t_entradaLog;"^0";[BBL_Items:61]Titulos:5)
					$t_entradaLog:=Replace string:C233($t_entradaLog;"^0";String:C10([BBL_Items:61]Numero:1))
					LOG_RegisterEvt ($t_entradaLog)
				End if 
				
			End if 
			SAVE RECORD:C53([BBL_Items:61])
			$0:=1
		Else 
			BEEP:C151
			$0:=-1
		End if 
	Else 
		$0:=0
	End if 
End if 

