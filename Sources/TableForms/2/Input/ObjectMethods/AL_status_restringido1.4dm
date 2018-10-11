AL_CambiaStatusAlumno 

  //$menu:=AT_array2text (->◊aStatus)
  //$def:=Find in array(◊aStatus;[Alumnos]Status)
  //If ($def=-1)
  //$def:=0
  //End if 
  //$choice:=Pop up menu($menu;$def)
  //If ($choice>0)
  //$saved:=AL_fSave 
  //If ($saved>=0)
  //If ($choice=Size of array(◊aStatus))
  //CD_Dlog (0;"El status "+ST_Qte ("Egresado")+" no puede ser asignado aquí.")
  //Else 
  //AL_RetiraAlumno (◊aStatus{$choice})
  //End if 
  //SET VISIBLE(*;"fechaRetiro@";(([Alumnos]Fecha_de_retiro#!00/00/00!) | ([Alumnos]Status="Retirado@")))
  //REDRAW WINDOW
  //End if 
  //End if 