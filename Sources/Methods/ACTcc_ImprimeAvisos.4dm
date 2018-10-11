//%attributes = {}
  //ACTcc_ImprimeAvisos

C_LONGINT:C283($table)

  //Las opciones son 1: Imprimir despues de emitir y 2: Imprimir un rango de fechas
  //con estas opciones seleccionamos los avisos a imprimir y luego lo hacemos

$opcion:=$1
  //$modelo:=atACT_ModelosAviso{atACT_ModelosAviso}
If (Count parameters:C259=4)
	ARRAY LONGINT:C221(alACT_AvisosImprimir;0)
	xBlob:=$2
	BLOB_Blob2Vars (->xBlob;0;->alACT_AvisosImprimir)
	$modelo:=$3
	bHidePrintSettings:=$4
Else 
	$modelo:=atACT_ModelosAviso{atACT_ModelosAviso}
End if 
Case of 
	: ($opcion=1)
		$Table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=$modelo)
		$reportRecNum:=Record number:C243([xShell_Reports:54])
		READ ONLY:C145(*)
		GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
		$reportName:=[xShell_Reports:54]FormName:17
		$specialConfig:=[xShell_Reports:54]SpecialParameter:18
		$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
		$tablePointer:=Table:C252($tableNumber)
		yBWR_currentTable:=$tablePointer
		xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
		vlSR_RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
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
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alACT_AvisosImprimir)
		ACTac_Sort4Printing 
		AT_Initialize (->alACT_AvisosImprimir)
		  //COPY NAMED SELECTION([ACT_Avisos_de_Cobranza];"◊Editions")//20160802 RCH
	: ($opcion=2)
		$modelo:=atACT_ModelosAviso{atACT_ModelosAviso}
		$mes1:=Find in array:C230(aMeses;vs1)
		$mes2:=Find in array:C230(aMeses;vs2)
		$year:=vdACT_AñoAviso
		CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1)
		KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$year;*)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6>=$mes1;*)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6<=$mes2)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ACTac_Sort4Printing 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		  //COPY NAMED SELECTION([ACT_Avisos_de_Cobranza];"◊Editions") //20160802 RCH
End case 
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	$Table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
	QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=$modelo)
	If (IT_AltKeyIsDown )
		vtQR_CurrentReportType:="gSR2"
		vyQR_TablePointer:=->[ACT_Avisos_de_Cobranza:124]
		QR_ImprimeInformeSRP (Record number:C243([xShell_Reports:54]);"html")
	Else 
		$dh:=ACTac_ImpresionAvisos (Record number:C243([xShell_Reports:54]))
		  //If ($dh=-1)//20160802 RCH
		  //QR_ImprimeInformeSRP (Record number([xShell_Reports]))
		  //End if 
	End if 
Else 
	CD_Dlog (0;__ ("No hay avisos para las cuentas y el período seleccionados."))
End if 