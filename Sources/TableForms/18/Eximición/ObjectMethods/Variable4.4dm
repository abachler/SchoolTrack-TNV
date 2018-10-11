If (vi_g1=0)
	  //$msg:="El alumno no puede ser eximido sin número de registro interno.\r\rSchoolTrack le a"+"signará el número -1.\r"+"Cuando disponga de los números de registro asígnelos aqui mismo o en el Registro "+"de Eximiciones en el menú Herramientas."
	  //$msg:=$msg+"Cuando disponga de los números de registro asígnelos aqui mismo o en el Registro "+"de Eximiciones en el menú Herramientas."
	$ignore:=CD_Dlog (0;__ ("El alumno no puede ser eximido sin número de registro interno.\r\rSchoolTrack le asignará el número -1.\rCuando disponga de los números de registro asígnelos aqui mismo o en el Registro de Eximiciones en el menú Herramientas."))
	vi_g1:=-1
	Self:C308->:=1
End if 