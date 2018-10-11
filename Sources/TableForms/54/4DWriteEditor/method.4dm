Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
			WR BLOB TO AREA:P12000:142 (xWrite;[xShell_Reports:54]xReportData_:29)
		End if 
		WR LOCK COMMAND:P12000:114 (xWrite;wr cmd save as template:K12007:15;1)
		WR LOCK COMMAND:P12000:114 (xWrite;wr cmd table wizard:K12007:54;1)
		WR ON COMMAND:P12000:116 (xWrite;"WR_ExecuteCallBack")
		WR SET AREA PROPERTY:P12000:137 (xWrite;wr confirm dialog:K12004:1;0)
		  //WR ON EVENT (xWrite;wr on right click ;"WR_HandleRightClick")
		  //WR ON EVENT (xWrite;wr on double click ;"WR_HandleRightClick")
		WR ON ERROR:P12000:52 ("WR_HandleErrors")
		WR_BuildExpressionsLists 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		WR GET AREA PROPERTY:P12000:138 (xWrite;wr modified:K12004:4;$Modified;$stringValue)
		If ($modified=1)
			$result:=CD_Dlog (0;__ ("Usted modificó este modelo de documento.\r\r¿Desea guardar las modificaciones antes de cerrar?");__ ("");__ ("Guardar");__ ("No guardar");__ ("Cancelar"))
			Case of 
				: ($result=1)
					QR_SaveReport 
					ACCEPT:C269
				: ($result=2)
					CANCEL:C270
				: ($result=3)
					  //nada
			End case 
		Else 
			CANCEL:C270
		End if 
		HL_ClearList (hl_TablesFields;hl_Methods;hl_Variables)
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 