//%attributes = {}
  // MÉTODO: BWR_AddRecord
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 15:34:39
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // BWR_AddRecord()
  // ----------------------------------------------------
C_LONGINT:C283($l_error;$l_altoFormulario;$l_recNum;$l_registrosEnExplorador;$l_resultado;$l_ultimoRecNum;$l_anchoFormulario;$l_posicionEnExplorador)
C_TEXT:C284($t_tituloVentana)




  // CODIGO PRINCIPAL
If (USR_checkRights ("A";yBWR_currentTable))
	ARRAY LONGINT:C221($al_FilasSeleccionadas;0)
	$l_error:=AL_GetSelect (xALP_Browser;$al_FilasSeleccionadas)
	vbXS_inBrowser:=True:C214
	vb_inBrowsingMode:=False:C215
	If (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))=0)
		CREATE EMPTY SET:C140(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	End if 
	FORM SET INPUT:C55(yBWR_currentTable->;vsBWR_defaultInputForm)
	viBWR_RecordWasSaved:=1
	$l_registrosEnExplorador:=Size of array:C274(alBWR_recordNumber)
	$t_tituloVentana:="Nuevo registro: "+XSvs_nombreTablaLocal_puntero (yBWR_currentTable)
	WDW_OpenFormWindow (yBWR_currentTable;vsBWR_defaultInputForm;-1;4;__ ("");"WDW_CloseDlog")
	
	
	vbBWR_IsNewRecord:=True:C214
	$l_recNum:=0
	$l_ultimoRecNum:=-1
	While ($l_recNum>=0)
		ADD RECORD:C56(yBWR_currentTable->;*)
		$l_recNum:=Record number:C243(yBWR_currentTable->)
		If ($l_recNum>=No current record:K29:2)
			USR_RegisterUserEvent (UE_AddRecord;vlBWR_SelectedTableRef)
			$l_ultimoRecNum:=$l_recNum
		Else 
			$l_recNum:=-1
		End if 
	End while 
	vbBWR_IsNewRecord:=False:C215
	CLOSE WINDOW:C154
	
	BWR_SelectTableData 
	If ($l_ultimoRecNum>=0)
		$l_posicionEnExplorador:=Find in array:C230(alBWR_recordNumber;$l_ultimoRecNum)
		ARRAY LONGINT:C221($al_FilasSeleccionadas;1)
		$al_FilasSeleccionadas{1}:=$l_posicionEnExplorador
		AL_SetSelect (xALP_Browser;$al_FilasSeleccionadas)
		AL_SetScroll (xALP_Browser;$l_posicionEnExplorador;1)
	Else 
		AL_SetSelect (xALP_Browser;$al_FilasSeleccionadas)
	End if 
	vb_inBrowsingMode:=True:C214
Else 
	$l_ignorar:=CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para agregar registros a esta tabla.")+XSvs_nombreTablaLocal_puntero (yBWR_currentTable))
End if 




