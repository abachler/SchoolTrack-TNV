READ WRITE:C146([xShell_Tables:51])
LOAD RECORD:C52([xShell_Tables:51])

$l_numeroTabla:=[xShell_Tables:51]NumeroDeTabla:5
If (Is table number valid:C999($l_numeroTabla))
	$l_CamposEnTabla:=Get last field number:C255($l_numeroTabla)
	For ($l_numeroCampo;1;$l_CamposEnTabla)
		  //20130321 RCH
		If (Is field number valid:C1000($l_numeroTabla;$l_numeroCampo))
			XSvs_ActualizaRelaciones (Field:C253($l_numeroTabla;$l_numeroCampo))
		End if 
	End for 
End if 
KRL_UnloadReadOnly (->[xShell_Fields:52])

AL_UpdateArrays (xALP_Fields;0)
XS_LoadFields ($l_numeroTabla)
AL_UpdateArrays (xALP_Fields;-2)
VS_RelationsALPsettings ($l_numeroTabla)