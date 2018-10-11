  //READ ONLY([Alumnos])
  //REDUCE SELECTION([Alumnos];0)
  //If (Self->=True)
  //If ([Personas]RUT#"")
  //QUERY([Alumnos];[Alumnos]RUT=[Personas]RUT)
  //End if 
  //If (Records in selection([Alumnos])=1)
  //[Personas]ID_ExAlumno:=[Alumnos]Número
  //Else 
  //QUERY([Alumnos];[Alumnos]Apellido_paterno=[Personas]Apellido_paterno;*)
  //QUERY([Alumnos]; & ;[Alumnos]Nombres;=;"@"+[Personas]Nombres+"@")
  //
  //QUERY SELECTION([Alumnos];[Alumnos]Nivel_Número>=Nivel_Egresados;*)
  //QUERY SELECTION([Alumnos]; | ;[Alumnos]Nivel_Número=Nivel_Retirados)
  //If (Records in selection([Alumnos])>0)
  //SELECTION TO ARRAY([Alumnos]Apellidos_y_Nombres;<>aText1;[Alumnos]Curso;<>aText2;[Alumnos]Direccion;<>aText3;[Alumnos]Número;aLong)
  //For ($i;1;Size of array(<>aText1))
  //<>aText1{$i}:=Replace string(<>aText1{$i};"*";"")
  //End for 
  //ARRAY POINTER(<>aChoicePtrs;4)
  //<>aChoicePtrs{1}:=-><>aText1
  //<>aChoicePtrs{2}:=-><>aText2
  //<>aChoicePtrs{3}:=-><>aText3
  //<>aChoicePtrs{4}:=->aLong
  //TBL_ShowChoiceList (1;"Ex-Alumnos";1)
  //If ((ok=1) & (choiceIdx>0))
  //[Personas]ID_ExAlumno:=aLong{choiceIdx}
  //End if 
  //End if 
  //End if 
  //Else 
  //
  //QUERY([Alumnos];[Alumnos]Número=[Personas]ID_ExAlumno)
  //Case of 
  //: (Records in selection([Alumnos])=0)
  //[Personas]ID_ExAlumno:=0
  //: ([Alumnos]Nivel_Número<1000)
  //[Personas]ID_ExAlumno:=0
  //: ([Alumnos]RUT=[Personas]RUT)
  //CD_Dlog (0;__ ("Esta padre o apoderado no puede ser desconectado del registro de ex-alumno ya que tienen el mismo identificador nacional."))
  //Self->:=True
  //Else 
  //$r:=CD_Dlog (0;__ ("¿Desea eliminar la relación con el(la) ex-alumno(a) ")+[Alumnos]Apellidos_y_Nombres+__ ("?");__ ("");__ ("No");__ ("Si"))
  //If ($r=2)
  //[Personas]ID_ExAlumno:=0
  //Else 
  //Self->:=True
  //End if 
  //End case 
  //End if 
ST_MarcaCampoExAlumno 
