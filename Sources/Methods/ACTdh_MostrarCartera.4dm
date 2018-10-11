//%attributes = {}
  //ACTdh_MostrarCartera

C_PICTURE:C286(pSave;pCancel;pFirst;pNext;pPrev;pLast;pPrint;pDelete;pInfos)

If (USR_checkRights ("L";yBWR_currentTable))
	ARRAY LONGINT:C221(abrSelect;0)
	$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
	$recNum:=alBWR_recordNumber{abrSelect{1}}
	lBWR_recordNumber:=abrSelect{1}
	
	vbXS_inBrowser:=True:C214
	vlBWR_BrowsingMethod:=BWR Standard Browsing
	READ WRITE:C146(yBWR_currentTable->)
	GOTO RECORD:C242(yBWR_currentTable->;$recNum)
	
	If (Records in selection:C76(yBWR_currentTable->)=0)
		CD_Dlog (0;__ ("El registro ya no existe (fue eliminado por otro usuario)."))
	Else 
		If (vsBWR_selectedTableName="Documentos Depositados")
			vsUbicacion:=[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8
		End if 
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
		If (Records in selection:C76([ACT_Documentos_de_Pago:176])>1)  //si el doc es reemplazado varias veces se generan registros con el mismo id negativo
			QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5)
		End if 
		dhBWR_TableInitialisations 
		WDW_OpenFormWindow (->[ACT_Documentos_de_Pago:176];"Input";2;4;__ (""))
		FORM SET INPUT:C55([ACT_Documentos_de_Pago:176];"Input")
		  //MODIFY RECORD([ACT_Documentos_de_Pago];*)
		BWR_ModifyRecord (->[ACT_Documentos_de_Pago:176];"Input")
		CLOSE WINDOW:C154
		UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
		UNLOAD RECORD:C212([ACT_Pagos:172])
		READ ONLY:C145([ACT_Documentos_de_Pago:176])
		READ ONLY:C145([ACT_Pagos:172])
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		KRL_UnloadReadOnly (->[ACT_Pagos:172])
		$size:=Size of array:C274(alBWR_recordNumber)
		$pos:=lBWR_recordNumber
		If ($pos>Size of array:C274(alBWR_recordNumber))
			$pos:=$size
		End if 
		AL_SetScroll (xALP_Browser;$pos;1)
		ARRAY LONGINT:C221(abrSelect;1)
		aBrSelect{1}:=$pos
		AL_SetSelect (xALP_Browser;aBrSelect)
	End if 
	KRL_ReloadAsReadOnly (yBWR_currentTable)
Else 
	  //$msg:=RP_GetIdxString (20001;14)+◊aNombFile{Table(yBWR_currentTable)}
	$r:=CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para ver registros de esta tabla.")+XSvs_nombreTablaLocal_puntero (yBWR_currentTable))
End if 