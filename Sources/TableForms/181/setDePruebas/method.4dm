Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(at_tipoDocumento;0)
		ARRAY LONGINT:C221(al_tipoDocumento;0)
		
		ACTdte_GeneraArchivo ("TiposDTEDisponibles";->at_tipoDocumento;->al_tipoDocumento)
		
		ACTdte_GeneraArchivo ("CodigosDeReferencia";->atACT_referencia)
		
		
		COPY ARRAY:C226(atACT_Caso;atACT_Caso2)
		If (vt_referencia="")
			atACT_Caso2:=0
		Else 
			atACT_Caso2:=Find in array:C230(atACT_Caso2;vt_referencia)
		End if 
		
		$vt_tipo:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};1;":")
		If (($vt_tipo="61") | ($vt_tipo="56"))
			_O_ENABLE BUTTON:C192(*;"referencia@")
		Else 
			_O_DISABLE BUTTON:C193(*;"referencia@")
			vt_referencia:=""
		End if 
		
		C_TEXT:C284(vtACT_apoderadoNombre)
		C_LONGINT:C283(vlACT_apoderadoID)
		vtACT_apoderadoNombre:=""
		If (vlACT_apoderadoID#0)
			vtACT_apoderadoNombre:=KRL_GetTextFieldData (->[Personas:7]No:1;->vlACT_apoderadoID;->[Personas:7]Apellidos_y_nombres:30)
		Else 
			vtACT_apoderadoNombre:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->vlACT_terceroID;->[ACT_Terceros:138]Nombre_Completo:9)
		End if 
		If (vtACT_apoderadoNombre="")
			vlACT_apoderadoID:=0
			vlACT_terceroID:=0
		End if 
		
		C_LONGINT:C283(vlACT_Folio)
		vlACT_Folio:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->vlACT_idBoleta;->[ACT_Boletas:181]Numero:11)
		
	: (Form event:C388=On Data Change:K2:15)
		C_LONGINT:C283($vl_col;$vl_line)
		C_POINTER:C301($vy_var)
		C_REAL:C285($vr_decuento)
		
		LISTBOX GET CELL POSITION:C971(lb_setPruebas;$vl_col;$vl_line;$vy_var)
		If ($vl_line>0)
			ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$vl_line)
		End if 
		
End case 
