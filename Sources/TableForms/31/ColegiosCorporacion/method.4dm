Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(aColegiosGrupo;0)
		ARRAY TEXT:C222(aColegiosAnteriores;0)
		COPY ARRAY:C226(<>aPrevSchool;aColegiosAnteriores)
		C_BLOB:C604(blob)
		SET BLOB SIZE:C606(blob;0)
		BLOB_Variables2Blob (->blob;0;->aColegiosGrupo)
		blob:=PREF_fGetBlob (0;"colegiosgrupo";blob)
		BLOB_Blob2Vars (->blob;0;->aColegiosGrupo)
		
		For ($i;1;Size of array:C274(aColegiosGrupo))
			$found:=Find in array:C230(aColegiosAnteriores;aColegiosGrupo{$i})
			If ($found#-1)
				DELETE FROM ARRAY:C228(aColegiosAnteriores;$found;1)
			End if 
		End for 
		LISTBOX SELECT ROW:C912(lb_ColegiosAnteriores;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lb_ColegiosGrupo;0;lk remove from selection:K53:3)
		_O_DISABLE BUTTON:C193(bAddNewGroupSchool)
		vtNuevoColegioGrupo:=""
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 