C_LONGINT:C283($table)

$row:=AL_GetLine (xAL_ModelosAvisos)

$msg:=atACT_ModelosAv{$row}+"\r\r"+__ ("¿Está seguro de querer eliminar este modelo?")
$r:=CD_Dlog (2;$msg;__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
	READ WRITE:C146([xShell_Reports:54])
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
	QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$row})
	
	$locked:=KRL_IsRecordLocked (->[xShell_Reports:54])
	If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
		If (Not:C34($locked))
			DELETE RECORD:C58([xShell_Reports:54])
			KRL_UnloadReadOnly (->[xShell_Reports:54])
			ACTcfg_LoadAvModels 
			AL_UpdateArrays (xAL_ModelosAvisos;-2)
			ACTcfg_MarkStandardAvModels 
			If (Size of array:C274(atACT_ModelosAv)>0)
				AL_SetLine (xAL_ModelosAvisos;1)
				atACT_ModelosAv:=1
				cb_EsEstandar:=Num:C11(abACT_ModelosAvEsSt{1})
				_O_ENABLE BUTTON:C192(cb_EsEstandar)
			Else 
				AL_SetLine (xAL_ModelosAvisos;0)
				atACT_ModelosAv:=0
				cb_EsEstandar:=0
				_O_DISABLE BUTTON:C193(cb_EsEstandar)
			End if 
		Else 
			CD_Dlog (0;__ ("El modelo está siendo editado por otro usuario. Intente eliminarlo más tarde."))
		End if 
	Else 
		CD_Dlog (0;__ ("No puede eliminar el Aviso de Cobranza estándar del sistema."))
		KRL_UnloadReadOnly (->[xShell_Reports:54])
	End if 
End if 
IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)