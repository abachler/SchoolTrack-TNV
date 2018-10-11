//%attributes = {}
  //QR_RestoreFromArchive

If (False:C215)
	  // Procédure : dfn SaveModels
	  // Created by: Alberto Bächler
	  // Date creation: Junio de 23, 1994
	  // Date modifi: Junio de 23, 1994  
	  //____________________
	  // Comments:
	  // Save file Modelos
End if 

C_TEXT:C284($filename;$t_nombre)
C_LONGINT:C283($tableNumber;$l_cont;$l_cont)


$tableNumber:=Table:C252(->[xShell_Reports:54])
$fileName:=xfGetFileName ("Restaurar desde:";"")
If ($fileName#"")
	SET CHANNEL:C77(10;$fileName)
	RECEIVE VARIABLE:C81($tableNumber)
	If ($tableNumber=Table:C252(->[xShell_Reports:54]))
		RECEIVE RECORD:C79([xShell_Reports:54])
		[xShell_Reports:54]ID:7:=0
		If ([xShell_Reports:54]Propietary:9#-1)
			[xShell_Reports:54]Propietary:9:=<>lUSR_CurrentUserID
		End if 
		If (([xShell_Reports:54]ReportType:2="gSR2") & (BLOB size:C605([xShell_Reports:54]xReportData_:29)=0))
			[xShell_Reports:54]xReportData_:29:=SR Report To BLOB ([xShell_Reports:54]pSuperReportData:12)
		End if 
		  //[xShell_Reports]Auto_UUID:=Generate UUID  // 20140205 ASM al importar el reporte se duplicaba el uuid adrian se hizo un cambio optimizado
		  //20140218 RCH Cuando se restauraba un reporte que ya existia, el registro no se guardaba por la llave duplicada.
		If (Find in field:C653([xShell_Reports:54]Auto_UUID:49;[xShell_Reports:54]Auto_UUID:49)#-1)
			[xShell_Reports:54]Auto_UUID:49:=Generate UUID:C1066
		End if 
		
		  //ABC187033
		$l_cont:=1
		$t_nombre:=[xShell_Reports:54]ReportName:26
		While (Find in field:C653([xShell_Reports:54]ReportName:26;$t_nombre)>0)
			  //$t_nombre:=[xShell_Reports]ReportName
			$t_nombre:=[xShell_Reports:54]ReportName:26+String:C10($l_cont)
			$l_cont:=$l_cont+1
		End while 
		[xShell_Reports:54]ReportName:26:=$t_nombre
		SAVE RECORD:C53([xShell_Reports:54])
		
		If ([xShell_Reports:54]Converted_v2003:19=False:C215)
			QR_DocReport2Blob 
		End if 
		$recNum:=Record number:C243([xShell_Reports:54])
		$name:=[xShell_Reports:54]ReportName:26
		  //If ([xShell_Reports]MainTable=Table(vyQR_TablePointer))
		If ([xShell_Reports:54]MainTable:3=Table:C252(vyQR_TablePointer)) & ([xShell_Reports:54]Modulo:41=vsBWR_CurrentModule)  //20130904 ASM  ticket 124893.
			Case of 
				: ([xShell_Reports:54]ReportType:2="4DFO")  // 4D Form
					$icon:=Use PicRef:K28:4+27513
					APPEND TO LIST:C376(hl_Reports_4DFORMS;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_4DFORMS;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_4DFORMS;>)
					_O_REDRAW LIST:C382(hl_Reports_4DFORMS)
					POST KEY:C465(Character code:C91("1");256)
					
					
				: ([xShell_Reports:54]ReportType:2="gSR2")  // SuperReport
					$icon:=Use PicRef:K28:4+27512
					APPEND TO LIST:C376(hl_Reports_SRP;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_SRP;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_SRP;>)
					_O_REDRAW LIST:C382(hl_Reports_SRP)
					POST KEY:C465(Character code:C91("2");256)
					
				: ([xShell_Reports:54]ReportType:2="4DSE")  //Quick Report
					$icon:=Use PicRef:K28:4+27514
					APPEND TO LIST:C376(hl_Reports_QR;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_QR;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_QR;>)
					_O_REDRAW LIST:C382(hl_Reports_QR)
					POST KEY:C465(Character code:C91("3");256)
					
				: ([xShell_Reports:54]ReportType:2="4DET")  //Etiquetas
					$icon:=Use PicRef:K28:4+27516
					APPEND TO LIST:C376(hl_Reports_LB;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_LB;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_LB;>)
					_O_REDRAW LIST:C382(hl_Reports_LB)
					POST KEY:C465(Character code:C91("4");256)
					
				: ([xShell_Reports:54]ReportType:2="4DWR")  //4D Write
					$icon:=Use PicRef:K28:4+12041
					APPEND TO LIST:C376(hl_Reports_WR;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_WR;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_WR;>)
					_O_REDRAW LIST:C382(hl_Reports_WR)
					POST KEY:C465(Character code:C91("5");256)
					
				: ([xShell_Reports:54]ReportType:2="4DDW")  //4D Draw
					$icon:=Use PicRef:K28:4+12035
					APPEND TO LIST:C376(hl_Reports_DW;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_DW;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_DW;>)
					_O_REDRAW LIST:C382(hl_Reports_DW)
					POST KEY:C465(Character code:C91("7");256)
					
				: ([xShell_Reports:54]ReportType:2="4DVW")  //4D View
					$icon:=Use PicRef:K28:4+12040
					APPEND TO LIST:C376(hl_Reports_VW;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_VW;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_VW;>)
					_O_REDRAW LIST:C382(hl_Reports_VW)
					POST KEY:C465(Character code:C91("6");256)
					
				: ([xShell_Reports:54]ReportType:2="4DCT")  //4D Chart
					$icon:=Use PicRef:K28:4+12038
					APPEND TO LIST:C376(hl_Reports_CT;$name;$recNum)
					SET LIST ITEM PROPERTIES:C386(hl_Reports_CT;$recNum;True:C214;0;$icon)
					SORT LIST:C391(hl_Reports_CT;>)
					_O_REDRAW LIST:C382(hl_Reports_CT)
					POST KEY:C465(Character code:C91("8");256)
			End case 
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			
			SET LIST ITEM PROPERTIES:C386(hl_informes;$recNum;True:C214;0;$icon)
			SORT LIST:C391(hl_informes;>)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_Informes;$recNum)
			_O_REDRAW LIST:C382(hl_informes)
			QR_LoadSelectedReport 
			
		Else 
			  //$tableName:=Table name([xShell_Reports]MainTable)
			$tableName:=Table name:C256([xShell_Reports:54]MainTable:3)+__ (" del módulo ")+[xShell_Reports:54]Modulo:41
			CD_Dlog (0;Replace string:C233(__ ("El modelo seleccionado no tiene relación con el archivo seleccionado.\r\rEl modelo fue restaurado pero sólo aparecerá en la lista de modelos del archivo ˆ0.");__ ("ˆ0");$tableName))
		End if 
	Else 
		CD_Dlog (0;__ ("El archivo seleccionado no contiene ningún informe válido.\r\rPor favor seleccione un archivo de modelos de informes."))
	End if 
	QR_LoadSelectedReport 
	SET CHANNEL:C77(11)
End if 

