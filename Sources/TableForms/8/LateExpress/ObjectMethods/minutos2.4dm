  //$choice:=Pop up menu(Replace string(vt_intervalos;",";";"))
  //If ($choice>0)
  //vi_TiempoAtrasoGral:=Num(ST_GetWord (vt_intervalos;$choice;","))
  //End if 
$choice:=Pop up menu:C542(Replace string:C233(vt_intervalos;",";";"))
If ($choice>0)  //rch desde acá
	If (vi_RegistrarMinutosEnAtrasos=2)  //para ingreso en fracción
		vi_TiempoAtraso:=ATSTRAL_FALTACONV{$choice}
	Else 
		vi_TiempoAtraso:=Num:C11(ST_GetWord (vt_intervalos;$choice;","))
	End if 
End if 