Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_ACT_ResImport 
		vTitulo:="Resultados de la Importación de archivo tipo "+vTipo
		C_LONGINT:C283(cs_Apdos;cs_Ctas)
		cs_Apdos:=0
		cs_Ctas:=0
		_O_DISABLE BUTTON:C193(bGuardarRechazos)
	: (Form event:C388=On Clicked:K2:4)
		If (((cs_Apdos=1) | (cs_Ctas=1)) & (Size of array:C274(aRUTRechazo)>0))
			_O_ENABLE BUTTON:C192(bGuardarRechazos)
		Else 
			_O_DISABLE BUTTON:C193(bGuardarRechazos)
		End if 
End case 
