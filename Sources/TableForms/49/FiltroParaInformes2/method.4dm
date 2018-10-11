Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		ARRAY TEXT:C222(at_NivelDesdeInf;0)
		ARRAY TEXT:C222(at_NivelHastaInf;0)
		ARRAY LONGINT:C221(al_NivelDesdeInf;0)
		ARRAY LONGINT:C221(al_NivelHastaInf;0)
		
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;at_NivelDesdeInf;[xxSTR_Niveles:6]Nivel:1;at_NivelHastaInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelDesdeInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelHastaInf)
		SORT ARRAY:C229(al_NivelDesdeInf;al_NivelHastaInf;at_NivelDesdeInf;at_NivelHastaInf;>)
		
		at_NivelDesdeInf:=1
		at_NivelHastaInf:=Size of array:C274(at_NivelHastaInf)
		al_NivelDesdeInf:=1
		al_NivelHastaInf:=Size of array:C274(al_NivelHastaInf)
		
		  //ESTADOS
		ARRAY BOOLEAN:C223(abACT_PrintItem;0)
		ARRAY PICTURE:C279(apACT_PrintItem;0)
		
		ARRAY TEXT:C222(at_estados;0)
		C_LONGINT:C283(hl_estados)
		hl_estados:=New list:C375
		hl_estados:=ADTcfg_LoadEstados 
		
		For ($i;Count list items:C380(hl_estados);1;-1)
			GET LIST ITEM:C378(hl_estados;$i;$ref;$text)
			APPEND TO ARRAY:C911(at_estados;$text)
		End for 
		
		AT_RedimArrays (Size of array:C274(at_estados);->abACT_PrintItem;->apACT_PrintItem)
		SORT ARRAY:C229(at_estados;apACT_PrintItem;abACT_PrintItem;>)
		
		dummyBoolean:=True:C214
		C_PICTURE:C286(dummyPict)
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)
		
		AT_Populate (->apACT_PrintItem;->dummyPict)
		AT_Populate (->abACT_PrintItem;->dummyBoolean)
		
		$err:=ALP_DefaultColSettings (xALP_estados;1;"apACT_PrintItem";"";30;"1")
		$err:=ALP_DefaultColSettings (xALP_estados;2;"at_estados";__ ("Anotaciones");290)
		$err:=ALP_DefaultColSettings (xALP_estados;3;"at_estados";"";50)
		
		ALP_SetDefaultAppareance (xALP_estados;9;1;6;1;8)
		AL_SetColOpts (xALP_estados;1;1;1;1;0)
		AL_SetRowOpts (xALP_estados;0;1;0;0;1;1)
		AL_SetCellOpts (xALP_estados;0;1;1)
		AL_SetMiscOpts (xALP_estados;1;0;"\\";0;1)
		AL_SetMainCalls (xALP_estados;"";"")
		AL_SetScroll (xALP_estados;0;-3)
		AL_SetEntryCtls (xALP_estados;1;0)
		AL_SetEntryOpts (xALP_estados;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_estados;0;30;0)
		
		
		  //config fecha
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
		vd_fecha_ini_conf:=Current date:C33(*)
		vd_fecha_end_conf:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 


