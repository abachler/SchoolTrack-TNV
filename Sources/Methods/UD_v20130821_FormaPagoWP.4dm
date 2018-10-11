//%attributes = {}
  //UD_v20130821_FormaPagoWP

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_contador;$l_existe;$l_indiceFDP)
	C_TEXT:C284($t_nombre;$t_nombreOrg)
	ARRAY LONGINT:C221($alACT_recNumsFDP;0)
	
	READ ONLY:C145([ACT_Formas_de_Pago:287])
	
	QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9="Webpay";*)
	QUERY:C277([ACT_Formas_de_Pago:287]; & ;[ACT_Formas_de_Pago:287]id:1>0)
	
	If (Records in selection:C76([ACT_Formas_de_Pago:287])>0)
		
		SELECTION TO ARRAY:C260([ACT_Formas_de_Pago:287];$alACT_recNumsFDP)
		
		$l_contador:=1
		For ($l_indiceFDP;1;Size of array:C274($alACT_recNumsFDP))
			READ WRITE:C146([ACT_Formas_de_Pago:287])
			
			GOTO RECORD:C242([ACT_Formas_de_Pago:287];$alACT_recNumsFDP{$l_indiceFDP})
			$t_nombreOrg:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
			$t_nombre:=$t_nombreOrg+" "+String:C10($l_contador)
			$l_existe:=Find in field:C653([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;$t_nombre)
			While ($l_existe#-1)
				$l_contador:=$l_contador+1
				$t_nombre:=$t_nombreOrg+" "+String:C10($l_contador)
				$l_existe:=Find in field:C653([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;$t_nombre)
			End while 
			
			[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9:=$t_nombre
			
			LOG_RegisterEvt ("Cambio en nombre de forma de pago en AccountTrack durante la actualización. Cambió de "+ST_Qte (Old:C35([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9))+" a "+ST_Qte ([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)+".")
			
			SAVE RECORD:C53([ACT_Formas_de_Pago:287])
			
			KRL_UnloadReadOnly (->[ACT_Formas_de_Pago:287])
			
			  //Actualizo registros en pagos y documentos de pago
			READ ONLY:C145([ACT_Formas_de_Pago:287])
			GOTO RECORD:C242([ACT_Formas_de_Pago:287];$alACT_recNumsFDP{$l_indiceFDP})
			
			READ WRITE:C146([ACT_Pagos:172])
			READ WRITE:C146([ACT_Documentos_de_Pago:176])
			
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=[ACT_Formas_de_Pago:287]id:1)
			APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)
			KRL_UnloadReadOnly (->[ACT_Pagos:172])
			
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=[ACT_Formas_de_Pago:287]id:1)
			APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Tipodocumento:5:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
			
		End for 
	End if 
End if 