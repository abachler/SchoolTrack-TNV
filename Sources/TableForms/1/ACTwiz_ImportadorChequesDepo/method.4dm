
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/10/17, 11:20:49
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_ImportadorChequesDepo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //_o_C_INTEGER(vi_PageNumber)
		
		XS_SetInterface 
		
		vt_g1:=""
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
			r3:=0
		Else 
			r1:=0
			r2:=1
			r3:=0
		End if 
		
		cb_TieneEncabezado:=1
		_O_DISABLE BUTTON:C193(bImport)
		_O_DISABLE BUTTON:C193(cb_TieneEncabezado)
		
		bc_ExecuteOnServer:=0
		If (Application type:C494=4D Remote mode:K5:5)
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;True:C214)
		Else 
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;False:C215)
		End if 
		
		vi_PageNumber:=1
		
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(bImport;vt_g1#"")
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
