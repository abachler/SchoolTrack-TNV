$path:=xfGetFileName 
If (Test path name:C476($path)=1)
	$ref:=Open document:C264($path;Read mode:K24:5)
	If ($ref#?00:00:00?)
		$size:=SYS_GetFileSize ($path)
		ARRAY TEXT:C222(aImportedItem;0)
		vText:=""
		$length:=0
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros para la lista..."))
		RECEIVE PACKET:C104($ref;vText;"\r")
		vText1:=ST_CleanString (vText)
		If (vText1#"")
			AT_Insert (1;1;->aImportedItem)
			aImportedItem{1}:=vText1
			$length:=$length+Length:C16(vText)+1
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;__ ("Importando registros para la lista..."))
			Repeat 
				RECEIVE PACKET:C104($ref;vText;"\r")
				vText1:=ST_CleanString (vText)
				If (vText1#"")
					AT_Insert (1;1;->aImportedItem)
					aImportedItem{1}:=vText1
				End if 
				$length:=$length+Length:C16(vText)+1
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;__ ("Importando registros para la lista..."))
			Until (vText="")
		End if 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		If (Size of array:C274(aImportedItem)>0)
			AL_UpdateArrays (xALP_Tables;0)
			For ($i;1;Size of array:C274(aImportedItem))
				$found:=Find in array:C230(sElements;aImportedItem{$i})
				If ($found=-1)
					AT_Insert (1;1;->sElements)
					sElements{1}:=aImportedItem{$i}
				End if 
			End for 
			SORT ARRAY:C229(sElements;>)
			changed:=True:C214
			AL_UpdateArrays (xALP_Tables;-2)
		End if 
		CLOSE DOCUMENT:C267($ref)
		AT_Initialize (->aImportedItem)
	Else 
		CD_Dlog (0;__ ("Error al leer el archivo."))
	End if 
End if 

TBL_SetListApparence 