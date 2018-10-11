//%attributes = {}
  //ACTtra_RetornaInfo

C_TEXT:C284($vt_accion)
C_TEXT:C284($0;$vt_retorno)
$popRecord:=False:C215
$vt_accion:=$1

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])

Case of 
	: ($vt_accion="retornaIdCargo")
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Transacciones:178]No_Comprobante:10)
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-102;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-103;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-10;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-1)
		$vt_retorno:=String:C10([ACT_Cargos:173]ID:1)
		
	: ($vt_accion="retornaMonedaT")
		If ([ACT_Transacciones:178]Glosa:8="Pago con Descuento")
			PUSH RECORD:C176([ACT_Transacciones:178])
			If ((Record number:C243([ACT_Cargos:173])>=0) & (Trigger level:C398=0))
				PUSH RECORD:C176([ACT_Cargos:173])
				$popRecord:=True:C214
			End if 
			$id_item:=Num:C11(ACTtra_RetornaInfo ("retornaIdCargo"))
			POP RECORD:C177([ACT_Transacciones:178])
			ONE RECORD SELECT:C189([ACT_Transacciones:178])
			If ($popRecord)
				POP RECORD:C177([ACT_Cargos:173])
				ONE RECORD SELECT:C189([ACT_Cargos:173])
			End if 
		Else 
			$id_item:=[ACT_Transacciones:178]ID_Item:3
		End if 
		$vt_retorno:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->$id_item;->[ACT_Cargos:173]Moneda:28)
	: ($vt_accion="valorConv")
		$vt_monedaOrg:=ACTtra_RetornaInfo ("retornaMonedaT")
		$vt_retorno:=String:C10(ACTut_fValorDivisa ($vt_monedaOrg;[ACT_Transacciones:178]Fecha:5);ACTcar_OpcionesGenerales ("retornaFormato";->$vt_monedaOrg))
End case 
$0:=$vt_retorno