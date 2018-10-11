Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(hl_autoformat)
		HIGHLIGHT TEXT:C210(tExcept;1;1)
		
		ARRAY TEXT:C222(aText1;0)
		ARRAY TEXT:C222(aText2;0)
		ARRAY LONGINT:C221(aLong1;0)
		
		ARRAY TEXT:C222(aFormatOpts;5)
		aFormatOpts{1}:="Ninguno"
		aFormatOpts{2}:="todo en minúsculas"
		aFormatOpts{3}:="Primera inicial en mayúsculas"
		aFormatOpts{4}:="Iniciales en Mayúsculas"
		aFormatOpts{5}:="TODO EN MAYUSCULAS"
		
		  //busqueda de las tablas formateables del módulo (incluyendo tablas comunes a los módulos)
		$hl_ModuleTables:=New list:C375
		C_BLOB:C604($blob)
		$PrefReference:=XS_GetBlobName ("tables";vlBWR_CurrentModuleRef)
		$blob:=PREF_fGetBlob (0;$PrefReference)
		If (BLOB size:C605($blob)>0)
			$hl_ModuleTables:=BLOB to list:C557($blob)
		End if 
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]ReferenciaModulo:36=0;*)
		For ($i;1;Count list items:C380($hl_ModuleTables))
			GET LIST ITEM:C378($hl_ModuleTables;$i;$ref;$text)
			QUERY:C277([xShell_Tables:51]; | [xShell_Tables:51]NumeroDeTabla:5=$ref;*)
		End for 
		QUERY:C277([xShell_Tables:51])
		QUERY SELECTION:C341([xShell_Tables:51];[xShell_Tables:51]EnConfiguracionFormatos:38=True:C214)
		CLEAR LIST:C377($hl_ModuleTables)
		
		  //construccion de las pestañas para las tablas
		If (Records in selection:C76([xShell_Tables:51])>0)
			SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$aTableNums)
			ARRAY TEXT:C222($aTableNames;Size of array:C274($aTableNums))
			For ($i;1;Size of array:C274($aTableNums))
				$aTableNames{$i}:=XSvs_nombreTablaLocal_Numero ($aTableNums{$i};<>vtXS_CountryCode;<>vtXS_langage)
			End for 
			SORT ARRAY:C229($aTableNames;$aTableNums;>)
			If (Is a list:C621(hl_autoformat))
				CLEAR LIST:C377(hl_autoformat)
			End if 
			hl_autoformat:=New list:C375
			For ($i;1;Size of array:C274($aTableNames))
				APPEND TO LIST:C376(hl_autoformat;$aTableNames{$i};$aTableNums{$i})
			End for 
			
			SELECT LIST ITEMS BY POSITION:C381(hl_autoformat;1)
			
			$err:=AL_SetArraysNam (xALP_Autoformat;1;3;"aText1";"aText2";"aLong1")
			AL_SetStyle (xALP_Autoformat;0;"Tahoma";11;0)
			ALP_SetDefaultAppareance (xALP_Autoformat;9;1;2;1;4)
			AL_SetHeaders (xALP_Autoformat;1;2;__ ("Campo");__ ("Autoformato"))
			AL_SetHdrStyle (xALP_Autoformat;0;"Tahoma";11;1)
			AL_SetColOpts (xALP_Autoformat;0;3;0;1;0;0;0)
			AL_SetRowOpts (xALP_Autoformat;0;1;0;0;1)
			AL_SetWidths (xALP_Autoformat;1;2;120;242)
			AL_SetEntryOpts (xALP_Autoformat;2;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
			AL_SetEnterable (xALP_Autoformat;1;0)
			AL_SetEnterable (xALP_Autoformat;2;2;aFormatOpts)
			AL_SetCallbacks (xALP_Autoformat;"";"xALP_CB_XSAutoFormat")
			
			POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"autoformat@";False:C215)
		End if 
		XS_SetConfigInterface 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
