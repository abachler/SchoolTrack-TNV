  //C_BOOLEAN($guardar)
  //$guardar:=False
  //C_LONGINT($rec)
  //C_TEXT($nombres;$sexo;$religion;$rut;$nacionalidad;$apellidosNombres)
  //C_DATE($fechaDeNacimiento)
  //$nombres:=[Alumnos]Nombres
  //$sexo:=[Alumnos]Sexo
  //$religion:=[Alumnos]Religion
  //$fechaDeNacimiento:=[Alumnos]Fecha_de_nacimiento
  //$rut:=[Alumnos]RUT
  //$nacionalidad:=[Alumnos]Nacionalidad
  //$apellidosNombres:=[Alumnos]Apellidos_y_Nombres
  //
  //$rec:=Record number([Alumnos])
  //If (Self->>0)
  //If (<>gGroupAL=False)
  //[Familia]Grupo_Familia:=Self->{Self->}
  //If (([Familia]Grupo_Familia#Old([Familia]Grupo_Familia)) & (Record number([Familia])>0) & (Not(<>gGroupAL)) & ([Familia]Grupo_Familia#""))
  //$guardar:=True
  //READ ONLY([Alumnos])
  //QUERY([Alumnos];[Alumnos]Familia_Número=[Familia]Numero)
  //ARRAY TEXT(aText;Records in selection([Alumnos]))
  //sString:=[Familia]Grupo_Familia
  //AT_Populate (->aText;->sString)
  //KRL_Array2Selection (->aText;->[Alumnos]Grupo)
  //SAVE RECORD([Familia])
  //ARRAY TEXT(aText;0)
  //sString:=""
  //End if 
  //Else 
  //CD_Dlog (0;__ ("El grupo debe ser asignado al alumno y no a la familia."))
  //End if 
  //End if 
  //
  //If ($guardar=True)
  //READ WRITE([Alumnos])
  //GOTO RECORD([Alumnos];$rec)
  //[Alumnos]Nombres:=$nombres
  //[Alumnos]Sexo:=$sexo
  //[Alumnos]Religion:=$religion
  //[Alumnos]Fecha_de_nacimiento:=$fechaDeNacimiento
  //[Alumnos]RUT:=$rut
  //[Alumnos]Nacionalidad:=$nacionalidad
  //[Alumnos]Apellidos_y_Nombres:=$apellidosNombres
  //SAVE RECORD([Alumnos])
  //End if 

vt_Grupo:=Self:C308->{Self:C308->}
