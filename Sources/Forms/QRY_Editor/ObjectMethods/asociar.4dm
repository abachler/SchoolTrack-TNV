atQRY_NombreVirtualCampo:=0
atQRY_Conector_Literal:=0
atQRY_Operador_Literal:=0
ayQRY_Campos:=0
atQRY_NombreInternoCampo:=0
atQRY_ValorLiteral:=0
  //While ((aSFSeaEd{Size of array(aSFSeaEd)}="") | (aSrchDelim{Size of array(aSFSeaEd)}=""))
  //AT_Delete (Size of array(aSFSeaEd);1;->aSrchOP;->aSFSeaEd;->aSrchDelim;->aSrchValue;->aSrchPtr;->aSrchField)
  //End while 
For ($i;Size of array:C274(atQRY_NombreVirtualCampo);1;-1)
	If ((atQRY_NombreVirtualCampo{$i}="") | (atQRY_Operador_Literal{$i}=""))
		AT_Delete ($i;1;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->ayQRY_Campos;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo)
	End if 
End for 


