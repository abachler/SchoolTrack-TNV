Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
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
		
		$err:=ALP_DefaultColSettings (xALP_ColegiosAnteriores;1;"aColegiosAnteriores";__ ("Colegios");240)
		ALP_SetDefaultAppareance (xALP_ColegiosAnteriores;9;1;6;1;8)
		AL_SetScroll (xALP_ColegiosAnteriores;0;-3)
		AL_SetDrgOpts (xALP_ColegiosAnteriores;0;30;0)
		AL_SetDrgSrc (xALP_ColegiosAnteriores;1;String:C10(xALP_ColegiosAnteriores))
		AL_SetDrgDst (xALP_ColegiosAnteriores;1;String:C10(xALP_ColegiosGrupo))
		AL_SetLine (xALP_ColegiosAnteriores;0)
		
		$err:=ALP_DefaultColSettings (xALP_ColegiosGrupo;1;"aColegiosGrupo";__ ("Colegios Grupo");240)
		ALP_SetDefaultAppareance (xALP_ColegiosGrupo;9;1;6;1;8)
		AL_SetScroll (xALP_ColegiosGrupo;0;-3)
		AL_SetDrgOpts (xALP_ColegiosGrupo;0;30;0)
		AL_SetDrgSrc (xALP_ColegiosGrupo;1;String:C10(xALP_ColegiosGrupo))
		AL_SetDrgDst (xALP_ColegiosGrupo;1;String:C10(xALP_ColegiosGrupo);String:C10(xALP_ColegiosAnteriores))
		AL_SetLine (xALP_ColegiosGrupo;0)
		
		_O_DISABLE BUTTON:C193(bAddNewGroupSchool)
		vtNuevoColegioGrupo:=""
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 