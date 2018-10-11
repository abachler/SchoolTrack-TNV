//%attributes = {}
  //ACTmnu_AnularDocumentos

If (USR_GetMethodAcces (Current method name:C684))
	C_TEXT:C284($anulaDesde)
	C_TEXT:C284($yearName)
	ARRAY LONGINT:C221(alACT_WDTEliminar;0)  //cuando se anula desde el asistente y el doc no es anulado igual se eliminaba. Se declara este arreglod porque se utiliza dentro de actbol_anulaDcto
	If (Count parameters:C259>=1)
		$anulaDesde:=$1
	End if 
	If (vb_RecordInInputForm)
		$yearName:=aYearsACT{aYearsACT}
		$r:=CD_Dlog (0;__ ("El documento seleccionado será anulado. ¿Desea proceder?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			$line:=AL_GetLine (xALP_DocsTributarios)
			READ ONLY:C145([ACT_Boletas:181])
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=alACT_ApdosDTID{$line})
			ACTbol_AnulaDcto (False:C215)
			AL_UpdateArrays (xALP_DocsTributarios;0)
			  //ACTpp_LoadDocsTributarios 
			If ($anulaDesde="terceros")
				ACTpp_LoadDocsTributarios ($yearName;->[ACT_Terceros:138]Id:1)
			Else 
				ACTpp_LoadDocsTributarios ($yearName;->[Personas:7]No:1)
			End if 
			AL_UpdateArrays (xALP_DocsTributarios;-2)
			For ($i;1;Size of array:C274(abACT_ApdosDTNula))
				If (abACT_ApdosDTNula{$i})
					AL_SetRowColor (xALP_DocsTributarios;$i;"";15*16+8)
					AL_SetRowStyle (xALP_DocsTributarios;$i;2)
				Else 
					AL_SetRowColor (xALP_DocsTributarios;$i;"";16)
					AL_SetRowStyle (xALP_DocsTributarios;$i;0)
				End if 
			End for 
			AL_SetLine (xALP_DocsTributarios;0)
			_O_DISABLE BUTTON:C193(bAnular)
		End if 
		
		
	Else 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			$encontrados:=BWR_SearchRecords 
			If ($encontrados#-1)
				$r:=CD_Dlog (0;__ ("Los documentos seleccionados serán anulados. ¿Desea proceder?");__ ("");__ ("Si");__ ("No"))
				If ($r=1)
					ACTbol_AnulaDcto 
				End if 
			End if 
			USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			BWR_PanelSettings 
			BWR_SelectTableData 
		Else 
			CD_Dlog (0;__ ("Seleccione los documentos a anular."))
		End if 
	End if 
End if 