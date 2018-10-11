//%attributes = {}
  //ACTdc_Delete

  //TRACE
If ([ACT_Documentos_de_Pago:176]ID:1>=0)
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
	$0:=ACTpgs_Delete 
Else 
	$r:=CD_Dlog (0;__ ("¿Desea realmente eliminar el pago?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		$locked1:=Locked:C147([ACT_Documentos_de_Pago:176])
		$locked2:=Locked:C147([ACT_Documentos_en_Cartera:182])
		If (($locked1) | ($locked2))
			$0:=0
		Else 
			DELETE RECORD:C58([ACT_Documentos_de_Pago:176])
			DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
			$0:=1
		End if 
	End if 
End if 