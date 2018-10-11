  //$choice:=Pop up menu(Replace string(vt_intervalos;",";";"))
  //If ($choice>0)
  //vi_TiempoAtraso:=Num(ST_GetWord (vt_intervalos;$choice;","))
  //End if 
$choice:=Pop up menu:C542(Replace string:C233(vt_intervalos;",";";"))
If ($choice>0)  //rch desde acá
	If (vi_RegistrarMinutosEnAtrasos=2)  //para ingreso en fracción
		vi_TiempoAtraso:=ATSTRAL_FALTACONV{$choice}
	Else 
		vi_TiempoAtraso:=Num:C11(ST_GetWord (vt_intervalos;$choice;","))
	End if 
End if   //rch hasta acá

  // 20120710 ASM, validación en el ingreso de atrasos, para que la suma de estos no sobrepase el limite de un día.
$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;dFrom;vi_TiempoAtraso)
If ($resultado>1)
	vi_TiempoAtraso:=0
	CD_Dlog (0;__ ("No puede ingresar atrasos para el alumno ")+[Alumnos:2]apellidos_y_nombres:40+"."+"\r\r"+__ ("Verifique que no existan inasistencias registradas, o que las faltas por atrasos no sumen mas de un día para la fecha seleccionada."))
End if 