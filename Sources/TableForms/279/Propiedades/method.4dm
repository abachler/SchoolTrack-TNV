Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222($atRS_Propiedad_RS;0)
		  //ARRAY LONGINT($atRS_Valor_RS;0)
		ARRAY TEXT:C222($atRS_Valor_RS;0)
		C_TEXT:C284(vtRS_Title)
		C_BLOB:C604($xBlob)
		
		  //si el campo esta vacio me conecto con la intranet para obtener los datos...
		If (BLOB size:C605([ACT_RazonesSociales:279]dte_propiedades:34)=0)
			C_TEXT:C284($vtACT_propiedades)
			  //$xBlob:=WSact_GetPropiedadesCont ("Especificos";[ACT_RazonesSociales]RUT)
			$xBlob:=WSact_GetPropiedadesCont ("todos";[ACT_RazonesSociales:279]RUT:3)
			If (BLOB size:C605($xBlob)#0)
				KRL_ReloadInReadWriteMode (->[ACT_RazonesSociales:279])
				SET BLOB SIZE:C606([ACT_RazonesSociales:279]dte_propiedades:34;0)
				[ACT_RazonesSociales:279]dte_propiedades:34:=$xBlob
				SAVE RECORD:C53([ACT_RazonesSociales:279])
			End if 
		End if 
		
		ACTcfg_opcionesDTE ("OnLoadPropiedades";->[ACT_RazonesSociales:279]id:1)
		
		ACTcfg_opcionesDTE ("CallWSIntranet")
		
		
		  //obtengo valores almacenados configurables en ACT
		ACTcfg_opcionesDTE ("ObtieneArreglosDesdeBlob";->[ACT_RazonesSociales:279]propiedades:27;->$atRS_Propiedad_RS;->$atRS_Valor_RS)
		ACTcfg_opcionesDTE ("GuardaCamposACT";->$atRS_Propiedad_RS;->$atRS_Valor_RS)
		
		vtACT_Obs1:=__ ("Propiedades no enviadas.")
End case 