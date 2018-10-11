Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
		If ($srcObject#(->lb_NivelesDestino))
			$dropPos:=Drop position:C608
			If (($dropPos=0) | ($dropPos=-1))
				AT_Insert (1;1;->at_NivelesDestino;->al_NivelesDestino)
				at_NivelesDestino{1}:=at_NivelesOrigen{$srcElement}
				al_NivelesDestino{1}:=al_NivelesOrigen{$srcElement}
				AT_Delete ($srcElement;1;->at_NivelesOrigen;->al_NivelesOrigen)
			Else 
				AT_Insert ($dropPos;1;->at_NivelesDestino;->al_NivelesDestino)
				at_NivelesDestino{$dropPos}:=at_NivelesOrigen{$srcElement}
				al_NivelesDestino{$dropPos}:=al_NivelesOrigen{$srcElement}
				AT_Delete ($srcElement;1;->at_NivelesOrigen;->al_NivelesOrigen)
			End if 
			SORT ARRAY:C229(al_NivelesDestino;at_NivelesDestino;>)
		End if 
		IT_SetButtonState ((Size of array:C274(at_NivelesDestino)>0);->bCopiar)
		LISTBOX SELECT ROW:C912(lb_NivelesOrigen;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lb_NivelesDestino;0;lk remove from selection:K53:3)
End case 