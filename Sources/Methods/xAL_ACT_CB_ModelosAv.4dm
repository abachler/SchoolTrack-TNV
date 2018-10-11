//%attributes = {}
  //xAL_ACT_CB_ModelosAv

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3;$table)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xAL_ModelosAvisos;$col;$row)
	
	If (AL_GetCellMod (xAL_ModelosAvisos)=1)
		Case of 
			: ($col=1)
				READ WRITE:C146([xShell_Reports:54])
				$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
				QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
				If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
					$dupli:=Find in array:C230(atACT_ModelosAv;atACT_ModelosAv{$row})
					If (($dupli#$row) & ($dupli#-1))
						CD_Dlog (0;__ ("Ese nombre ya existe. Por favor use otro."))
						atACT_ModelosAv{$row}:=atACT_ModelosAv{0}
						AL_UpdateArrays (xAL_ModelosAvisos;-2)
					Else 
						[xShell_Reports:54]ReportName:26:=atACT_ModelosAv{$row}
						SAVE RECORD:C53([xShell_Reports:54])
					End if 
				End if 
				KRL_UnloadReadOnly (->[xShell_Reports:54])
				IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)
			: ($col=2)
				READ WRITE:C146([xShell_Reports:54])
				$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
				QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
				If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
					[xShell_Reports:54]Descripción:16:=atACT_ModelosAvDesc{$row}
					SAVE RECORD:C53([xShell_Reports:54])
				End if 
				KRL_UnloadReadOnly (->[xShell_Reports:54])
			: ($col=3)
				$el:=Find in array:C230(abACT_ModelosAvEsSt;True:C214)
				If ($el>-1)
					$modeloEstandar:=alACT_ModelosAvID{$el}
				Else 
					$modeloEstandar:=0
				End if 
				$modeloPDF:=Num:C11(PREF_fGet (0;"ACT_AvisoSeleccionado2PDF";String:C10($modeloEstandar)))
				If ($modeloPDF=alACT_ModelosAvID{$row})
					If (alACT_RegXPaginsAv{$row}#1)
						CD_Dlog (0;__ ("El sistema permite sólo un aviso por página para el modelo utilizado en la impresión PDF."))
						alACT_RegXPaginsAv{$row}:=1
					End if 
					READ WRITE:C146([xShell_Reports:54])
					$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
					QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
					QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
					If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
						[xShell_Reports:54]RegistrosXPagina:44:=alACT_RegXPaginsAv{$row}
						SAVE RECORD:C53([xShell_Reports:54])
					End if 
					KRL_UnloadReadOnly (->[xShell_Reports:54])
				Else 
					If (alACT_RegXPaginsAv{$row}>4)
						CD_Dlog (0;__ ("El sistema permite máximo cuatro avisos por página."))
						alACT_RegXPaginsAv{$row}:=alACT_RegXPaginsAv{0}
					Else 
						READ WRITE:C146([xShell_Reports:54])
						$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
						QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
						QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
						If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
							[xShell_Reports:54]RegistrosXPagina:44:=alACT_RegXPaginsAv{$row}
							SAVE RECORD:C53([xShell_Reports:54])
						End if 
						KRL_UnloadReadOnly (->[xShell_Reports:54])
					End if 
				End if 
		End case 
	End if 
End if 