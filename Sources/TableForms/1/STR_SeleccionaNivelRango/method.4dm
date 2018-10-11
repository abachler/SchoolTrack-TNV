Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_TEXT:C284(vtRango)
		C_TEXT:C284(vtOrden1;vtOrden2;vtOrden3)
		C_BOOLEAN:C305(vb_export)  //se setea esta variable en el método que llama este form si se quiere mostrar
		C_TEXT:C284(vt_mensaje)
		btOrden1:=1
		btOrden2:=0
		btOrden3:=0
		OrdenA:=1
		OrdenD:=0
		C_TEXT:C284(vt_cantidad1;vt_cantidad2)
		
		<>aNivelT:=Size of array:C274(<>aNivelT)
		$nivelNombre:=<>aNivelT{<>aNivelT}
		$nivNum:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nivelNombre;->[xxSTR_Niveles:6]NoNivel:5)
		vNivel2:=$nivelNombre
		vNivelInterno2:=$nivNum
		
		<>aNivelB:=1
		$nivelNombre:=<>aNivelB{<>aNivelB}
		$nivNum:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nivelNombre;->[xxSTR_Niveles:6]NoNivel:5)
		vNivelInterno1:=$nivNum
		vNivel1:=$nivelNombre
		
		cs_Exportar:=0
		OBJECT SET FILTER:C235(vCantidad1;"&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator))
		OBJECT SET FILTER:C235(vCantidad2;"&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator))
		If (vtRango="")
			vtRango:="Rango"
		End if 
		If (vtOrden1#"")
			OBJECT SET VISIBLE:C603(*;"Orden1@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"Orden1@";False:C215)
		End if 
		If (vtOrden2#"")
			OBJECT SET VISIBLE:C603(*;"Orden2@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"Orden2@";False:C215)
		End if 
		If (vtOrden3#"")
			OBJECT SET VISIBLE:C603(*;"Orden3@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"Orden3@";False:C215)
		End if 
		If (vb_export)
			OBJECT SET VISIBLE:C603(cs_Exportar;True:C214)
		Else 
			OBJECT SET VISIBLE:C603(cs_Exportar;False:C215)
		End if 
		If (vt_mensaje#"")
			OBJECT SET VISIBLE:C603(vt_mensaje;True:C214)
		Else 
			OBJECT SET VISIBLE:C603(vt_mensaje;False:C215)
		End if 
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (vlAL_WinRef)
End case 
