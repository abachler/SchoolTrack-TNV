//%attributes = {}
  //ACTbw_GeneracionAutomatica

ALL RECORDS:C47([ACT_CuentasCorrientes:175])
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)

ACTinit_LoadPrefs 

If (cb_GenerarDeudaAuto=1)
	b1:=1
	b2:=0
	b3:=0
	vlACT_SelectedMatrixID:=0
	vlACT_SelectedItemID:=0
	vsACT_Glosa:=""
	vsACT_Moneda:=""
	vrACT_Monto:=0
	cbACT_EsDescuento:=0  //era cbACT_EsDescuento:=False (ABK_Integracion_AT)
	cbACT_Afecto_Iva:=0  // era cbACT_Afecto_Iva:=False (ABK_Integracion_AT)
	bc_ReplaceSameDescription:=0
	aMeses:=Month of:C24(Current date:C33(*))
	aMeses2:=aMeses
	vdACT_AñoAviso:=Year of:C25(Current date:C33(*))
	viACT_DiaGeneracion:=viACT_DiaDeuda  //Viene de las preferencias
	viACT_DiaVencimiento2:=viACT_DiaDeuda+viACT_DiaVencimiento  //Viene de las preferencias
	If (Application type:C494#4D Remote mode:K5:5)
		bc_ExecuteOnServer:=0
	Else 
		bc_ExecuteOnServer:=1
	End if 
	vbACT_CargoEspecial:=False:C215
	BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->viACT_DiaVencimiento2;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso)
	$ProcessID:=Execute on server:C373("ACTcc_GeneraCargos";Pila_256K;"Generación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule)
End if 