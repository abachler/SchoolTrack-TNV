Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(atACT_InformesEspeciales;0)
		ARRAY TEXT:C222(atACT_InformesEspMethods;0)
		ARRAY TEXT:C222($aTempRecep;0)
		LOC_LoadList2Array ("ACT_InformesEspeciales";->$aTempRecep)
		
		For ($i;1;Size of array:C274($aTempRecep))
			APPEND TO ARRAY:C911(atACT_InformesEspeciales;ST_GetWord ($aTempRecep{$i};1;";"))
			APPEND TO ARRAY:C911(atACT_InformesEspMethods;ST_GetWord ($aTempRecep{$i};2;";"))
		End for 
		
		atACT_InformesEspeciales:=0
		_O_DISABLE BUTTON:C193(bIniciar)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Resize:K2:27)
		
End case 