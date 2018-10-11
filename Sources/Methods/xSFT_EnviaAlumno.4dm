//%attributes = {}
  //  // xSFT_EnviaAlumno()
  //  //
  //  //
  //  // creado por: Alberto Bachler Klein: 04-02-17, 17:04:23
  //  // -----------------------------------------------------------
  //C_LONGINT($1)

  //C_BOOLEAN($b_existe)
  //C_LONGINT($l_carrera;$l_recNumAlumno;$l_tipoDocumento)
  //C_REAL($r_promedio)
  //C_TEXT($t_anexoCUE;$t_condicion;$t_documento;$t_dtsEnvioSchoolTrack;$t_fechaActual;$t_folioLibro;$t_libro;$t_observaciones)

  //ARRAY POINTER($ay_Valores;0)
  //ARRAY TEXT($at_campos;0)
  //ARRAY TEXT($at_uuids;0)

  //If (False)
  //C_LONGINT(xSFT_EnviaAlumno ;$1)
  //End if 



  //If (Count parameters=1)
  //$l_recNumAlumno:=$1
  //KRL_GotoRecord (->[Alumnos];$l_recNumAlumno;False)
  //End if 



  //  // CUE
  //  // Por omisión el valor almacenado en el identificador del establecimiento (rolDB),
  //  // en teoria podría tomar otros valores pero no he vistos casos en los archivos SFT examinados
  //APPEND TO ARRAY($at_Campos;"CUE")
  //APPEND TO ARRAY($ay_Valores;-><>gRolBD)

  //  // ANEXO
  //  // no lo manejamos en SchoolTrack, podría se necesario hacerlo, "00" es el valor por omisión
  //APPEND TO ARRAY($at_Campos;"ANEXO")
  //$t_anexoCUE:="00"
  //APPEND TO ARRAY($ay_Valores;->$t_anexoCUE)

  //  // APELLIDO
  //  // En principio solo apellido paterno. CONFIRMAR
  //APPEND TO ARRAY($at_Campos;"APELLIDO")
  //APPEND TO ARRAY($ay_Valores;->[Alumnos]Apellido_paterno)

  //  // NOMBRES
  //APPEND TO ARRAY($at_Campos;"NOMBRES")  // Nombres del alumno
  //APPEND TO ARRAY($ay_Valores;->[Alumnos]Nombres)

  //  // TIPODOC
  //  // Para cualquier documento que no corresponda al DNI nacional se debe asociar en SchoolTrack el tipo de documento de acuerdo a una tabla enriquecible,
  //  // pero no modificable con respecto a la tabla predefinida por el SFT
  //APPEND TO ARRAY($at_Campos;"TIPODOC")
  //APPEND TO ARRAY($at_Campos;"DOCUMENTO")
  //Case of 
  //: ([Alumnos]RUT#"")
  //$t_documento:=String(Num([Alumnos]RUT))
  //$l_tipoDocumento:=1  // es DNI
  //: ([Alumnos]IDNacional_2#"")
  //$t_documento:=[Alumnos]IDNacional_2
  //$l_tipoDocumento:=31  // no sabemos que es, enviamos 31. SOLO PARA PRUEBAS
  //: ([Alumnos]IDNacional_3#"")
  //$t_documento:=[Alumnos]IDNacional_3
  //$l_tipoDocumento:=31  // no sabemos que es, enviamos 31. SOLO PARA PRUEBAS
  //: ([Alumnos]NoPasaporte#"")
  //$l_tipoDocumento:=31  // no sabemos que es, enviamos 31. SOLO PARA PRUEBAS
  //End case 
  //APPEND TO ARRAY($ay_Valores;->$l_tipoDocumento)
  //APPEND TO ARRAY($ay_Valores;->$t_documento)


  //  // PROMEDIO
  //  // en la columna promedio se almacena el promedios de todos los cursos de la carrera cursados por el alumno
  //  // Debe calcularse y probablemente almacenarse en el campo [Alumnos]Chile_PromedioEMedia
  //  // por ahora, SOLO PARA PRUEBAS mando el promedio del nivel actual
  //If ([Alumnos]Chile_PromedioEMedia#0)
  //$r_promedio:=[Alumnos]Chile_PromedioEMedia
  //Else 
  //$r_promedio:=Num(KRL_GetTextFieldData (->[Alumnos_SintesisAnual]ID;->[Alumnos]Número;->[Alumnos_SintesisAnual]PromedioFinalOficial_Literal))
  //End if 

  //  // LUGARNAC
  //  // Lugar de nacimiento del alumno
  //APPEND TO ARRAY($at_Campos;"LUGARNAC")
  //APPEND TO ARRAY($ay_Valores;->[Alumnos]Nacido_en)

  //  //FECHANAC
  //  // fecha de nacimiento
  //APPEND TO ARRAY($at_Campos;"FECHANAC")
  //APPEND TO ARRAY($ay_Valores;->[Alumnos]Fecha_de_nacimiento)

  //  // OBSERVACIO
  //  // Observaciones sobre el título del alumno
  //  // No manejamos este campo actualmente. Manejar en InfoEgreso
  //  // por ahora, SOLO PARA PRUEBAS, envío las observaciones académicas finales del cursos actual
  //APPEND TO ARRAY($at_Campos;"OBSERVACIO")
  //$t_observaciones:=KRL_GetTextFieldData (->[Alumnos_SintesisAnual]ID;->[Alumnos]Número;->[Alumnos_SintesisAnual]Observaciones_Academicas)
  //APPEND TO ARRAY($ay_Valores;->$t_observaciones)

  //  // FECHAGRE
  //  // Fecha de egreso del alumno.
  //  // No manejamos este campo actualmente. Manejar en InfoEgreso
  //  // SOLO para pruebas envio la fecha de témino del año escolar del nivel actual
  //APPEND TO ARRAY($at_Campos;"FECHAGRE")
  //PERIODOS_LoadData ([Alumnos]Nivel_Número)
  //APPEND TO ARRAY($ay_Valores;->vdSTR_Periodos_FinEjercicio)


  //  // LIBROMATR y FOLIOLIBR
  //  // No manejamos este campo actualmente. Manejar en InfoEgreso
  //  // SOLO PARA PRUEBAS, envío "00"
  //APPEND TO ARRAY($at_Campos;"LIBROMATR")
  //APPEND TO ARRAY($at_Campos;"FOLIOLIBR")
  //$t_libro:="00"
  //$t_folioLibro:="00"
  //APPEND TO ARRAY($ay_Valores;->$t_libro)
  //APPEND TO ARRAY($ay_Valores;->$t_folioLibro)

  //  // FECHAOTOR
  //  // Fecha de otorgamiento del titulo. Manejar en InfoEgreso
  //  // SOLO para pruebas envio la fecha de témino del año escolar del nivel actual
  //APPEND TO ARRAY($at_Campos;"FECHAOTOR")
  //APPEND TO ARRAY($ay_Valores;->vdSTR_Periodos_FinEjercicio)


  //  // CARRERA
  //  // No manejamos este campo actualmente. Manejar en InfoEgreso
  //  // SOLO para pruebas envio la fecha de témino del año escolar del nivel actual
  //APPEND TO ARRAY($at_Campos;"CARRERA")
  //$l_carrera:=-1
  //APPEND TO ARRAY($ay_Valores;->$l_carrera)

  //  // CERRADO
  //  // Lo completa el SFDT cuando se menciona si el tramite se concluyo o no
  //  // no se envía
  //  //APPEND TO ARRAY($at_Campos;"CERRADO")

  //  // IMPRESO
  //  // Lo completa el SFDT cuando se menciona si el título fue impreso o no
  //  // no se envía
  //  //APPEND TO ARRAY($at_Campos;"IMPRESO")

  //  // FECHACERR
  //  // No manejamos este campo actualmente. Manejar en InfoEgreso
  //  // SOLO para pruebas envio la fecha de témino del año escolar del nivel actual
  //APPEND TO ARRAY($at_Campos;"FECHACERR")
  //APPEND TO ARRAY($ay_Valores;->vdSTR_Periodos_FinEjercicio)

  //  // FECHAIMPR
  //  // Lo autocompleta el SFDT cuando se imprime el título
  //  // no se envía
  //  //APPEND TO ARRAY($at_Campos;"FECHAIMPR")


  //  // VALIDACION
  //  // Al parecer nadie sabe si se utiliza. En las BDs Revisadas está siempre vacío
  //  // No se envía
  //  //APPEND TO ARRAY($at_Campos;"VALIDACION")

  //  // ACTA
  //  // En teoría, el numero de acta del libro matriz. En las BDs revisadas está siempre vacío.
  //  // No se envía
  //  // APPEND TO ARRAY($at_Campos;"ACTA")

  //  // COPIA
  //  // en teoría corresponde a un código que indica cual fue el número de copias del título que se imprimieron
  //  // al parecer es un campo interno al SFT, no enviámos nada
  //  //APPEND TO ARRAY($at_Campos;"COPIA")

  //  // NROTITULO
  //  // en teoría, corresponde al Número de título que viene en el papel impreso por la casa de la moneda
  //  // asumo que la secretaria debe indicarlo antes de imprimir efectivamente el título en el SFT
  //  // no enviamos nada
  //  //APPEND TO ARRAY($at_Campos;"NROTITULO")

  //  // EXPORTADO
  //  // Lo autocompleta el SFDT cuando el titulo es exportado para ser presentado ante el ministerio de educación
  //  // No enviamos nada
  //  //APPEND TO ARRAY($at_Campos;"EXPORTADO")



  //  // FECHMODI
  //  // fecha en la que enviamos el registro al SFT
  //APPEND TO ARRAY($at_Campos;"FECHMODI")
  //$t_fechaActual:=String(Current date;ISO date;Current time)
  //APPEND TO ARRAY($ay_Valores;->$t_fechaActual)


  //  // FECHBAJA
  //  // Fecha en la que fue dado de baja el alumno en el SFDT
  //  // manejo interno del SFT
  //  //APPEND TO ARRAY($at_Campos;"FECHBAJA")

  //$t_dtsEnvioSchoolTrack:=String(Current date;ISO date;Current time)
  //APPEND TO ARRAY($at_Campos;"xx_dtsSchooltrack")
  //APPEND TO ARRAY($ay_Valores;->$t_dtsEnvioSchoolTrack)

  //APPEND TO ARRAY($at_Campos;"xx_uuidSchooltrack")
  //APPEND TO ARRAY($ay_Valores;->[Alumnos]Auto_UUID)


  //$t_condicion:="DOCUMENTO ='"+$t_documento+"' AND TIPODOC = "+String($l_tipoDocumento)
  //$b_existe:=(SFT_RegistroExiste ("SFT_ALUMNOS";$t_condicion;->$at_uuids)=1)
  //If ($b_existe)
  //SFT_UpdateRecord ("SFT_Alumnos";$at_uuids{1};->$at_campos;->$ay_Valores)
  //Else 
  //  // FECHALTA
  //  // fecha en la que enviamos el registro al SFT
  //APPEND TO ARRAY($at_Campos;"FECHALTA")
  //$t_fechaActual:=String(Current date;ISO date;Current time)
  //APPEND TO ARRAY($ay_Valores;->$t_fechaActual)
  //SFT_InsertRecord ("SFT_Alumnos";->$at_campos;->$ay_Valores)
  //End if 







