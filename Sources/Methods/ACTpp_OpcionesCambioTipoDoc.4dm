//%attributes = {}
C_TEXT:C284($vt_accion)
C_POINTER:C301($vy_pointer1;${2};$vy_pointer2)
C_LONGINT:C283($vl_seleccionado)
C_BOOLEAN:C305($b_hecho;$0)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="OnLoad")
		ACTpp_OpcionesCambioTipoDoc ("InicializaVars")
		ACTpp_OpcionesCambioTipoDoc ("CargaTiposDoc")
		
	: ($vt_accion="AsignaNuevoEstado")
		C_LONGINT:C283($l_recNum)
		
		$l_recNum:=$vy_pointer1->
		If (vbACT_CTDdesdeTerceros)
			KRL_GotoRecord (->[ACT_Terceros:138];$l_recNum;True:C214)
			If (ok=1)
				[ACT_Terceros:138]id_CatDocTrib:55:=vlACT_nuevoIDTD2Asi
				LOG_RegisterEvt ("Cambio de tipo de documento tributario a "+[ACT_Terceros:138]Nombre_Completo:9+". Cambió de: "+String:C10(Old:C35([ACT_Terceros:138]id_CatDocTrib:55))+" a "+String:C10([ACT_Terceros:138]id_CatDocTrib:55)+".")
				SAVE RECORD:C53([ACT_Terceros:138])
				$b_hecho:=True:C214
			Else 
				$b_hecho:=False:C215
			End if 
			KRL_UnloadReadOnly (->[ACT_Terceros:138])
			
		Else 
			KRL_GotoRecord (->[Personas:7];$l_recNum;True:C214)
			If (ok=1)
				[Personas:7]ACT_DocumentoTributario:45:=vlACT_nuevoIDTD2Asi
				LOG_RegisterEvt ("Cambio de tipo de documento tributario a "+[Personas:7]Apellidos_y_nombres:30+". Cambió de: "+String:C10(Old:C35([Personas:7]ACT_DocumentoTributario:45))+" a "+String:C10([Personas:7]ACT_DocumentoTributario:45)+".")
				SAVE RECORD:C53([Personas:7])
				$b_hecho:=True:C214
			Else 
				$b_hecho:=False:C215
			End if 
			KRL_UnloadReadOnly (->[Personas:7])
			
		End if 
		
		
	: ($vt_accion="CargaTiposDoc")
		
		ACTcfg_ArregloDocsTribs (->[Personas:7]ACT_DocumentoTributario:45)
		  //arregos con nombres e ids: atACT_Categorias;->alACT_IDsCats
		
		COPY ARRAY:C226(atACT_Categorias;atACT_tipoDocAModif)
		COPY ARRAY:C226(atACT_Categorias;atACT_tipoDoc2Asignar)
		
	: ($vt_accion="Aceptar")
		C_BOOLEAN:C305($vb_continuar)
		$vb_continuar:=False:C215
		Case of 
			: (atACT_tipoDoc2Asignar=0)
				CD_Dlog (0;__ ("Usted debe seleccionar un tipo de documento a asignar."))
			: ((cs_particularCTD=1) & (atACT_tipoDocAModif=0))
				CD_Dlog (0;__ ("Usted debe seleccionar a qué tipo de documento desea aplicar el cambio."))
			Else 
				$vb_continuar:=True:C214
		End case 
		
		If ($vb_continuar)
			C_LONGINT:C283($vlACT_idFormaPago2Aplicar;$vlACT_idFormaPago2Mod)
			
			If (atACT_tipoDoc2Asignar>0)
				vlACT_nuevoIDTD2Asi:=alACT_IDsCats{Find in array:C230(atACT_Categorias;atACT_tipoDoc2Asignar{atACT_tipoDoc2Asignar})}
			End if 
			If ((atACT_tipoDocAModif>0) & (cs_particularCTD=1))
				$vlACT_idFormaPago2Mod:=alACT_IDsCats{Find in array:C230(atACT_Categorias;atACT_tipoDocAModif{atACT_tipoDocAModif})}
			End if 
			
			If ((vlACT_nuevoIDTD2Asi#0) & (vlACT_nuevoIDTD2Asi#$vlACT_idFormaPago2Mod))
				
				If (cs_todosCTD=1)
					
				Else 
					If (cs_particularCTD=1)
						If (vbACT_CTDdesdeTerceros)
							QUERY SELECTION:C341([ACT_Terceros:138];[ACT_Terceros:138]id_CatDocTrib:55=$vlACT_idFormaPago2Mod)
						Else 
							QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_DocumentoTributario:45=$vlACT_idFormaPago2Mod)
						End if 
					End if 
				End if 
				ACCEPT:C269
				
			Else 
				BEEP:C151
			End if 
		End if 
		
	: ($vt_accion="InicializaVars")
		
		C_REAL:C285(cs_todosCTD;cs_particularCTD)
		ARRAY TEXT:C222(atACT_tipoDocAModif;0)
		ARRAY TEXT:C222(atACT_tipoDoc2Asignar;0)
		C_LONGINT:C283(vlACT_nuevoIDTD2Asi)
		
		cs_todosCTD:=1
		cs_particularCTD:=0
		vlACT_nuevoIDTD2Asi:=0
		atACT_tipoDocAModif:=0
		atACT_tipoDoc2Asignar:=0
		
End case 

$0:=$b_hecho