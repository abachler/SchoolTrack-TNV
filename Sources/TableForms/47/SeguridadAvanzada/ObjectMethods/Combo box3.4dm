
Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		C_LONGINT:C283($l_Valor;$l_pos)
		$l_Valor:=al_ListaMinNum{0}
		$l_pos:=Find in array:C230(al_ListaMinNum;$l_Valor)
		If ($l_pos>0)
			$l_Valor:=al_ListaMinNum{$l_pos}
		Else 
			  //si se digita un numero que no existe en el arreglo se escribe el valor maximo
			$l_Valor:=al_ListaMinNum{Size of array:C274(al_ListaMinNum)}
			al_ListaMinNum{0}:=$l_Valor
		End if 
		
		$l_Valor:=al_ListaMinMAY{0}+al_ListaMinNum{0}
		If ($l_Valor>al_ListaMaxC{0})
			$l_resp:=CD_Dlog (0;"La suma entre la cantidad de caracteres mayúsculas ("+String:C10(al_ListaMinMAY{0})+") y numéricos ("+String:C10(al_ListaMinNum{0})+") supera la longitud mínima ("+String:C10(al_ListaMaxC{0})+") ingresada.")
		End if 
End case 
