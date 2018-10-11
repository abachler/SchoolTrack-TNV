//%attributes = {}
  // BWR_OpenRecord()
  // Por: Alberto Bachler: 09/03/13, 14:12:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_error;$l_numeroDeRegistros;$l_posicionRegistroActual;$l_ignorar;$l_recNumRegistroSeleccionado)
ARRAY LONGINT:C221($al_filasSeleccionadas;0)

C_PICTURE:C286(pSave;pCancel;pFirst;pNext;pPrev;pLast;pPrint;pDelete;pInfos)

If (USR_checkRights ("L";yBWR_currentTable))
	$l_error:=AL_GetSelect (xALP_Browser;$al_filasSeleccionadas)
	$l_recNumRegistroSeleccionado:=alBWR_recordNumber{$al_filasSeleccionadas{1}}
	lBWR_recordNumber:=$al_filasSeleccionadas{1}
	
	vbXS_inBrowser:=True:C214
	vlBWR_BrowsingMethod:=BWR Standard Browsing
	  // Modificado por: Saúl Ponce (28/08/2017) Ticket 186422, aparecía error al ingresar a un aviso de cobro que previamente fue eliminado en la ventana de ingreso de pagos.
	  // GOTO RECORD(yBWR_currentTable->;$l_recNumRegistroSeleccionado)
	KRL_GotoRecord (yBWR_currentTable;$l_recNumRegistroSeleccionado)
	If (Records in selection:C76(yBWR_currentTable->)=0)
		CD_Dlog (0;__ ("El registro ya no existe (fue eliminado por otro usuario)."))
	Else 
		dhBWR_TableInitialisations 
		WDW_OpenFormWindow (yBWR_currentTable;vsBWR_defaultInputForm;-1;4;__ ("");"WDW_CloseDlog")
		BWR_ModifyRecord (yBWR_currentTable;vsBWR_defaultInputForm)
		CLOSE WINDOW:C154
		dhBWR_AfterFormUnload 
		vb_RecordInInputForm:=False:C215
		
		BWR_FormatBrowserCols 
		If (vtBWR_OnLoadMethod#"")
			If (API Does Method Exist (vtBWR_OnLoadMethod)=1)
				KRL_ExecuteMethod (vtBWR_OnLoadMethod)
			End if 
		End if 
		AL_UpdateArrays (xALP_Browser;-2)
		
		$l_numeroDeRegistros:=Size of array:C274(alBWR_recordNumber)
		$l_posicionRegistroActual:=lBWR_recordNumber
		If ($l_posicionRegistroActual>Size of array:C274(alBWR_recordNumber))
			$l_posicionRegistroActual:=$l_numeroDeRegistros
		End if 
		AL_SetScroll (xALP_Browser;$l_posicionRegistroActual;1)
		ARRAY LONGINT:C221($al_filasSeleccionadas;1)
		$al_filasSeleccionadas{1}:=$l_posicionRegistroActual
		AL_SetSelect (xALP_Browser;$al_filasSeleccionadas)
	End if 
Else 
	$l_ignorar:=CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para ver registros de esta tabla.")+XSvs_nombreTablaLocal_puntero (yBWR_currentTable))
End if 