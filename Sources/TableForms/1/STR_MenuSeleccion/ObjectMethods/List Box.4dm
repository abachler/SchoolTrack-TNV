Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Not:C34(muliseleccion))
			If ((Macintosh command down:C546) | (Windows Ctrl down:C562))
				$l_pos:=Find in array:C230(lb_contenido;True:C214)
				While ($l_pos#-1)
					lb_contenido{$l_pos}:=False:C215
					$l_pos:=Find in array:C230(lb_contenido;True:C214)
				End while 
				lb_contenido{lb_contenido}:=True:C214
			End if 
		End if 
End case 
