  //Método de Objeto: [xShell_Dialogs].XS_MASTER_InputForms.bBWR_PrintPopup

If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
	If (Count list items:C380(hl_reportsList)>0)
		atQR_FormReportNames:=0
		alQR_FormReportRecNums:=0
		SELECT LIST ITEMS BY POSITION:C381(hl_reportsList;0)
		WDW_OpenDialogInDrawer (->[xShell_Dialogs:114];"XS_InputFormReportList")
		If ((ok=1) & (alQR_FormReportRecNums>0))
			KRL_GotoRecord (->[xShell_Reports:54];alQR_FormReportRecNums{vl_choice};False:C215)
			$reportIsAllowed:=QR_IsReportAllowed ([xShell_Reports:54]ID:7)
			If ($reportIsAllowed)
				vyQR_TablePointer:=yBWR_currentTable  //20170309 RCH Se agrega eliminación de selección
				$l_recNumInforme:=alQR_FormReportRecNums{vl_choice}
				  //$l_recNum:=Record number([ACT_Boletas])  //20150315 RCH
				PUSH RECORD:C176(yBWR_currentTable->)  //20170325 RCH Se hace cambio para no perder el registro cuando se intenta imprimir desde la ficha. Intento solucionar mi tontera...
				dhQR_PrePrintForm 
				If (Macintosh option down:C545 | Windows Alt down:C563)
					QR_ImprimeInforme ($l_recNumInforme;"preview")
				Else 
					QR_ImprimeInforme ($l_recNumInforme;"printer")
				End if 
				POP RECORD:C177(yBWR_currentTable->)
				ONE RECORD SELECT:C189(yBWR_currentTable->)  //20170325 RCH Se hace cambio para no perder el registro cuando se intenta imprimir desde la ficha
			Else 
				CD_Dlog (0;__ ("Usted o el grupo al que pertenece no tiene permisos para utilizar este informe."))
			End if 
		End if 
	End if 
End if 

