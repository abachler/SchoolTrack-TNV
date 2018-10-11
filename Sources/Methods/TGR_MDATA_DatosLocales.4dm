//%attributes = {}
  // Método: TGR_MDATA_DatosLocales
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:26:41
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[MDATA_RegistrosDatosLocales:145]Llave:5:=KRL_MakeStringAccesKey (->[MDATA_RegistrosDatosLocales:145]Field_UUID:1;->[MDATA_RegistrosDatosLocales:145]ID_registro:3;->[MDATA_RegistrosDatosLocales:145]Agno:4)
			[MDATA_RegistrosDatosLocales:145]Llave_Tabla_and_ID:6:=KRL_MakeStringAccesKey (->[MDATA_RegistrosDatosLocales:145]TableNumber:2;->[MDATA_RegistrosDatosLocales:145]ID_registro:3)
			KRL_FindAndLoadRecordByIndex (->[xxSTR_MetadatosLocales:141]UUID:10;->[MDATA_RegistrosDatosLocales:145]Field_UUID:1)
			Case of 
				: ([xxSTR_MetadatosLocales:141]Tipo:5=Is text:K8:3)
					  //nada
				: (([xxSTR_MetadatosLocales:141]Tipo:5=Is real:K8:4) | ([xxSTR_MetadatosLocales:141]Tipo:5=Is longint:K8:6) | ([xxSTR_MetadatosLocales:141]Tipo:5=Is integer:K8:5))
					[MDATA_RegistrosDatosLocales:145]Valor_Numerico:7:=Num:C11([MDATA_RegistrosDatosLocales:145]Valor_Texto:10)
					
				: ([xxSTR_MetadatosLocales:141]Tipo:5=Is date:K8:7)
					[MDATA_RegistrosDatosLocales:145]Valor_Fecha:8:=Date:C102([MDATA_RegistrosDatosLocales:145]Valor_Texto:10)
					
				: ([xxSTR_MetadatosLocales:141]Tipo:5=Is boolean:K8:9)
					If (([MDATA_RegistrosDatosLocales:145]Valor_Texto:10="Si") & ([MDATA_RegistrosDatosLocales:145]Valor_Texto:10="Yes") & ([MDATA_RegistrosDatosLocales:145]Valor_Texto:10="Oui"))
						[MDATA_RegistrosDatosLocales:145]Valor_Booleano:9:=True:C214
					Else 
						[MDATA_RegistrosDatosLocales:145]Valor_Booleano:9:=False:C215
					End if 
					[MDATA_RegistrosDatosLocales:145]Valor_Numerico:7:=Num:C11([MDATA_RegistrosDatosLocales:145]Valor_Booleano:9)
			End case 
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[MDATA_RegistrosDatosLocales:145]Llave:5:=KRL_MakeStringAccesKey (->[MDATA_RegistrosDatosLocales:145]Field_UUID:1;->[MDATA_RegistrosDatosLocales:145]ID_registro:3;->[MDATA_RegistrosDatosLocales:145]Agno:4)
			[MDATA_RegistrosDatosLocales:145]Llave_Tabla_and_ID:6:=KRL_MakeStringAccesKey (->[MDATA_RegistrosDatosLocales:145]TableNumber:2;->[MDATA_RegistrosDatosLocales:145]ID_registro:3)
			
			Case of 
				: ([xxSTR_MetadatosLocales:141]Tipo:5=Is text:K8:3)
					  //nada
				: (([xxSTR_MetadatosLocales:141]Tipo:5=Is real:K8:4) | ([xxSTR_MetadatosLocales:141]Tipo:5=Is longint:K8:6) | ([xxSTR_MetadatosLocales:141]Tipo:5=Is integer:K8:5))
					[MDATA_RegistrosDatosLocales:145]Valor_Numerico:7:=Num:C11([MDATA_RegistrosDatosLocales:145]Valor_Texto:10)
					
				: ([xxSTR_MetadatosLocales:141]Tipo:5=Is date:K8:7)
					[MDATA_RegistrosDatosLocales:145]Valor_Fecha:8:=Date:C102([MDATA_RegistrosDatosLocales:145]Valor_Texto:10)
					
				: ([xxSTR_MetadatosLocales:141]Tipo:5=Is boolean:K8:9)
					If (([MDATA_RegistrosDatosLocales:145]Valor_Texto:10="Si") & ([MDATA_RegistrosDatosLocales:145]Valor_Texto:10="Yes") & ([MDATA_RegistrosDatosLocales:145]Valor_Texto:10="Oui"))
						[MDATA_RegistrosDatosLocales:145]Valor_Booleano:9:=True:C214
					Else 
						[MDATA_RegistrosDatosLocales:145]Valor_Booleano:9:=False:C215
					End if 
					[MDATA_RegistrosDatosLocales:145]Valor_Numerico:7:=Num:C11([MDATA_RegistrosDatosLocales:145]Valor_Booleano:9)
			End case 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
			
	End case 
End if 



