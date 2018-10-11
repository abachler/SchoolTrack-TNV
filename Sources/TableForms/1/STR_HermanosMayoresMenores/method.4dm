  //Método de Formulario: STR_HermanosMayoresMenores

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		Case of 
			: (vtQRY_StringParam1="<")
				r1_Menores:=1
				_O_DISABLE BUTTON:C193(r1_Menores)
				_O_DISABLE BUTTON:C193(r2_Mayores)
			: (vtQRY_StringParam1=">")
				r2_Mayores:=1
				_O_DISABLE BUTTON:C193(r1_Menores)
				_O_DISABLE BUTTON:C193(r2_Mayores)
			Else 
				r1_Menores:=1
		End case 
		s3_Indiferente:=1
		If (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(->[Alumnos:2])))=0)
			_O_DISABLE BUTTON:C193(bSearchSelection)
		End if 
		If (vsBWR_CurrentModule="AccountTrack")
			OBJECT SET VISIBLE:C603(*;"act@";True:C214)
			ACTcfg_LoadConfigData (1)
			act1_PorFamilia:=gGroupByFamily
			act2_PorApoderado:=gGroupByGardian
		Else 
			OBJECT SET VISIBLE:C603(*;"act@";False:C215)
			act1_PorFamilia:=1
			act2_PorApoderado:=0
		End if 
		bSearchSelection:=0
		_O_ENABLE BUTTON:C192(aNivelDesde)
		_O_ENABLE BUTTON:C192(aNivelHasta)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 