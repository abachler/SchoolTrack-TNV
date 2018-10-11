//%attributes = {}
  // XSvs_GeneraRegistroRelaciones()
  // Por: Alberto Bachler: 14/03/13, 09:46:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_CamposEnTabla;$l_numeroCampo;$l_numeroTabla)

ARRAY LONGINT:C221($al_RecNums;0)

ALL RECORDS:C47([xShell_Tables:51])
LONGINT ARRAY FROM SELECTION:C647([xShell_Tables:51];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([xShell_Tables:51];$al_RecNums{$i})
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
End for 
KRL_UnloadReadOnly (->[xShell_Fields:52])

