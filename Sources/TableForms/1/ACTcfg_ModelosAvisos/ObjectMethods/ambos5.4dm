C_TEXT:C284($fileName)
C_LONGINT:C283($tableNumber)

$tableNumber:=0
$filename:=xfGetFileName ("Cargar desde ";"")

If ($fileName#"")
	SET CHANNEL:C77(10;$filename)
	RECEIVE VARIABLE:C81($tablenumber)
	If ($tablenumber=Table:C252(->[xShell_Reports:54]))
		RECEIVE RECORD:C79([xShell_Reports:54])
		$index:=1
		$sName:=[xShell_Reports:54]ReportName:26
		While (Find in field:C653([xShell_Reports:54]ReportName:26;$sName)>-1)
			$sName:=[xShell_Reports:54]ReportName:26+" "+String:C10($index)
			$index:=$index+1
		End while 
		
		  //20131104 ASM. Para no repetir el id del reporte
		$sID:=[xShell_Reports:54]ID:7
		While (Find in field:C653([xShell_Reports:54]ID:7;$sID)>-1)
			$sID:=SQ_SeqNumber (->[xShell_Reports:54]ID:7)
		End while 
		[xShell_Reports:54]ID:7:=$sID
		
		  //$reportID:=[xShell_Reports]ID
		[xShell_Reports:54]ReportName:26:=$sName
		If (([xShell_Reports:54]ReportType:2="gSR2") & (BLOB size:C605([xShell_Reports:54]xReportData_:29)=0))
			[xShell_Reports:54]xReportData_:29:=SR Report To BLOB ([xShell_Reports:54]pSuperReportData:12)
		End if 
		[xShell_Reports:54]Auto_UUID:49:=Generate UUID:C1066  // 20140205 ASM al importar el reporte se duplicaba el uuid 
		SAVE RECORD:C53([xShell_Reports:54])
		SET CHANNEL:C77(11)
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
		IT_SetButtonState ((atACT_ModelosAv>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)
	Else 
		CD_Dlog (0;__ ("El archivo seleccionado no contiene ningún informe válido.\r\rPor favor seleccione un archivo de modelos de informes."))
	End if 
End if 