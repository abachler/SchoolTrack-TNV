$modos:=AT_array2text (->atACT_Modo_de_Pago)
$modos:="Todos;(-;"+$modos
$choice:=Pop up menu:C542($modos)
If ($choice>0)
	If ($choice>=3)
		vt_Modo:=atACT_Modo_de_Pago{$choice-2}
	Else 
		If ($choice=1)
			vt_Modo:="Todos"
		End if 
	End if 
End if 