$l_choice:=Pop up menu:C542("Copiar;Exportar a Microsoft Excel...")

Case of 
	: ($l_choice=1)
		$t_text:=AT_Arrays2Text ("\r";"\t";->al_TableNums;->at_TableNames;->al_CountRecordsBeforeExport;->al_CountRecordsAfterImport)
		SET TEXT TO PASTEBOARD:C523($t_text)
		
	: ($l_choice=2)
		$t_Path:=SYS_SelectFolder ("Seleccione la carpeta para guardar el documento "+__ ("DiferenciasPostReconstrucción.xls"))
		If ($t_path#"")
			$t_path:=$t_path+__ ("DiferenciasPostReconstrucción.xls")
			$h_ref:=Create document:C266($t_path;".xls")
			If ($h_ref#?00:00:00?)
				$record:=__ ("# tabla")+"\t"+__ ("Tablas")+"\t"+__ ("Registros Exportados")+"\t"+__ ("Registros Importados")+"\r"
				SEND PACKET:C103($h_ref;$record)
				For ($i;1;Size of array:C274(al_TableNums))
					$record:=String:C10(al_TableNums{$i})+"\t"+at_TableNames{$i}+"\t"+String:C10(al_CountRecordsBeforeExport{$i})+"\t"+String:C10(al_CountRecordsAfterImport{$i})+"\r"
					SEND PACKET:C103($h_ref;$record)
				End for 
				CLOSE DOCUMENT:C267($h_ref)
			End if 
		End if 
End case 