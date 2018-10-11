//%attributes = {}
  //QR_ArchiveDBReports

$altdown:=(Macintosh option down:C545 | Windows Alt down:C563)
$folderName:=Select folder:C670(__ ("Seleccione la carpeta donde desea guardar los informes..."))
If (OK=1)
	$exist:=Test path name:C476($folderName)
	If ($exist<0)
		SYS_CreateFolder ($folderName)
	Else 
		OK:=1
	End if 
	If (Ok=1)
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]Propietary:9;>;0;*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]IsStandard:38;=;True:C214)
		$records:=Records in selection:C76([xShell_Reports:54])
		If ($altDown)
			$ok:=CD_Dlog (0;__ ("¿Desea realmente eliminar los ")+String:C10(Records in selection:C76([xShell_Reports:54]))+__ (" después de ser archivados en ")+$folderName+__ ("?");__ ("");__ ("Si");__ ("No"))
			If ($ok#1)
				$altDown:=False:C215
			End if 
		Else 
			CD_Dlog (0;__ ("Los informes serán archivados en ")+$folderName)
		End if 
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando Informes"))
		While (Not:C34(End selection:C36([xShell_Reports:54])))
			$folder:=$folderName+Folder separator:K24:12+Table name:C256([xShell_Reports:54]MainTable:3)
			$exist:=Test path name:C476($folder)
			If ($exist<0)
				SYS_CreateFolder ($folder)
			Else 
				ok:=1
			End if 
			If (ok=1)
				Case of 
					: ([xShell_Reports:54]ReportType:2="4DSE")
						$folder:=$folderName+Folder separator:K24:12+Table name:C256([xShell_Reports:54]MainTable:3)+Folder separator:K24:12+"Semi automáticos"
					: ([xShell_Reports:54]ReportType:2="gSR2")
						$folder:=$folderName+Folder separator:K24:12+Table name:C256([xShell_Reports:54]MainTable:3)+Folder separator:K24:12+"SuperReport"
					: ([xShell_Reports:54]ReportType:2="4DET")
						$folder:=$folderName+Folder separator:K24:12+Table name:C256([xShell_Reports:54]MainTable:3)+Folder separator:K24:12+"Etiquetas"
					: ([xShell_Reports:54]ReportType:2="4DPV")
						$folder:=$folderName+Folder separator:K24:12+Table name:C256([xShell_Reports:54]MainTable:3)+Folder separator:K24:12+"PowerView"
					: ([xShell_Reports:54]ReportType:2="4DWR")
						$folder:=$folderName+Folder separator:K24:12+Table name:C256([xShell_Reports:54]MainTable:3)+Folder separator:K24:12+"4D Write"
					Else 
						$folder:=""
				End case 
				If ($folder#"")
					$exist:=Test path name:C476($folder)
					If ($exist<0)
						SYS_CreateFolder ($folder)
					Else 
						ok:=1
					End if 
					If (Ok=1)
						
						$fileName:=$folder+Folder separator:K24:12+[xShell_Reports:54]ReportName:26+".txt"
						$tableNumber:=[xShell_Reports:54]MainTable:3
						SET CHANNEL:C77(12;$fileName)
						SEND VARIABLE:C80($tableNumber)
						SEND RECORD:C78([xShell_Reports:54])
						SET CHANNEL:C77(11)
					End if 
				End if 
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xShell_Reports:54])/Records in selection:C76([xShell_Reports:54]);__ ("Archivando Informes"))
			NEXT RECORD:C51([xShell_Reports:54])
		End while 
		If ($altDown)
			READ WRITE:C146([xShell_Reports:54])
			DELETE SELECTION:C66([xShell_Reports:54])
			READ ONLY:C145([xShell_Reports:54])
		End if 
		
		CD_Dlog (0;String:C10($records)+__ (" informes fueron archivados en ")+$folderName)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		QR_BuildReportHList 
	End if 
End if 