//%attributes = {}
  // Método: TGR_ACT_DocumentosPago
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:48:10
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		C_TEXT:C284($vt_idBanco;$vt_noCuenta;$vt_noSerie)
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				$vt_idBanco:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
				$vt_noCuenta:=Replace string:C233([ACT_Documentos_de_Pago:176]Ch_Cuenta:11;" ";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;"-";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;".";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;",";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;",";"")
				$vt_noCuenta:=ST_DeleteCharsLeft ($vt_noCuenta;"0")
				$vt_noSerie:=Replace string:C233([ACT_Documentos_de_Pago:176]NoSerie:12;" ";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;"-";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;".";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;",";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;",";"")
				$vt_noSerie:=ST_DeleteCharsLeft ($vt_noSerie;"0")
				If (($vt_idBanco#"") & ($vt_noCuenta#"") & ($vt_noSerie#""))
					If ([ACT_Documentos_de_Pago:176]Nulo:37=False:C215)
						[ACT_Documentos_de_Pago:176]indexDocDePago:45:=$vt_idBanco+"."+$vt_noCuenta+"."+$vt_noSerie
					Else 
						[ACT_Documentos_de_Pago:176]indexDocDePago:45:=""
					End if 
				Else 
					[ACT_Documentos_de_Pago:176]indexDocDePago:45:=""
				End if 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				$vt_idBanco:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
				$vt_noCuenta:=Replace string:C233([ACT_Documentos_de_Pago:176]Ch_Cuenta:11;" ";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;"-";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;".";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;",";"")
				$vt_noCuenta:=Replace string:C233($vt_noCuenta;",";"")
				$vt_noCuenta:=ST_DeleteCharsLeft ($vt_noCuenta;"0")
				$vt_noSerie:=Replace string:C233([ACT_Documentos_de_Pago:176]NoSerie:12;" ";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;"-";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;".";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;",";"")
				$vt_noSerie:=Replace string:C233($vt_noSerie;",";"")
				$vt_noSerie:=ST_DeleteCharsLeft ($vt_noSerie;"0")
				If (($vt_idBanco#"") & ($vt_noCuenta#"") & ($vt_noSerie#""))
					If ([ACT_Documentos_de_Pago:176]Nulo:37=False:C215)
						[ACT_Documentos_de_Pago:176]indexDocDePago:45:=$vt_idBanco+"."+$vt_noCuenta+"."+$vt_noSerie
					Else 
						[ACT_Documentos_de_Pago:176]indexDocDePago:45:=""
					End if 
				Else 
					[ACT_Documentos_de_Pago:176]indexDocDePago:45:=""
				End if 
		End case 
	End if 
End if 



