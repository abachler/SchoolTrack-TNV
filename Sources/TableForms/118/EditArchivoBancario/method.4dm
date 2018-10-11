Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (<>lUSR_CurrentUserID<0)
			OBJECT SET ENTERABLE:C238(vtCode;True:C214)
			_O_ENABLE BUTTON:C192(bGuardar)
			OBJECT SET VISIBLE:C603(bGenerarArchivo;True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(vtCode;False:C215)
			_O_DISABLE BUTTON:C193(bGuardar)
			OBJECT SET VISIBLE:C603(bGenerarArchivo;False:C215)
		End if 
		
		  //20120113 RCH para las cargas de proveedores DTE
		C_BOOLEAN:C305(vbACT_noMostrarTexto)
		OBJECT SET VISIBLE:C603(*;"vt_texto";Not:C34(vbACT_noMostrarTexto))
		
End case 
