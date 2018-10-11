//%attributes = {}
  //ACTpgs_SaveFormasDePago
  // metodo para manejar validaciones al guardar...
C_BOOLEAN:C305($vb_noGuardar;$vb_leerConf)
$vb_noGuardar:=False:C215

  //If (([ACT_Formas_de_Pago]id=-12) | ([ACT_Formas_de_Pago]id=-2) | ([ACT_Formas_de_Pago]id=-15) | ([ACT_Formas_de_Pago]id=-5))
  //[ACT_Formas_de_Pago]permite_ingreso_pago:=False
  //Else 
  //[ACT_Formas_de_Pago]permite_ingreso_pago:=True
  //End if 
  //If (([ACT_Formas_de_Pago]id=-2) | ([ACT_Formas_de_Pago]id=-15))
  //[ACT_Formas_de_Pago]visible_en_conf:=False
  //Else 
  //[ACT_Formas_de_Pago]visible_en_conf:=True
  //End if 
If ([ACT_Formas_de_Pago:287]forma_de_pago_old:2="")
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
	QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]forma_de_pago_old:2=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($vl_records<=1)
		[ACT_Formas_de_Pago:287]forma_de_pago_old:2:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
	Else 
		$vb_noGuardar:=True:C214  // generaria duplicado...
	End if 
End if 

$vb_leerConf:=False:C215
If (KRL_FieldChanges (->[ACT_Formas_de_Pago:287]forma_de_pago_old:2))
	$vb_leerConf:=True:C214
End if 

If (Not:C34($vb_noGuardar))
	SAVE RECORD:C53([ACT_Formas_de_Pago:287])
Else 
	BEEP:C151
End if 
KRL_UnloadReadOnly (->[ACT_Formas_de_Pago:287])

If ($vb_leerConf)
	KRL_ExecuteEverywhere ("ACTfdp_CargaFormasDePago")
End if 