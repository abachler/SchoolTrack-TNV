Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
		If ($srcObject#(->lb_NivelesOrigen))
			$dropPos:=Drop position:C608
			If ($dropPos=-1)
				AT_Insert (1;1;->at_NivelesOrigen;->al_NivelesOrigen)
				at_NivelesOrigen{1}:=at_NivelesDestino{$srcElement}
				al_NivelesOrigen{1}:=al_NivelesDestino{$srcElement}
				AT_Delete ($srcElement;1;->at_NivelesDestino;->al_NivelesDestino)
			Else 
				AT_Insert ($dropPos;1;->at_NivelesOrigen;->al_NivelesOrigen)
				at_NivelesOrigen{$dropPos}:=at_NivelesDestino{$srcElement}
				al_NivelesOrigen{$dropPos}:=al_NivelesDestino{$srcElement}
				AT_Delete ($srcElement;1;->at_NivelesDestino;->al_NivelesDestino)
			End if 
			SORT ARRAY:C229(al_NivelesOrigen;at_NivelesOrigen;>)
		End if 
		IT_SetButtonState ((Size of array:C274(at_NivelesDestino)>0);->bCopiar)
		LISTBOX SELECT ROW:C912(lb_NivelesOrigen;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lb_NivelesDestino;0;lk remove from selection:K53:3)
End case 