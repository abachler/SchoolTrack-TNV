//%attributes = {}
  //IO_ExportaInformesPropios

  //`xShell, Alberto Bachler
  //Metodo: IO_ExportDatabase
  //Por abachler
  //Creada el 16/10/2003, 08:53:19
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_TEXT:C284($dataFilePath;$3)
C_LONGINT:C283($year;$1;$versionID;$2;$tables;$records;$tableNumber;$fieldNumber)

  //****INICIALIZACIONES****

  //****CUERPO****
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]IsStandard:38;=;False:C215;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]Propietary:9;>;0;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportType:2#"4DFO")


If (Records in selection:C76([xShell_Reports:54])>0)
	SET CHANNEL:C77(12;"")
	If (ok=1)
		ARRAY LONGINT:C221($aRecNum;0)
		LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$aRecNum;"")
		$fileID:="Reports2005"
		$records:=Size of array:C274($aRecNum)
		SEND VARIABLE:C80($fileID)
		SEND VARIABLE:C80($records)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando Informes"))
		$tableNumber:=Table:C252(->[xShell_Reports:54])
		For ($j;1;$records)
			GOTO RECORD:C242([xShell_Reports:54];$aRecNum{$j})
			KRL_SendRecord (->[xShell_Reports:54];True:C214)
			If (Dec:C9($j/50)=0)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/$records;__ ("Exportando informes  (")+String:C10($j)+__ ("/")+String:C10($records)+__ ("registros)"))
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	SET CHANNEL:C77(11)
End if 

  //****LIMPIEZA****




