//%attributes = {}
  //ACTmatrices_AsociaConsulta
  //Basado en QR_AssociateQuery()

C_TEXT:C284($t_nombreTabla)


If (IT_AltKeyIsDown )
	SET BLOB SIZE:C606([ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7;0)
	SAVE RECORD:C53([ACT_MatricesAsignacionAut:289])
	KRL_ReloadAsReadOnly (->[ACT_MatricesAsignacionAut:289])
Else 
	$t_nombreTabla:=XSvs_nombreTablaLocal_puntero (->[ACT_CuentasCorrientes:175])
	If ($t_nombreTabla#"")
		wSrchInSel:=False:C215
		vb_DontExecSearch:=True:C214
		QRY_QueryEditor (->[ACT_CuentasCorrientes:175];[ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7)
		vb_DontExecSearch:=False:C215
		If (ok=1)
			BLOB_Variables2Blob (->[ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
			COMPRESS BLOB:C534([ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7)
			If ([ACT_MatricesAsignacionAut:289]ID:1>0)
				SAVE RECORD:C53([ACT_MatricesAsignacionAut:289])
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("La estructura virtual no contiene ninguna definición de archivo utilizable en las consultas"))
	End if 
End if 
