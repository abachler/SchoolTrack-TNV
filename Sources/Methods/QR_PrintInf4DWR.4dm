//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 12-06-18, 09:42:22
  // ----------------------------------------------------
  // Método: QR_PrintInf4DWR
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_LONGINT:C283($1;$l_recNumInforme)
C_TEXT:C284($2;$t_destinoImpresion;$3;$t_rutaArchivoImpresion)
C_BOOLEAN:C305($b_printSettings;$4)
C_BLOB:C604($x_blob;$x_printSettings)
C_LONGINT:C283($l_refArea4DWR;$l_refAreaOffscreen;$l_tabla)
C_POINTER:C301($y_tabla)

$l_recNumInforme:=$1
$t_destinoImpresion:=$2
$t_rutaArchivoImpresion:=$3
$b_printSettings:=$4

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

SET MENU BAR:C67("XS_Edicion")

READ ONLY:C145([xShell_Reports:54])
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$t_nombreInforme:=[xShell_Reports:54]FormName:17
$l_tabla:=Abs:C99([xShell_Reports:54]MainTable:3)
$y_tabla:=Table:C252($l_tabla)

Case of 
	: ($t_destinoImpresion="printer")
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		If ($b_printSettings)
			WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);wr with print settings dialog:K12011:39)
		Else 
			WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);wr no print settings dialog:K12011:38)
		End if 
		
	: ($t_destinoImpresion="preview")
		
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd print preview:K12007:18)
		
	: ($t_destinoImpresion="pdf")
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		WR SET PRINT OPTION:P12000:173 ($l_refArea4DWR;wr destination option:K12010:9;3;0;$t_rutaArchivoImpresion)
		WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);wr no print settings dialog:K12011:38)
		
	: ($t_destinoImpresion="html")
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
		WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;vt_nombreDoc;wr HTML 4 document:K12013:9)
		
	: ($t_destinoImpresion="txt")
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
		WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;vt_nombreDoc;wr RTF document:K12013:3)
		
End case 

WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
