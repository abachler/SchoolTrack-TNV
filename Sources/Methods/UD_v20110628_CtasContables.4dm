//%attributes = {}
  //UD_v20110628_CtasContables

If (ACT_AccountTrackInicializado )
	C_BLOB:C604(xblob)
	C_LONGINT:C283($i;$vl_id;$vl_idCargo;$vl_idCentro)
	C_BOOLEAN:C305($vb_continuar)
	
	SET BLOB SIZE:C606(xblob;0)
	_O_ARRAY STRING:C218(80;<>asACT_GlosaCta;0)
	_O_ARRAY STRING:C218(80;<>asACT_CuentaCta;0)
	_O_ARRAY STRING:C218(80;<>asACT_CodAuxCta;0)
	_O_ARRAY STRING:C218(80;<>asACT_Centro;0)
	ARRAY TEXT:C222(atACT_CtasEspecialesGlosa;0)
	_O_ARRAY STRING:C218(80;asACT_CtasEspecialesCta;0)
	_O_ARRAY STRING:C218(80;asACT_CtasEspecialesCentro;0)
	xBlob:=PREF_fGetBlob (0;"Contabilidad";xBlob)
	BLOB_Blob2Vars (->xBlob;0;-><>asACT_GlosaCta;-><>asACT_CuentaCta;-><>asACT_Centro;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro;-><>asACT_CodAuxCta)
	
	READ WRITE:C146([ACT_Cuentas_Contables:286])
	
	  // cuentas contables
	For ($i;1;Size of array:C274(<>asACT_GlosaCta))
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]glosa:3=<>asACT_GlosaCta{$i})
		If (Records in selection:C76([ACT_Cuentas_Contables:286])=0)
			CREATE RECORD:C68([ACT_Cuentas_Contables:286])
			[ACT_Cuentas_Contables:286]id:1:=SQ_SeqNumber (->[ACT_Cuentas_Contables:286]id:1)
			[ACT_Cuentas_Contables:286]glosa:3:=<>asACT_GlosaCta{$i}
			[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4:=<>asACT_CuentaCta{$i}
			[ACT_Cuentas_Contables:286]codigo_aux:5:=<>asACT_CodAuxCta{$i}
			[ACT_Cuentas_Contables:286]id_tipo_cta:2:=1
			SAVE RECORD:C53([ACT_Cuentas_Contables:286])
		End if 
	End for 
	
	  // centro de costos
	For ($i;1;Size of array:C274(<>asACT_Centro))
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4=<>asACT_Centro{$i})
		If (Records in selection:C76([ACT_Cuentas_Contables:286])=0)
			CREATE RECORD:C68([ACT_Cuentas_Contables:286])
			[ACT_Cuentas_Contables:286]id:1:=SQ_SeqNumber (->[ACT_Cuentas_Contables:286]id:1)
			[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4:=<>asACT_Centro{$i}
			[ACT_Cuentas_Contables:286]id_tipo_cta:2:=2
			SAVE RECORD:C53([ACT_Cuentas_Contables:286])
		End if 
	End for 
	
	  // cuentas especiales
	ARRAY TEXT:C222($atACT_CtasEspeciales;0)
	ARRAY LONGINT:C221($alACT_CtasEspeciales;0)
	ACTcfg_OpcionesContabilidad ("ObtieneCuentasEspeciales";->$atACT_CtasEspeciales;->$alACT_CtasEspeciales)
	
	For ($i;1;Size of array:C274(atACT_CtasEspecialesGlosa))
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]glosa:3=atACT_CtasEspecialesGlosa{$i})
		If (Records in selection:C76([ACT_Cuentas_Contables:286])=0)
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4=asACT_CtasEspecialesCta{$i};*)
			QUERY:C277([ACT_Cuentas_Contables:286]; & ;[ACT_Cuentas_Contables:286]id_tipo_cta:2=1)
			$vl_id:=[ACT_Cuentas_Contables:286]id:1
			
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4=asACT_CtasEspecialesCentro{$i};*)
			QUERY:C277([ACT_Cuentas_Contables:286]; & ;[ACT_Cuentas_Contables:286]id_tipo_cta:2=2)
			$vl_idCentro:=[ACT_Cuentas_Contables:286]id:1
			
			$vl_idCargo:=Find in array:C230($atACT_CtasEspeciales;atACT_CtasEspecialesGlosa{$i})
			If ($vl_idCargo#-1)
				$vl_idCargo:=$alACT_CtasEspeciales{$vl_idCargo}
			Else 
				$vl_idCargo:=SQ_SeqNumber (->[ACT_Cuentas_Contables:286]id:1)
			End if 
			
			CREATE RECORD:C68([ACT_Cuentas_Contables:286])
			[ACT_Cuentas_Contables:286]id:1:=$vl_idCargo
			[ACT_Cuentas_Contables:286]glosa:3:=atACT_CtasEspecialesGlosa{$i}
			[ACT_Cuentas_Contables:286]id_cta_asociada:6:=$vl_id
			[ACT_Cuentas_Contables:286]id_centro_asociado:7:=$vl_idCentro
			[ACT_Cuentas_Contables:286]id_tipo_cta:2:=3
			SAVE RECORD:C53([ACT_Cuentas_Contables:286])
			
		End if 
	End for 
	
	  //verificacion cuentas especiales
	ACTcfg_OpcionesContabilidad ("VerificaCuentasEspeciales")
	
	KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
	
	SET BLOB SIZE:C606(xBlob;0)
End if 