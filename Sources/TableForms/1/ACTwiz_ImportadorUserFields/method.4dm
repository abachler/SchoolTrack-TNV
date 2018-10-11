Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		LOC_LoadIdenNacionales 
		  //20120831 RCH Los arreglos interproc podian no estar cargados... se agrega linea
		SYS_TableModulesWithUF 
		ARRAY TEXT:C222(atACT_TablesUF_ACT;0)
		ARRAY LONGINT:C221(alACT_TablesUF_ACT;0)
		COPY ARRAY:C226(<>aUFFileNm;atACT_TablesUF_ACT)
		AT_CopyArrayElements (-><>aUFFileNo;->alACT_TablesUF_ACT)
		
		  //no se permite importar para candidatos desde ACT
		$vl_existe:=Find in array:C230(atACT_TablesUF_ACT;"Candidatos@")
		If ($vl_existe>0)
			AT_Delete ($vl_existe;1;->alACT_TablesUF_ACT;->atACT_TablesUF_ACT)
		End if 
		
		atACT_TablesUF_ACT:=Find in array:C230(alACT_TablesUF_ACT;175)
		alACT_TablesUF_ACT:=atACT_TablesUF_ACT
		
		ACTwiz_ImportUserFields ("CargaIdentificador")
		
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
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(bImport;vt_g1#"")
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
