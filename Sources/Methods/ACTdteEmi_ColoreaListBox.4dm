//%attributes = {}
  //ACTdteEmi_ColoreaListBox

C_LONGINT:C283($l_indice;$l_bit)
ARRAY LONGINT:C221(alACT_ColorDteEmi;0)

For ($l_indice;1;Size of array:C274(alACT_IdDteEmi))
	$l_bit:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->alACT_IdDteEmi{$l_indice};->[ACT_Boletas:181]DTE_estado_id:24)
	If ($l_bit ?? 4)
		APPEND TO ARRAY:C911(alACT_ColorDteEmi;0x00FF0000)
	Else 
		APPEND TO ARRAY:C911(alACT_ColorDteEmi;0x0000)
	End if 
	
End for 

OBJECT SET COLOR:C271(atACT_PDFEmi;Blue:K11:7)
OBJECT SET COLOR:C271(atACT_XMLEmi;Blue:K11:7)
OBJECT SET COLOR:C271(atACT_PDFCCEmi;Blue:K11:7)