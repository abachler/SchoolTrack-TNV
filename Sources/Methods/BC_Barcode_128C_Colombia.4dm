//%attributes = {}
  //BC_Barcode_128C_Colombia

  //20090608 RCH Actualmente sólo Colombia ha solicitado operar con code 128C. Por este motivo...
  //... se hacen cambios en las rutinas de generación de code 128C para adecuarlos a lo solicitado.
  //El caracter * será utilizado para simular un FN1, que actualmente tiene que ir en ciertas posiciones.

C_TEXT:C284($vt_accion;$1;$vt_retorno;$0)
C_POINTER:C301($ptr1;$ptr2)
C_POINTER:C301(${2})
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

Case of 
	: ($vt_accion="Code2Print")
		Case of 
			: ($ptr1->="Code128C")
				$vt_retorno:=Replace string:C233($ptr2->;"*";"")
			Else 
				$vt_retorno:=$ptr2->
		End case 
		
	: ($vt_accion="Code2CalCheck")
		$code:=Replace string:C233(Replace string:C233(Replace string:C233($ptr1->;"(";"");")";"");" ";"")
		ARRAY LONGINT:C221($al_positionFN1;0)
		For ($i;1;Length:C16($code))
			If ($code[[$i]]="*")
				If (Size of array:C274($al_positionFN1)=0)
					APPEND TO ARRAY:C911($al_positionFN1;$i)
				Else 
					APPEND TO ARRAY:C911($al_positionFN1;($i-Size of array:C274($al_positionFN1)))
				End if 
			End if 
		End for 
		$vt_retorno:=Replace string:C233($code;"*";"")
		COPY ARRAY:C226($al_positionFN1;$ptr2->)
		
	: ($vt_accion="InsertFN12Pattern")
		If ((Find in array:C230($ptr2->;$ptr1->)>0) | (Find in array:C230($ptr2->;$ptr1->)>0))
			$vt_retorno:=Barcode_Pattern{107}
		End if 
End case 

$0:=$vt_retorno