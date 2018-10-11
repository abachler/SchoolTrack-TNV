C_LONGINT:C283($table)

$row:=AL_GetLine (xAL_Modelos)

$EnCuantos:=0
ARRAY LONGINT:C221($atACT_PosReemplazo;0)
For ($i;1;Size of array:C274(atACT_ModeloDoc))
	If (atACT_ModeloDoc{$i}=atACT_ModelosDoc{$row})
		$EnCuantos:=$EnCuantos+1
		INSERT IN ARRAY:C227($atACT_PosReemplazo;Size of array:C274($atACT_PosReemplazo)+1;1)
		$atACT_PosReemplazo{Size of array:C274($atACT_PosReemplazo)}:=$i
	End if 
End for 
If (vtACT_ModRecibo=atACT_ModelosDoc{$row})
	$EnRecibo:=1
Else 
	$EnRecibo:=0
End if 

$msg:=atACT_ModelosDoc{$row}+"\r\r"

Case of 
	: (($EnRecibo=1) & ($EnCuantos>0))
		$msg:=$msg+__ ("Este modelo está siendo utilizado para imprimir algunos documentos.\rAdemás se utiliza para imprimir recibos.\r\r¿Está seguro de querer eliminarlo?")
	: (($EnRecibo=1) & ($EnCuantos=0))
		$msg:=$msg+__ ("Este modelo se utiliza para imprimir recibos.\r\r¿Está seguro de querer eliminarlo?")
	: (($EnRecibo=0) & ($EnCuantos>0))
		$msg:=$msg+__ ("Este modelo está siendo utilizado para imprimir algunos documentos.\r\r¿Está seguro de querer eliminarlo?")
	Else 
		$msg:=$msg+__ ("¿Está seguro de querer eliminar este modelo?")
End case 

$r:=CD_Dlog (2;$msg;__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	$table:=Table:C252(->[ACT_Boletas:181])*-1
	READ WRITE:C146([xShell_Reports:54])
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
	QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosDocID{$row})
	If ((Not:C34([xShell_Reports:54]IsStandard:38)) | (<>lUSR_CurrentUserID<0))
		$locked:=KRL_IsRecordLocked (->[xShell_Reports:54])
		
		If (Not:C34($locked))
			DELETE RECORD:C58([xShell_Reports:54])
			KRL_UnloadReadOnly (->[xShell_Reports:54])
			If ($EnCuantos>0)
				For ($i;1;Size of array:C274($atACT_PosReemplazo))
					atACT_ModeloDoc{$atACT_PosReemplazo{$i}}:=__ ("Seleccionar...")
				End for 
			End if 
			If ($EnRecibo>0)
				vtACT_ModRecibo:=__ ("Seleccionar...")
			End if 
			ACTcfg_LeeConfEnNuevoProc ("GuardaConfiguracion")
			  //ACTcfg_LoadConfigData (8)
			ACTcfg_LoadBolModels 
			AL_UpdateArrays (xAL_Modelos;-2)
			xALPSet_ACT_TiposdeDoc 
			ACTcfg_SetDocRowsColor 
			ACTcfg_MarkStandardDTModels 
			If (Size of array:C274(atACT_ModelosDoc)>0)
				AL_SetLine (xAL_Modelos;1)
				atACT_ModelosDoc:=1
				cb_EsEstandar:=Num:C11(abACT_ModelosEsSt{1})
				_O_ENABLE BUTTON:C192(cb_EsEstandar)
			Else 
				AL_SetLine (xAL_Modelos;0)
				atACT_ModelosDoc:=0
				cb_EsEstandar:=0
				_O_DISABLE BUTTON:C193(cb_EsEstandar)
			End if 
		Else 
			CD_Dlog (0;__ ("El modelo está siendo editado por otro usuario. Intente eliminarlo más tarde."))
		End if 
	Else 
		CD_Dlog (0;__ ("No puede eliminar un modelo estándar del sistema."))
		KRL_UnloadReadOnly (->[xShell_Reports:54])
	End if 
End if 
$newline:=AL_GetLine (xAL_Modelos)
IT_SetButtonState (($newline>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)