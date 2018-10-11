//%attributes = {}
  //CMT_EnviaFiltro

  //If ((Table(yBWR_currentTable)=Table(->[Alumnos])) | (Table(yBWR_currentTable)=Table(->[Personas])) | (Table(yBWR_currentTable)=Table(->[Profesores])))
  //$set:="RecordSet_Table"+String(Table(yBWR_currentTable))
  //If (Records in set($set)>0)
  //USE SET($set)
  //ARRAY LONGINT(aIDs;0)
  //Case of 
  //: (Table(yBWR_currentTable)=Table(->[Alumnos]))
  //SELECTION TO ARRAY([Alumnos]Número;aIDs)
  //vTipo:="ALU"
  //: (Table(yBWR_currentTable)=Table(->[Personas]))
  //SELECTION TO ARRAY([Personas]No;aIDs)
  //vTipo:="PER"
  //: (Table(yBWR_currentTable)=Table(->[Profesores]))
  //SELECTION TO ARRAY([Profesores]Número;aIDs)
  //vTipo:="PRO"
  //End case 
  //
  //SET WEB SERVICE PARAMETER("ids";aIDs)
  //SET WEB SERVICE PARAMETER("tipo";vTipo)
  //SET WEB SERVICE PARAMETER("dts";vDTS)
  //SET WEB SERVICE PARAMETER("nombre";vNombre)
  //SET WEB SERVICE PARAMETER("usuario";vUsuario)
  //
  //$err:=WS_CallCommTrackWebService ()
  //If ($err="")
  //GET WEB SERVICE RESULT(aIDsNoExistentes;"noexisten")
  //If (Size of array(aIDsNoExistentes)>0)
  //For ($i;1;Size of array(aIDsNoExistentes))
  //Case of 
  //: (Table(yBWR_currentTable)=Table(->[Alumnos]))
  //$rn:=Find in field([Alumnos]Número;aIDsNoExistentes{$i})
  //GOTO RECORD([Alumnos];$rn)
  //vApPaterno:=[Alumnos]Apellido_paterno
  //vApMaterno:=[Alumnos]Apellido_materno
  //vNombres:=[Alumnos]Nombres
  //vID:=[Alumnos]Número
  //vCurso:=[Alumnos]Curso
  //vYear:=◊gYear
  //vNivelNumero:=[Alumnos]Nivel_Número
  //vFliaNumero:=[Alumnos]Familia_Número
  //vApoCtas:=[Alumnos]Apoderado_Cuentas_Número
  //vApoAca:=[Alumnos]Apoderado_académico_Número
  //vMail:=[Alumnos]eMAIL
  //SET WEB SERVICE PARAMETER("appaterno";vApPaterno)
  //SET WEB SERVICE PARAMETER("apmaterno";vApMaterno)
  //SET WEB SERVICE PARAMETER("nombres";vNombres)
  //SET WEB SERVICE PARAMETER("id";vID)
  //SET WEB SERVICE PARAMETER("curso";vCurso)
  //SET WEB SERVICE PARAMETER("year";vYear)
  //SET WEB SERVICE PARAMETER("nivelnum";vNivelNumero)
  //SET WEB SERVICE PARAMETER("flianum";vFliaNumero)
  //SET WEB SERVICE PARAMETER("apoctas";vApoCtas)
  //SET WEB SERVICE PARAMETER("apoaca";vApoAca)
  //SET WEB SERVICE PARAMETER("mail";vMail)
  //$err:=WS_CallCommTrackWebService ()
  //: (Table(yBWR_currentTable)=Table(->[Personas]))
  //$rn:=Find in field([Personas]No;aIDsNoExistentes{$i})
  //GOTO RECORD([Personas];$rn)
  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->[Familia_RelacionesFamiliares]ID_Persona)
  //KRL_FindAndLoadRecordByIndex (->[Familia]Numero;->[Familia_RelacionesFamiliares]ID_Familia)
  //vApPaterno:=[Personas]Apellido_paterno
  //vApMaterno:=[Personas]Apellido_materno
  //vNombres:=[Personas]Nombres
  //vID:=[Personas]No
  //vFamNum:=[Familia]Numero
  //vEsPadre:=ST_Boolean2Str ([Familia]Padre_Número=[Personas]No;"Si";"No")
  //vEsMadre:=ST_Boolean2Str ([Familia]Madre_Número=[Personas]No;"Si";"No")
  //vEsApoCta:=ST_Boolean2Str ([Personas]ES_Apoderado_de_Cuentas;"Si";"No")
  //vEsApoAca:=ST_Boolean2Str ([Personas]Es_Apoderado_Academico;"Si";"No")
  //vMail:=[Personas]eMail
  //SET WEB SERVICE PARAMETER("appaterno";vApPaterno)
  //SET WEB SERVICE PARAMETER("apmaterno";vApMaterno)
  //SET WEB SERVICE PARAMETER("nombres";vNombres)
  //SET WEB SERVICE PARAMETER("id";vID)
  //SET WEB SERVICE PARAMETER("famnum";vFamNum)
  //SET WEB SERVICE PARAMETER("espadre";vEsPadre)
  //SET WEB SERVICE PARAMETER("esmadre";vEsMadre)
  //SET WEB SERVICE PARAMETER("esapocta";vEsApoCta)
  //SET WEB SERVICE PARAMETER("esapoaca";vEsApoAca)
  //SET WEB SERVICE PARAMETER("mail";vMail)
  //$err:=WS_CallCommTrackWebService ()
  //: (Table(yBWR_currentTable)=Table(->[Profesores]))
  //$rn:=Find in field([Profesores]Número;aIDsNoExistentes{$i})
  //GOTO RECORD([Profesores];$rn)
  //REDUCE SELECTION([Cursos];0)
  //KRL_FindAndLoadRecordByIndex (->[Cursos]Número_del_profesor_jefe;->[Profesores]Número)
  //vApPaterno:=[Profesores]Apellido_paterno
  //vApMaterno:=[Profesores]Apellido_materno
  //vNombres:=[Profesores]Nombres
  //vID:=[Profesores]Número
  //vEsProfJefe:=ST_Boolean2Str (Records in selection([Cursos])>0;"Si";"No")
  //vMailPersonal:=[Profesores]eMail_Personal
  //vMailProfesional:=[Profesores]eMail_profesional
  //SET WEB SERVICE PARAMETER("appaterno";vApPaterno)
  //SET WEB SERVICE PARAMETER("apmaterno";vApMaterno)
  //SET WEB SERVICE PARAMETER("nombres";vNombres)
  //SET WEB SERVICE PARAMETER("id";vID)
  //SET WEB SERVICE PARAMETER("esprofjefe";vEsProfJefe)
  //SET WEB SERVICE PARAMETER("mailpersonal";vMailPersonal)
  //SET WEB SERVICE PARAMETER("mailprofesional";vMailProfesional)
  //$err:=WS_CallCommTrackWebService ()
  //End case 
  //End for 
  //End if 
  //End if 
  //End if 
  //End if 