//%attributes = {}
  //xAL_ACT_CB_ModelosBol

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3;$table)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xAL_Modelos;$col;$row)
	
	If (AL_GetCellMod (xAL_Modelos)=1)
		Case of 
			: ($col=1)
				READ WRITE:C146([xShell_Reports:54])
				$table:=Table:C252(->[ACT_Boletas:181])*-1
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
				QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosDocID{$row})
				If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
					$dupli:=Find in array:C230(atACT_ModelosDoc;atACT_ModelosDoc{$row})
					If (($dupli#$row) & ($dupli#-1))
						CD_Dlog (0;__ ("Ese nombre ya existe. Por favor use otro."))
						atACT_ModelosDoc{$row}:=atACT_ModelosDoc{0}
						AL_UpdateArrays (xAL_Modelos;-2)
					Else 
						atACT_ModeloDoc{0}:=[xShell_Reports:54]ReportName:26
						[xShell_Reports:54]ReportName:26:=atACT_ModelosDoc{$row}
						SAVE RECORD:C53([xShell_Reports:54])
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->atACT_ModeloDoc;"=";->$DA_Return)
						For ($i;1;Size of array:C274($DA_Return))
							atACT_ModeloDoc{$DA_Return{$i}}:=[xShell_Reports:54]ReportName:26
						End for 
						xALPSet_ACT_TiposdeDoc 
						KRL_UnloadReadOnly (->[xShell_Reports:54])
					End if 
				End if 
				IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)
			: ($col=2)
				READ WRITE:C146([xShell_Reports:54])
				$table:=Table:C252(->[ACT_Boletas:181])*-1
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
				QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosDocID{$row})
				If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
					[xShell_Reports:54]Descripción:16:=atACT_ModelosDesc{$row}
					SAVE RECORD:C53([xShell_Reports:54])
				End if 
				KRL_UnloadReadOnly (->[xShell_Reports:54])
			: ($col=3)
				If (alACT_ModelosDocRegXPag{$row}>4)
					CD_Dlog (0;__ ("El sistema permite máximo cuatro documentos por página."))
					alACT_ModelosDocRegXPag{$row}:=alACT_ModelosDocRegXPag{0}
				Else 
					READ WRITE:C146([xShell_Reports:54])
					$table:=Table:C252(->[ACT_Boletas:181])*-1
					QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
					QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosDocID{$row})
					If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
						[xShell_Reports:54]RegistrosXPagina:44:=alACT_ModelosDocRegXPag{$row}
						SAVE RECORD:C53([xShell_Reports:54])
					End if 
					KRL_UnloadReadOnly (->[xShell_Reports:54])
				End if 
		End case 
	End if 
End if 