ARRAY LONGINT:C221($l_PosElemBorrar;0)
atQRY_NombreVirtualCampo:=0
atQRY_Conector_Literal:=0
atQRY_Operador_Literal:=0
ayQRY_Campos:=0
atQRY_NombreInternoCampo:=0
atQRY_ValorLiteral:=0
  //While ((aSFSeaEd{Size of array(aSFSeaEd)}="") | (aSrchDelim{Size of array(aSFSeaEd)}=""))
  //AT_Delete (Size of array(aSFSeaEd);1;->aSrchOP;->aSFSeaEd;->aSrchDelim;->aSrchValue;->aSrchPtr;->aSrchField)
  //End while 
$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")

For ($i;Size of array:C274(atQRY_NombreVirtualCampo);1;-1)
	If ((atQRY_NombreVirtualCampo{$i}="") | (atQRY_Operador_Literal{$i}=""))
		APPEND TO ARRAY:C911($l_PosElemBorrar;$y_index->{$i})
		AT_Delete ($i;1;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->ayQRY_Campos;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo;$y_index)
	End if 
End for 

  //elimino los campos 20170728 ASM Ticket 155936
QRY_OcultaObjetosBuscador (->$l_PosElemBorrar)

$setName:="$RecordSet_Table"+String:C10(Table:C252(vyQRY_TablePointer))
If (Records in set:C195($setName)>0)
	USE SET:C118($setName)
Else 
	CREATE SET:C116(vyQRY_TablePointer->;$setName)
End if 

$found:=QRY_RunQuery (vyQRY_TablePointer)
CREATE SET:C116(vyQRY_TablePointer->;"Results")


Case of 
	: (o1=1)
		USE SET:C118("Results")
		CREATE SET:C116(vyQRY_TablePointer->;$setName)
	: (o2=1)
		INTERSECTION:C121("Results";$setName;$setName)
	: (o3=1)
		UNION:C120("Results";$setName;$setName)
	: (o4=1)
		DIFFERENCE:C122($setName;"Results";$setName)
End case 
$found:=Records in set:C195($setName)
USE SET:C118($setName)

If ($found#0)
	ACCEPT:C269
Else 
	CD_Dlog (0;__ ("Ningún registro cumple con las condiciones especificadas en la fórmula de búsqueda.\rVerifique si la fórmula es correcta.");__ (""))
End if 

SET_ClearSets ("Results")