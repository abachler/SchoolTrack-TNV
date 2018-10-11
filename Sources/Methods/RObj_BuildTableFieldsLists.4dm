//%attributes = {}
  // Método: RObj_BuildTableFieldsLists
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha y hora: 03/01/11, 10:46:15
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283(hl_Tables;hl_Fields)

$vlVS_FieldSelectorOptions:=$1

HL_ClearList (hl_Tables;hl_Fields)
hl_Tables:=New list:C375
hl_Fields:=New list:C375


Case of 
	: ($vlVS_FieldSelectorOptions=1)  //tabla actual
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Tables:51]))
			APPEND TO LIST:C376(hl_Tables;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5);[xShell_Tables:51]NumeroDeTabla:5)
			NEXT RECORD:C51([xShell_Tables:51])
		End for 
		SORT LIST:C391(hl_Tables;>)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		SET LIST ITEM PROPERTIES:C386(hl_tables;*;False:C215;Bold:K14:2;0)
		GET LIST ITEM:C378(hl_Tables;1;$tableNum;$tableName)
		
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Fields:52]))
			$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
			If (XSvs_esCampoValidoEnEditores ($y_campo))
				APPEND TO LIST:C376(hl_Fields;XSvs_nombreCampoLocal_puntero ($y_campo);[xShell_Fields:52]NumeroCampo:2)
			End if 
			NEXT RECORD:C51([xShell_Fields:52])
		End for 
		SORT LIST:C391(hl_Fields;>)
		
		
	: ($vlVS_FieldSelectorOptions=2)  //solo tablas relacionadas
		READ ONLY:C145([xShell_Tables_RelatedFiles:243])
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Tables_RelatedFiles:243]))
			APPEND TO LIST:C376(hl_Tables;XSvs_nombreTablaLocal_Numero ([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1);[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1)
			NEXT RECORD:C51([xShell_Tables_RelatedFiles:243])
		End for 
		SORT LIST:C391(hl_Tables;>)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		INSERT IN LIST:C625(hl_tables;*;XSvs_nombreTablaLocal_Numero (vlVS_CurrentTableNum);vlVS_CurrentTableNum)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		SET LIST ITEM PROPERTIES:C386(hl_tables;*;False:C215;Bold:K14:2;0)
		GET LIST ITEM:C378(hl_Tables;1;$tableNum;$tableName)
		
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Fields:52]))
			$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
			If (XSvs_esCampoValidoEnEditores ($y_campo))
				APPEND TO LIST:C376(hl_Fields;XSvs_nombreCampoLocal_puntero ($y_campo);[xShell_Fields:52]NumeroCampo:2)
			End if 
			NEXT RECORD:C51([xShell_Fields:52])
		End for 
		SORT LIST:C391(hl_Fields;>)
		
		
	: ($vlVS_FieldSelectorOptions=3)  //todas las tablas del módulo
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]ReferenciaModulo:36=vlBWR_CurrentModuleRef;*)
		QUERY:C277([xShell_Tables:51]; & ;[xShell_Tables:51]NumeroDeTabla:5#vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Tables:51]))
			APPEND TO LIST:C376(hl_Tables;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5);[xShell_Tables:51]NumeroDeTabla:5)
			NEXT RECORD:C51([xShell_Tables:51])
		End for 
		SORT LIST:C391(hl_Tables;>)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		INSERT IN LIST:C625(hl_tables;*;XSvs_nombreTablaLocal_Numero (vlVS_CurrentTableNum);vlVS_CurrentTableNum)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		SET LIST ITEM PROPERTIES:C386(hl_tables;*;False:C215;Bold:K14:2;0)
		GET LIST ITEM:C378(hl_Tables;1;$tableNum;$tableName)
		
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Fields:52]))
			$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
			If (XSvs_esCampoValidoEnEditores ($y_campo))
				APPEND TO LIST:C376(hl_Fields;XSvs_nombreCampoLocal_puntero ($y_campo);[xShell_Fields:52]NumeroCampo:2)
			End if 
			NEXT RECORD:C51([xShell_Fields:52])
		End for 
		SORT LIST:C391(hl_Fields;>)
		
		
		
		
	: ($vlVS_FieldSelectorOptions=4)  // todas las tablas
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5#vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Tables:51]))
			APPEND TO LIST:C376(hl_Tables;XSvs_nombreTablaLocal_Numero ([xShell_Tables:51]NumeroDeTabla:5);[xShell_Tables:51]NumeroDeTabla:5)
			NEXT RECORD:C51([xShell_Tables:51])
		End for 
		  //SORT LIST(hl_Tables;>)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		INSERT IN LIST:C625(hl_tables;*;XSvs_nombreTablaLocal_Numero (vlVS_CurrentTableNum);vlVS_CurrentTableNum)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		SET LIST ITEM PROPERTIES:C386(hl_tables;*;False:C215;Bold:K14:2;0)
		GET LIST ITEM:C378(hl_Tables;1;$tableNum;$tableName)
		
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=vlVS_CurrentTableNum)
		For ($i;1;Records in selection:C76([xShell_Fields:52]))
			$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
			If (XSvs_esCampoValidoEnEditores ($y_campo))
				APPEND TO LIST:C376(hl_Fields;XSvs_nombreCampoLocal_puntero ($y_campo);[xShell_Fields:52]NumeroCampo:2)
			End if 
			NEXT RECORD:C51([xShell_Fields:52])
		End for 
		SORT LIST:C391(hl_Fields;>)
		
		
		
		
	: ($vlVS_FieldSelectorOptions=5)  // todas las tablas
		For ($iTable;1;Get last table number:C254)
			If ((Is table number valid:C999($iTable)) & ($iTable#vlVS_CurrentTableNum))
				APPEND TO LIST:C376(hl_Tables;Table name:C256($iTable);$iTable)
			End if 
		End for 
		
		SORT LIST:C391(hl_Tables;>)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tables;1)
		INSERT IN LIST:C625(hl_tables;*;XSvs_nombreTablaLocal_Numero (vlVS_CurrentTableNum);vlVS_CurrentTableNum)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Tables;vlVS_CurrentTableNum)
		SET LIST ITEM PROPERTIES:C386(hl_tables;*;False:C215;Bold:K14:2;0)
		GET LIST ITEM:C378(hl_Tables;1;$tableNum;$tableName)
		
		
		For ($i;1;Get last field number:C255($tableNum))
			  //20130321 RCH
			If (Is field number valid:C1000($tableNum;$i))
				$y_campo:=Field:C253($tableNum;$i)
				$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
				If (XSvs_esCampoValidoEnEditores ($y_campo))
					APPEND TO LIST:C376(hl_Fields;XSvs_nombreCampoLocal_puntero ($y_campo);[xShell_Fields:52]NumeroCampo:2)
				End if 
			End if 
		End for 
		SORT LIST:C391(hl_Fields;>)
		
		
End case 
