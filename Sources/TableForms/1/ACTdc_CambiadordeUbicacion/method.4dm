Case of 
	: (Form event:C388=On Load:K2:1)
		vsACT_DocsReemp:=aACT_DocsReemp{1}
		aACT_DocsReemp:=1
		vlACT_ReempPor:=1
		i_Doc:=1
		ACTdc_CargaDatosDCartera 
		Case of 
			: (Size of array:C274(alACT_RecNumsDocs)>1)
				i_Doc:=1
				OBJECT SET VISIBLE:C603(*;"@next@";True:C214)
				OBJECT SET VISIBLE:C603(*;"@Ingresar@";False:C215)
				OBJECT SET VISIBLE:C603(*;"cb_VariosDocs";True:C214)
			: (Size of array:C274(alACT_RecNumsDocs)=1)
				i_Doc:=1
				OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
				OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
				OBJECT SET VISIBLE:C603(*;"cb_VariosDocs";False:C215)
			: (Size of array:C274(alACT_RecNumsDocs)=0)
		End case 
		XS_SetInterface 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
End case 