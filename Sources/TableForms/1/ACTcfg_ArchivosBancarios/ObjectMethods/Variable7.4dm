$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el modelo?");__ ("");__ ("No");__ ("Si"))
If ($r=2)
	READ WRITE:C146([xShell_Prefs:46])
	$NameModel:="["+atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}+"] "+vNombreModelo
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$NameModel)
	If (Locked:C147([xShell_Prefs:46]))
		CD_Dlog (0;__ ("El modelo está siendo utilizado. No puede ser eliminado en este momento."))
	Else 
		DELETE RECORD:C58([xShell_Prefs:46])
	End if 
	READ ONLY:C145([xShell_Prefs:46])
	ARRAY TEXT:C222(atACT_ModelosBanco;0)
	ARRAY TEXT:C222(atACT_ModelosBancoLimpio;0)
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="@["+vtACT_BancoCodigo+"]@")
	If (Records in selection:C76([xShell_Prefs:46])>0)
		ARRAY LONGINT:C221($RecNumPrefs;0)
		LONGINT ARRAY FROM SELECTION:C647([xShell_Prefs:46];$RecNumPrefs;"")
		SELECTION TO ARRAY:C260([xShell_Prefs:46]Reference:1;atACT_ModelosBanco)
		INSERT IN ARRAY:C227(atACT_ModelosBancoLimpio;Size of array:C274(atACT_ModelosBancoLimpio)+1;Records in selection:C76([xShell_Prefs:46]))
		For ($i;1;Size of array:C274($RecNumPrefs))
			GOTO RECORD:C242([xShell_Prefs:46];$RecNumPrefs{$i})
			atACT_ModelosBancoLimpio{$i}:=Substring:C12([xShell_Prefs:46]Reference:1;Position:C15(" ";[xShell_Prefs:46]Reference:1)+1)
		End for 
		_O_ENABLE BUTTON:C192(bModelos)
		SORT ARRAY:C229(atACT_ModelosBancoLimpio;atACT_ModelosBanco;>)
	End if 
	vNombreModelo:=""
	AL_UpdateArrays (xALP_RecepRecaud;0)
	AT_Initialize (->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
	vt_CharFiller:=""
	vl_LargoReg:=0
	vl_TiposReg:=0
	vl_PreviosReg:=0
	vl_PosterioresReg:=0
	AL_UpdateArrays (xALP_RecepRecaud;-2)
	IT_SetButtonState (False:C215;->bInsertLine;->bDeleteLine;->bTestImport;->bSaveDef;->bLoadDef;->bDeleteModelo;->bSave)
	IT_SetEnterable (False:C215;0;->vl_TiposReg;->vl_LargoReg;->vt_CharFiller;->vl_PreviosReg;->vl_PosterioresReg)
	modificado:=False:C215
End if 