//%attributes = {}
  // ----------------------------------------------------
  // Nombre usuario (OS): frojas
  // Fecha y hora: 06/10/10, 12:14:00
  // ----------------------------------------------------
  // Método: SF_FillWithMotherField
  // Descripción
  //      Llena una el campo de la subtabla, con el valor correspondiente al valor señalado de la tabla madre,
  //
  // Parámetros
  //       campo subtabla         puntero           ->              Campo subtabla en la madre
  //       campo valor                puntero           ->               Campo valor de la madre
  //       campo destino           puntero            ->              Campo de la subtabla donde depositar el valor
  //
  //SIntaxis: 
  //        SF_FillWithMotherField(->[BBL_Items]Keywords;->[BBL_Items]Numero;->[BBL_Items]Keywords'Numero_Item)
  // ----------------------------------------------------


C_POINTER:C301($ptr;$ptr2;$ptr3;$1;$2;$3)
C_LONGINT:C283($table;$field)
ARRAY LONGINT:C221($al_RN;0)

If (Count parameters:C259=3)
	$ptr:=$1
	$ptr2:=$2
	$ptr3:=$3
	
	If (Type:C295($ptr2)=Type:C295($ptr3))
		RESOLVE POINTER:C394($ptr;$foo;$table;$field)
		$tblPtr:=Table:C252($table)
		
		READ WRITE:C146($tblPtr->)
		ALL RECORDS:C47($tblPtr->)
		LONGINT ARRAY FROM SELECTION:C647($tblPtr->;$al_RN)
		
		For ($i;1;Size of array:C274($al_RN))
			GOTO RECORD:C242($tblPtr->;$al_RN{$i})
			  //$value:=$ptr2->
			_O_APPLY TO SUBSELECTION:C73($ptr->;$ptr3->:=$ptr2->)
			SAVE RECORD:C53($tblPtr->)
		End for 
	End if 
	
End if 