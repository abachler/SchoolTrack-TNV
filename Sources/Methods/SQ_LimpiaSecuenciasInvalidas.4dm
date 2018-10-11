//%attributes = {}
  // SQ_LimpiaSecuenciasInvalidas()
  // Por: Alberto Bachler: 20/03/13, 08:32:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


  //CREATE SET([xShell_SequenceNumbers];"$secuenciasInvalidas")
CREATE EMPTY SET:C140([xShell_SequenceNumbers:67];"$secuenciasInvalidas")  //20131127 RCH En el UD_Handler se podia llegar con algun registro cargado y quedaba en el set de registros que se eliminan...
ALL RECORDS:C47([xShell_SequenceNumbers:67])

READ ONLY:C145([xShell_SequenceNumbers:67])
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([xShell_SequenceNumbers:67];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([xShell_SequenceNumbers:67];$al_RecNums{$i})
	If ((Not:C34(Is table number valid:C999([xShell_SequenceNumbers:67]Table_Number:1))) | (Not:C34(Is field number valid:C1000([xShell_SequenceNumbers:67]Table_Number:1;[xShell_SequenceNumbers:67]FieldNumber:4))))
		ADD TO SET:C119([xShell_SequenceNumbers:67];"$secuenciasInvalidas")
	End if 
End for 

USE SET:C118("$secuenciasInvalidas")
KRL_DeleteSelection (->[xShell_SequenceNumbers:67])
KRL_UnloadReadOnly (->[xShell_SequenceNumbers:67])

