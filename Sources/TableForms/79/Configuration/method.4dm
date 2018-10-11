Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		cb_PermitirPostFiles:=Num:C11(PREF_fGet (0;"ADT Permite postulaciones archivos";"0"))
		cb_PermitirPostWeb:=Num:C11(PREF_fGet (0;"ADT Permite postulaciones web";"0"))
		
		SELECT LIST ITEMS BY POSITION:C381(vl_TabMetaDatos;1)
		ARRAY LONGINT:C221(alADT_DefRecNums;0)
		ARRAY LONGINT:C221(alADT_DefID;0)
		_O_ARRAY STRING:C218(80;asADT_DefName;0)
		ARRAY LONGINT:C221(alADT_DefType;0)
		_O_ARRAY STRING:C218(80;atADT_DefHTMLTags;0)
		ARRAY TEXT:C222(atADT_DefTypeTxt;0)
		ARRAY LONGINT:C221(alADT_Positions;0)
		ARRAY LONGINT:C221(alADT_DefTableNum;0)
		ARRAY LONGINT:C221(alADT_DefFieldNum;0)
		ARRAY TEXT:C222(atADT_TypesTxt;5)
		ARRAY LONGINT:C221(alADT_TypesLong;5)
		atADT_TypesTxt{1}:="Texto"
		atADT_TypesTxt{2}:="Fecha"
		atADT_TypesTxt{3}:="Entero"
		atADT_TypesTxt{4}:="Real"
		atADT_TypesTxt{5}:="Lista"
		alADT_TypesLong{1}:=Is text:K8:3
		alADT_TypesLong{2}:=Is date:K8:7
		alADT_TypesLong{3}:=Is longint:K8:6
		alADT_TypesLong{4}:=Is real:K8:4
		alADT_TypesLong{5}:=10  //`para identificar la lista
		$err:=ALP_DefaultColSettings (xALP_MetaDef;1;"alADT_DefID";__ ("ID");40;"#####0")
		$err:=ALP_DefaultColSettings (xALP_MetaDef;2;"asADT_DefName";__ ("Nombre");334;"";0;0;1)
		$err:=ALP_DefaultColSettings (xALP_MetaDef;3;"atADT_DefTypeTxt";__ ("Tipo");280;"";0;0;1)
		$err:=ALP_DefaultColSettings (xALP_MetaDef;4;"atADT_DefHTMLTags";__ ("Etiqueta Formulario HTML");140;"";0;0;1)
		$err:=ALP_DefaultColSettings (xALP_MetaDef;5;"alADT_DefRecNums";"")
		$err:=ALP_DefaultColSettings (xALP_MetaDef;6;"alADT_DefType";"")
		$err:=ALP_DefaultColSettings (xALP_MetaDef;7;"alADT_Positions";"")
		$err:=ALP_DefaultColSettings (xALP_MetaDef;8;"alADT_DefTableNum";"")
		$err:=ALP_DefaultColSettings (xALP_MetaDef;9;"alADT_DefFieldNum";"")
		
		AL_SetEnterable (xALP_MetaDef;3;2;atADT_TypesTxt)
		
		ALP_SetDefaultAppareance (xALP_MetaDef;9;1;6;1;8)
		AL_SetColOpts (xALP_MetaDef;1;1;1;6;0)
		AL_SetRowOpts (xALP_MetaDef;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_MetaDef;0;1;1)
		AL_SetMiscOpts (xALP_MetaDef;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_MetaDef;"";"")
		AL_SetCallbacks (xALP_MetaDef;"";"xALP_ADT_CB_MetaDef")
		AL_SetScroll (xALP_MetaDef;0;-3)
		AL_SetEntryOpts (xALP_MetaDef;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_MetaDef;0;30;0;1)
		
		AL_SetDrgSrc (xALP_MetaDef;1;String:C10(xALP_MetaDef))
		AL_SetDrgDst (xALP_MetaDef;1;String:C10(xALP_MetaDef))
		
		ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
		_O_DISABLE BUTTON:C193(bDelMetaData)
		_O_DISABLE BUTTON:C193(bAddMetaData)
		$uID:=USR_GetUserID 
		If (($uID<0) & ($uID>-100))
			OBJECT SET VISIBLE:C603(*;"developer@";(Not:C34(Is compiled mode:C492)))
		End if 
	: (Form event:C388=On Close Box:K2:21)
		AL_ExitCell (xALP_MetaDef)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
