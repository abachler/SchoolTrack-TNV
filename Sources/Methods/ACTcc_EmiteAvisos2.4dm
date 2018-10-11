//%attributes = {}
  //ACTcc_EmiteAvisos2

ALERT:C41("Nos metimos al proceso de emision")
C_LONGINT:C283($table)
ARRAY LONGINT:C221(aLong1;0)

ACTinit_LoadPrefs 
ALERT:C41("Cargamos preferencias")
$locked:=False:C215
xBlob:=$1
BLOB_Blob2Vars (->xBlob;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores)
ALERT:C41("Leimos el blob")
Case of 
		
	: (b1=1)
		
		ACTcc_EmisionAvisos (1;Generar)
		
		$Table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=atACT_ModelosAviso{atACT_ModelosAviso})
		
		$reportRecNum:=Record number:C243([xShell_Reports:54])
		
		READ ONLY:C145(*)
		GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
		$reportName:=[xShell_Reports:54]FormName:17
		$specialConfig:=[xShell_Reports:54]SpecialParameter:18
		$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
		$tablePointer:=Table:C252($tableNumber)
		yBWR_currentTable:=$tablePointer
		xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
		
		If (bHidePrintSettings=0)
			$err:=SR Page Setup (xSR_ReportBlob)
			If ($err=1)
				READ WRITE:C146([xShell_Reports:54])
				LOAD RECORD:C52([xShell_Reports:54])
				[xShell_Reports:54]xReportData_:29:=xSR_ReportBlob
				SAVE RECORD:C53([xShell_Reports:54])
				KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			End if 
		End if 
		
		ACTcc_ImprimeAvisos (1)
		
	: (b2=1)
		
		ACTcc_EmisionAvisos (2;Generar)
		
	: (b3=1)
		
		ACTcc_ImprimeAvisos (2)
		
End case 

FLUSH CACHE:C297