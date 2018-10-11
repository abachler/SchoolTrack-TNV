//%attributes = {}
  //QR_RestoreFromFolder

C_TEXT:C284($filename)
C_LONGINT:C283($tableNumber)

$userName:=CD_Request (__ ("Nombre del creador de los informes:");__ ("Aceptar");__ ("Cancelar");__ (""))
If (($userName#"") & (ok=1))
	TRACE:C157
	$tableNumber:=Table:C252(->[xShell_Reports:54])
	$vt_Foldername:=xfGetDirName ("Seleccione el directorio donde se encuentran los informes")
	If ($vt_Foldername#"")
		ARRAY TEXT:C222($tempTextArray;0)
		SYS_DocumentList ($vt_Foldername;->$tempTextArray)
		For ($i;1;Size of array:C274($tempTextArray))
			$fileName:=$vt_Foldername+$tempTextArray{$i}
			SET CHANNEL:C77(10;$fileName)
			RECEIVE VARIABLE:C81($tableNumber)
			If ($tableNumber=Table:C252(->[xShell_Reports:54]))
				RECEIVE RECORD:C79([xShell_Reports:54])
				$informe:=[xShell_Reports:54]ReportName:26
				$table:=[xShell_Reports:54]MainTable:3
				PUSH RECORD:C176([xShell_Reports:54])
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26=$informe;*)
				QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]MainTable:3=$table)
				$index:=1
				While (Records in selection:C76([xShell_Reports:54])#0)
					$informe:=$informe+"_"+String:C10($index)
					QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26=$informe;*)
					QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]MainTable:3=$table)
					$index:=$index+1
				End while 
				POP RECORD:C177([xShell_Reports:54])
				[xShell_Reports:54]ID:7:=0
				[xShell_Reports:54]ReportName:26:=$informe
				[xShell_Reports:54]Creacion_Usuario:34:=$userName
				[xShell_Reports:54]IsStandard:38:=True:C214
				[xShell_Reports:54]Auto_UUID:49:=Generate UUID:C1066  // 20140205 ASM al importar el reporte se duplicaba el uuid 
				SAVE RECORD:C53([xShell_Reports:54])
			End if 
			SET CHANNEL:C77(11)
		End for 
	End if 
Else 
	CD_Dlog (0;__ ("Debes ingresar el nombre del creador."))
End if 


