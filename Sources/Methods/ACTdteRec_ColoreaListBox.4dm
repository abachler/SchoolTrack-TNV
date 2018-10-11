//%attributes = {}
  //ACTdteRec_ColoreaListBox

C_LONGINT:C283($l_indice;$l_bit)
ARRAY LONGINT:C221(alACT_ColorDteRec;0)

For ($l_indice;1;Size of array:C274(alACT_IdDteRec))
	$l_bit:=KRL_GetNumericFieldData (->[ACT_DTEs_Recibidos:238]id:1;->alACT_IdDteRec{$l_indice};->[ACT_DTEs_Recibidos:238]estado_dte:14)
	If ($l_bit ?? 3)
		APPEND TO ARRAY:C911(alACT_ColorDteRec;0x00FF0000)
	Else 
		APPEND TO ARRAY:C911(alACT_ColorDteRec;0x0000)
	End if 
	
End for 

OBJECT SET COLOR:C271(atACT_PDF;Blue:K11:7)