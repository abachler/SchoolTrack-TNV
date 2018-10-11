  //20121105 RCH
C_BOOLEAN:C305($vb_update)

$line:=AL_GetLine (Self:C308->)
$vl_col:=AL_GetColumn (Self:C308->)

  //20121105 RCH
  //IT_SetButtonState (($line#0);->bClearCEsp)
ACTcfg_OpcionesContabilidad ("SetEstadoBotonCtasEspeciales";->$line)


Case of 
	: (alProEvt=2)
		Case of 
			: ($vl_col=2)
				ARRAY LONGINT:C221(alACT_popUpID;0)
				ARRAY TEXT:C222(atACT_popUpGlosaCta;0)
				ARRAY TEXT:C222(atACT_popUpNumCta;0)
				ACTcfg_OpcionesContabilidad ("BuscaCuentasContables")
				SELECTION TO ARRAY:C260([ACT_Cuentas_Contables:286]id:1;alACT_popUpID;[ACT_Cuentas_Contables:286]glosa:3;atACT_popUpGlosaCta;[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4;atACT_popUpNumCta)
				
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=->atACT_popUpGlosaCta
				<>aChoicePtrs{2}:=->atACT_popUpNumCta
				<>aChoicePtrs{3}:=->alACT_popUpID
				
				APPEND TO ARRAY:C911(alACT_popUpID;0)
				APPEND TO ARRAY:C911(atACT_popUpGlosaCta;__ ("Ninguna"))
				APPEND TO ARRAY:C911(atACT_popUpNumCta;"")
				
				SORT ARRAY:C229(atACT_popUpGlosaCta;atACT_popUpNumCta;alACT_popUpID;>)
				TBL_ShowChoiceList (1;__ ("Seleccione la Cuenta");0)
				If (ok=1)
					If (alACT_popUpID{choiceIdx}#0)
						asACT_CtasEspecialesCta{$line}:=atACT_popUpNumCta{choiceIdx}
						alACT_idCtasEspeciales{$line}:=alACT_popUpID{choiceIdx}
					Else 
						asACT_CtasEspecialesCta{$line}:=""
						alACT_idCtasEspeciales{$line}:=0
					End if 
					  //asACT_CtasEspecialesCentro
					  //alACT_idCtaEspecial
					  //alACT_idCentroEspeciales
					  //alACT_idCtasEspeciales
					  //atACT_CtasEspecialesGlosa
					
					  //20121105 RCH
					$vb_update:=True:C214
					
				End if 
				AT_Initialize (->atACT_popUpGlosaCta;->atACT_popUpNumCta;->alACT_popUpID)
				
			: ($vl_col=3)
				ARRAY LONGINT:C221(alACT_popUpID;0)
				ARRAY TEXT:C222(atACT_popUpGlosaCta;0)
				ARRAY TEXT:C222(atACT_popUpNumCta;0)
				ACTcfg_OpcionesContabilidad ("BuscaCentrosCosto")
				SELECTION TO ARRAY:C260([ACT_Cuentas_Contables:286]id:1;alACT_popUpID;[ACT_Cuentas_Contables:286]glosa:3;atACT_popUpGlosaCta;[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4;atACT_popUpNumCta)
				
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=->atACT_popUpGlosaCta
				<>aChoicePtrs{2}:=->atACT_popUpNumCta
				<>aChoicePtrs{3}:=->alACT_popUpID
				
				APPEND TO ARRAY:C911(alACT_popUpID;0)
				APPEND TO ARRAY:C911(atACT_popUpGlosaCta;__ ("Ninguno"))
				APPEND TO ARRAY:C911(atACT_popUpNumCta;"")
				
				SORT ARRAY:C229(atACT_popUpGlosaCta;atACT_popUpNumCta;alACT_popUpID;>)
				TBL_ShowChoiceList (1;__ ("Seleccione el Centro de Costo");0)
				If (ok=1)
					If (alACT_popUpID{choiceIdx}#0)
						asACT_CtasEspecialesCentro{$line}:=atACT_popUpNumCta{choiceIdx}
						alACT_idCentroEspeciales{$line}:=alACT_popUpID{choiceIdx}
					Else 
						asACT_CtasEspecialesCentro{$line}:=""
						alACT_idCentroEspeciales{$line}:=0
					End if 
					
					  //20121105 RCH
					$vb_update:=True:C214
					
				End if 
				AT_Initialize (->atACT_popUpGlosaCta;->atACT_popUpNumCta;->alACT_popUpID)
		End case 
		
		  //20121105 RCH
		xAL_ACT_CB_CuentasEspecialesU ($vb_update;$line)
		
End case 

AL_UpdateArrays (xALP_CtasEspeciales;-2)