//%attributes = {}
  //BBLio_ExpMicroLif


If (<>gUsaMarc)
	READ ONLY:C145([BBL_Items:61])
	READ ONLY:C145([BBL_ItemMarcFields:205])
	READ ONLY:C145([xxBBL_MarcRecordStructure:75])
	$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
	COPY SET:C600($set;"CurrentBBLItemsSel")
	
	WDW_OpenFormWindow (->[BBL_ItemMarcFields:205];"MicroLifExport";0;8;__ ("Exportación MicroLif"))
	DIALOG:C40([BBL_ItemMarcFields:205];"MicroLifExport")
	CLOSE WINDOW:C154
	If (ok=1)
		Case of 
			: (fTodos=1)
				USE SET:C118("exportarTodos")
			: (fListado=1)
				USE SET:C118("CurrentBBLItemsSel")
			: (fBuscar=1)
				USE SET:C118("exportarBuscar")
		End case 
		$dirPath:=xfGetDirName ("Por favor seleccione el directorio para guardar el archivo exportado")
		If ($dirPath#"")
			$cr:="\r"
			$EOL:=Char:C90(94)
			$EOR:=Char:C90(96)
			$firstHdrLine:="LDR00000cam  2200000 a 4500"+$EOL+$cr
			$secondHrdLine:="008000000b        xx     j      000 1 eng  "+$EOL+$cr
			$docPath:=$dirPath+"MicroLIF.txt"
			$ref:=Create document:C266($docPath;"TXT")
			If (ok=1)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando registros..."))
				While (Not:C34(End selection:C36([BBL_Items:61])))
					If (rWin=1)
						SEND PACKET:C103($ref;_O_Mac to Win:C463($firstHdrLine))
						SEND PACKET:C103($ref;_O_Mac to Win:C463($secondHrdLine))
					Else 
						SEND PACKET:C103($ref;$firstHdrLine)
						SEND PACKET:C103($ref;$secondHrdLine)
					End if 
					QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Item:1=[BBL_Items:61]Numero:1)
					While (Not:C34(End selection:C36([BBL_ItemMarcFields:205])))
						$code:=Substring:C12([BBL_ItemMarcFields:205]SubFieldRef:3;1;3)
						$subCode:=Substring:C12([BBL_ItemMarcFields:205]SubFieldRef:3;4;1)
						$dato:=[BBL_ItemMarcFields:205]Dato:6
						If (Selected record number:C246([BBL_ItemMarcFields:205])#Records in selection:C76([BBL_ItemMarcFields:205]))
							$line:=$code+"  _"+$subCode+$dato+$EOL+$cr
						Else 
							$line:=$code+"  _"+$subCode+$dato+$EOL+$EOR+$cr
						End if 
						If (rWin=1)
							SEND PACKET:C103($ref;_O_Mac to Win:C463($line))
						Else 
							SEND PACKET:C103($ref;$line)
						End if 
						NEXT RECORD:C51([BBL_ItemMarcFields:205])
					End while 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([BBL_Items:61])/Records in selection:C76([BBL_Items:61]))
					NEXT RECORD:C51([BBL_Items:61])
				End while 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				CLOSE DOCUMENT:C267($ref)
			End if 
		End if 
	End if 
	COPY SET:C600("CurrentBBLItemsSel";$set)
	USE SET:C118($set)
	SET_ClearSets ("CurrentBBLItemsSel";"exportarTodos";"exportarBuscar")
Else 
	CD_Dlog (0;__ ("No hay información MARC en la base de datos ya que no tiene seleccionada la opción de usar registros MARC en Configuración/Generales."))
End if 