//%attributes = {}
  //  //_0000_TestsMayflower
  //  //ADTwa_scriptMayflower
  //C_BOOLEAN($b_enBoleta;$b_errorAlumno;$b_errorApAcad;$b_errorApCta;$b_errorAvisos;$b_errorCargos;$b_errorCreaFamilia;$b_errorCuenta;$b_errorMadre;$b_errorPadre)
  //C_BOOLEAN($b_errorRutAlumno;$b_errorRutApdoAcad;$b_errorRutApdoCta;$b_errorRutMadre;$b_errorRutPadre;$b_mismoAviso;$vb_afecto;$vb_esDescuento;$vb_noIncluirDT)
  //C_DATE($d_fecha)
  //C_LONGINT($i;$j;$k;$l_idApAcad;$l_idApCuenta;$l_idApdoEducAnterior;$l_idCargo;$l_idFamilia;$l_idMadre;$l_idPadre)
  //C_LONGINT($l_indice;$l_recNum;$r;$type)
  //C_REAL($r_procesado;$vr_monto)
  //C_TEXT($json;$nodeErr;$nodeErrCod;$root;$t_idsAvisos;$t_itemsCobrados;$t_jsonConDatos;$t_montoPagado;$t_montosCobrados;$t_operacion)
  //C_TEXT($t_ordenDeCompraWP;$t_rut;$t_rutApdo;$t_rutsAlumnos;$t_timeStamp;$t_tipo;$vt_ccentroCosto;$vt_cctaAuxiliar;$vt_cctaContable;$vt_centroCosto)
  //C_TEXT($vt_ctaAuxiliar;$vt_ctaContable;$vt_glosa;$vt_moneda;$vt_obs)

  //  //If (False)
  //  //COPY ARRAY(<>aParameterNames;aParameterNames)
  //  //COPY ARRAY(<>aParameterValues;aParameterValues)
  //  //End if

  //  //_0000_TestsRCH2
  //C_TEXT(t_respuestaJSON)

  //ARRAY LONGINT(aQR_Longint1;0)  //ids alumnos
  //ARRAY LONGINT(aQR_Longint2;0)  //ids avisos de cobranza
  //ARRAY TEXT(aQR_Text1;0)  //ruts alumnos
  //ARRAY LONGINT(aQR_Longint5;0)
  //ARRAY LONGINT(aQR_Longint6;0)
  //ARRAY LONGINT(aQR_Longint7;0)
  //ARRAY LONGINT(aQR_Longint8;0)
  //ARRAY POINTER(aQR_Pointer1;0)
  //ARRAY POINTER(aQR_Pointer2;0)
  //ARRAY TEXT(aQR_Text6;0)
  //ARRAY TEXT(aQR_Text7;0)
  //ARRAY TEXT(aQR_Text8;0)
  //ARRAY TEXT(aQR_Text9;0)
  //ARRAY TEXT(aQR_Text10;0)
  //ARRAY TEXT(aQR_Text11;0)
  //ARRAY TEXT(aQR_Text12;0)
  //ARRAY TEXT(aQR_Text13;0)
  //ARRAY LONGINT(aQR_Longint3;0)
  //ARRAY TEXT(aQR_Text14;0)
  //ARRAY TEXT(aQR_Text15;0)
  //ARRAY TEXT(aQR_Text16;0)
  //ARRAY TEXT(aQR_Text17;0)
  //ARRAY TEXT(aQR_Text18;0)
  //ARRAY TEXT(aQR_Text19;0)
  //ARRAY TEXT(aQR_Text20;0)
  //ARRAY TEXT(aQR_Text21;0)
  //C_BOOLEAN(<>b_pruebaMayflower)

  //ARRAY LONGINT(aQR_Longint4;0)

  //TRACE
  //  //If (True)
  //  //If (<>b_pruebaMayflower)
  //$t_rutsAlumnos:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"cuentas")  //cuentas pagadas. separadas por ,
  //$t_itemsCobrados:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"items")  //items cobrados. separados por ,
  //$t_montosCobrados:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"montos")  // montos asociados a items. separados por ,
  //$t_rutApdo:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"rut_relfam")  //sin puntos ni guion
  //$t_montoPagado:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"monto_total")
  //$t_timeStamp:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"timestamp")
  //$t_ordenDeCompraWP:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"orden_compra")
  //$t_jsonConDatos:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"json")
  //  //$t_llave:=NV_GetValueFromPairedArrays (->aParameterNames;->aParameterValues;"llave")
  //  //Else
  //  //$t_rutsAlumnos:="222646782,231467009"
  //  //$t_itemsCobrados:="matricula,matricula"
  //  //$t_montosCobrados:="160000,160000"
  //  //$t_rutApdo:="153952396"
  //  //$t_montoPagado:="320000"
  //  //$t_timeStamp:="2014-06-02 21:45:53"
  //  //$t_ordenDeCompraWP:="2000"
  //  //$t_jsonConDatos:=_0000_TestsRCH3
  //  //
  //  //End if

  //START TRANSACTION

  //APPEND TO ARRAY(aQR_Text8;"appaterno")
  //APPEND TO ARRAY(aQR_Text8;"apmaterno")
  //APPEND TO ARRAY(aQR_Text8;"nombres")
  //APPEND TO ARRAY(aQR_Text8;"fnacimiento")
  //APPEND TO ARRAY(aQR_Text8;"rut")
  //APPEND TO ARRAY(aQR_Text8;"sexo")
  //APPEND TO ARRAY(aQR_Text8;"nacionalidad")
  //  //APPEND TO ARRAY(aQR_Text8;"pais")
  //APPEND TO ARRAY(aQR_Text8;"ciudad")
  //APPEND TO ARRAY(aQR_Text8;"comuna")
  //APPEND TO ARRAY(aQR_Text8;"telefono")
  //APPEND TO ARRAY(aQR_Text8;"situacion_familiar")
  //APPEND TO ARRAY(aQR_Text8;"nivel_a_matricular")
  //APPEND TO ARRAY(aQR_Text8;"matriculado")
  //APPEND TO ARRAY(aQR_Text8;"celular")
  //APPEND TO ARRAY(aQR_Text8;"direccion")
  //APPEND TO ARRAY(aQR_Text8;"email")
  //APPEND TO ARRAY(aQR_Text8;"nacidoen")
  //APPEND TO ARRAY(aQR_Text8;"sectordomicilio")
  //APPEND TO ARRAY(aQR_Text8;"codpostal")
  //APPEND TO ARRAY(aQR_Text8;"religion")
  //APPEND TO ARRAY(aQR_Text8;"grupo")
  //APPEND TO ARRAY(aQR_Text8;"vivecon")
  //APPEND TO ARRAY(aQR_Text8;"situacionfamiliar")
  //APPEND TO ARRAY(aQR_Text8;"colegio_de_origen")

  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Apellido_paterno)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Apellido_materno)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Nombres)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Fecha_de_nacimiento)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]RUT)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Sexo)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Nacionalidad)
  //  //APPEND TO ARRAY(aQR_Pointer1;->)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Ciudad)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Comuna)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Telefono)
  //APPEND TO ARRAY(aQR_Pointer1;->[Familia]Sit_Familiar)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Nivel_al_que_ingresó)
  //APPEND TO ARRAY(aQR_Pointer1;->[ACT_CuentasCorrientes]Matriculado)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Celular)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Direccion)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]eMAIL)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Nacido_en)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Sector_Domicilio)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Codigo_Postal)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Religion)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Grupo)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Vive_con)
  //APPEND TO ARRAY(aQR_Pointer1;->[Familia]Sit_Familiar)
  //APPEND TO ARRAY(aQR_Pointer1;->[Alumnos]Colegio_de_origen)

  //  //campos padres
  //APPEND TO ARRAY(aQR_Text9;"appaterno")
  //APPEND TO ARRAY(aQR_Text9;"apmaterno")
  //APPEND TO ARRAY(aQR_Text9;"nombres")
  //APPEND TO ARRAY(aQR_Text9;"fnacimiento")
  //APPEND TO ARRAY(aQR_Text9;"rut")
  //APPEND TO ARRAY(aQR_Text9;"sexo")
  //APPEND TO ARRAY(aQR_Text9;"nacionalidad")
  //APPEND TO ARRAY(aQR_Text9;"direccion")
  //  //APPEND TO ARRAY(aQR_Text9;"pais")
  //APPEND TO ARRAY(aQR_Text9;"ciudad")
  //APPEND TO ARRAY(aQR_Text9;"comuna")
  //APPEND TO ARRAY(aQR_Text9;"telefono")
  //APPEND TO ARRAY(aQR_Text9;"celular")
  //APPEND TO ARRAY(aQR_Text9;"email")
  //APPEND TO ARRAY(aQR_Text9;"profesion")
  //APPEND TO ARRAY(aQR_Text9;"lugar_donde_trabaja")
  //APPEND TO ARRAY(aQR_Text9;"cargo")
  //  //APPEND TO ARRAY(aQR_Text9;"direccion_comercial")
  //APPEND TO ARRAY(aQR_Text9;"direccionprofesional")
  //APPEND TO ARRAY(aQR_Text9;"telefono_oficina")
  //APPEND TO ARRAY(aQR_Text9;"colegio_asistio")
  //APPEND TO ARRAY(aQR_Text9;"anio_graduacion")
  //APPEND TO ARRAY(aQR_Text9;"universidad_asistio")
  //APPEND TO ARRAY(aQR_Text9;"titulo_obtenido")
  //APPEND TO ARRAY(aQR_Text9;"estadocivil")
  //APPEND TO ARRAY(aQR_Text9;"religion")
  //APPEND TO ARRAY(aQR_Text9;"nivelestudios")
  //APPEND TO ARRAY(aQR_Text9;"faxprofesional")
  //APPEND TO ARRAY(aQR_Text9;"codpostal")
  //APPEND TO ARRAY(aQR_Text9;"fax")
  //APPEND TO ARRAY(aQR_Text9;"direccionec")
  //APPEND TO ARRAY(aQR_Text9;"comunaec")
  //APPEND TO ARRAY(aQR_Text9;"codpostalec")
  //APPEND TO ARRAY(aQR_Text9;"ciudadec")
  //APPEND TO ARRAY(aQR_Text9;"prefijo")

  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Apellido_paterno)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Apellido_materno)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Nombres)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Fecha_de_nacimiento)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]RUT)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Sexo)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Nacionalidad)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Direccion)
  //  //APPEND TO ARRAY(aQR_Pointer2;->[Personas])
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Ciudad)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Comuna)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Telefono_domicilio)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Celular)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]eMail)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Profesion)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Empresa)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Cargo)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Direccion_Profesional)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Telefono_profesional)
  //APPEND TO ARRAY(aQR_Pointer2;->[STR_EducacionAnterior]Nombre_Colegio)  //tipo 1
  //APPEND TO ARRAY(aQR_Pointer2;->[STR_EducacionAnterior]Año)
  //APPEND TO ARRAY(aQR_Pointer2;->[STR_EducacionAnterior]Nombre_Colegio)
  //APPEND TO ARRAY(aQR_Pointer2;->[STR_EducacionAnterior]Nivel)  //1 para colegio; 2 para universidades; 3 para otros
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Estado_civil)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Religión)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Nivel_de_estudios)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Fax_empresa)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Codigo_postal)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Fax)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]ACT_DireccionEC)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]ACT_ComunaEC)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]ACT_CodPostalEC)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]ACT_CiudadEC)
  //APPEND TO ARRAY(aQR_Pointer2;->[Personas]Prefijo)

  //  //arrays para datos de familia
  //ARRAY TEXT(aQR_Text22;0)
  //ARRAY POINTER(aQR_Pointer3;0)
  //ARRAY TEXT(aQR_Text23;0)

  //  //para asignar orden de compra
  //ARRAY TEXT(aQR_Text24;0)
  //ARRAY LONGINT(aQR_Longint11;0)
  //ARRAY TEXT(aQR_Text25;0)

  //ARRAY TEXT(aQR_Text26;0)
  //ARRAY LONGINT(aQR_Longint12;0)
  //ARRAY TEXT(aQR_Text27;0)

  //ARRAY LONGINT(aQR_Longint13;0)  //ids pagos
  //ARRAY LONGINT(aQR_Longint14;0)  //ids cuentas corrientes

  //$d_fecha:=DT_GetDateFromDayMonthYear (Num(Substring($t_timeStamp;9;2));Num(Substring($t_timeStamp;6;2));Num(Substring($t_timeStamp;1;4)))

  //  //parseo json
  //  //***** SchoolTrack *****

  //$root:=JSON Parse text ($t_jsonConDatos)
  //If (Not(Is compiled mode))
  //SET TEXT TO PASTEBOARD(JSON Export to text ($root;JSON_WITH_WHITE_SPACE))
  //End if 
  //JSON GET CHILD NODES ($root;aQR_Text18;aQR_Longint5;aQR_Text14)

  //$t_operacion:=JSON Get text (aQR_Text18{1})

  //JSON GET CHILD NODES (aQR_Text18{2};aQR_Text19;aQR_Longint6;aQR_Text15)
  //For ($i;1;Size of array(aQR_Text19))
  //$t_tipo:=aQR_Text15{$i}
  //If ($t_tipo="alumnos")  //obtiene los alumnos
  //$t_rut:=""
  //UFLD_LoadFileTplt (->[Alumnos])
  //JSON GET CHILD NODES (aQR_Text19{$i};aQR_Text20;aQR_Longint7;aQR_Text16)
  //For ($j;1;Size of array(aQR_Text20))
  //JSON GET CHILD NODES (aQR_Text20{$j};aQR_Text21;aQR_Longint8;aQR_Text17)
  //ARRAY TEXT(aQR_Text6;0)
  //ARRAY TEXT(aQR_Text10;0)
  //For ($k;1;Size of array(aQR_Text21))
  //APPEND TO ARRAY(aQR_Text6;aQR_Text17{$k})
  //APPEND TO ARRAY(aQR_Text10;JSON Get text (aQR_Text21{$k}))
  //If (aQR_Text6{$k}="rut")
  //$t_rut:=aQR_Text10{$k}
  //End if 
  //If (aQR_Text10{$k}="null")
  //aQR_Text10{$k}:=""
  //End if 
  //End for 

  //If (CTRY_CL_VerifRUT ($t_rut;False)#"")
  //$l_recNum:=Find in field([Alumnos]RUT;$t_rut)
  //If ($l_recNum=-1)  //si el alumno existe en la base, no se importa.
  //CREATE RECORD([Alumnos])
  //[Alumnos]Nivel_Número:=Nivel_AdmisionDirecta
  //[Alumnos]Curso:="Adm"+String(<>gYear+1)
  //[Alumnos]Nivel_Nombre:="Admisión"
  //UFLD_CreateFields (->[Alumnos];->[Alumnos]Userfields;->[Alumnos]Userfields'Value)
  //[Alumnos]Fecha_de_modificacion:=Current date(*)
  //[Alumnos]Modificado_por:=$t_operacion
  //For ($r;1;Size of array(aQR_Text6))
  //$l_indice:=Find in array(aQR_Text8;aQR_Text6{$r})
  //If ($l_indice>0)
  //If (Table(->[Alumnos])=Table(aQR_Pointer1{$l_indice}))

  //$type:=Type(aQR_Pointer1{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer1{$l_indice}->:=aQR_Text10{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer1{$l_indice}->:=Num(aQR_Text10{$r})
  //: ($type=Is date)
  //aQR_Pointer1{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text10{$r};9;2));Num(Substring(aQR_Text10{$r};6;2));Num(Substring(aQR_Text10{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text10{$r}="true") | (aQR_Text10{$r}="verdadero") | (aQR_Text10{$r}="1") | (aQR_Text10{$r}="Si"))
  //aQR_Pointer1{$l_indice}->:=True
  //Else 
  //aQR_Pointer1{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //Else 
  //If (Table(->[Familia])=Table(aQR_Pointer1{$l_indice}))
  //APPEND TO ARRAY(aQR_Text22;aQR_Text6{$r})
  //APPEND TO ARRAY(aQR_Pointer3;aQR_Pointer1{$l_indice})
  //APPEND TO ARRAY(aQR_Text23;aQR_Text10{$r})
  //End if 
  //End if 
  //End if 
  //End for 

  //AL_ProcesaNombres (True)

  //SAVE RECORD([Alumnos])
  //APPEND TO ARRAY(aQR_Longint1;[Alumnos]Número)

  //  //importo info ACT
  //For ($r;1;Size of array(aQR_Text6))
  //$l_indice:=Find in array(aQR_Text8;aQR_Text6{$r})
  //If ($l_indice>0)
  //If (Table(->[ACT_CuentasCorrientes])=Table(aQR_Pointer1{$l_indice}))
  //READ WRITE([ACT_CuentasCorrientes])
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID_Alumno=aQR_Longint1{Size of array(aQR_Longint1)})
  //If (Not(Locked([ACT_CuentasCorrientes])))
  //$type:=Type(aQR_Pointer1{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer1{$l_indice}->:=aQR_Text10{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer1{$l_indice}->:=Num(aQR_Text10{$r})
  //: ($type=Is date)
  //aQR_Pointer1{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text10{$r};9;2));Num(Substring(aQR_Text10{$r};6;2));Num(Substring(aQR_Text10{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text10{$r}="true") | (aQR_Text10{$r}="verdadero") | (aQR_Text10{$r}="1") | (aQR_Text10{$r}="Si"))
  //aQR_Pointer1{$l_indice}->:=True
  //Else 
  //aQR_Pointer1{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 

  //Else 
  //$b_errorCuenta:=True
  //End if 

  //If ([ACT_CuentasCorrientes]Matriculado)
  //[ACT_CuentasCorrientes]Matriculado_el:=Current date(*)
  //End if 

  //SAVE RECORD([ACT_CuentasCorrientes])
  //KRL_UnloadReadOnly (->[ACT_CuentasCorrientes])
  //End if 
  //End if 
  //End for 
  //Else 
  //$b_errorAlumno:=True
  //$j:=Size of array(aQR_Text20)
  //End if 
  //Else 
  //$b_errorRutAlumno:=True
  //End if 
  //KRL_UnloadReadOnly (->[Alumnos])

  //End for 

  //End if 

  //If ($t_tipo="madre")  // madre
  //$t_rut:=""
  //UFLD_LoadFileTplt (->[Personas])
  //JSON GET CHILD NODES (aQR_Text19{$i};aQR_Text20;aQR_Longint7;aQR_Text16)
  //ARRAY TEXT(aQR_Text7;0)
  //ARRAY TEXT(aQR_Text11;0)
  //For ($k;1;Size of array(aQR_Text20))
  //APPEND TO ARRAY(aQR_Text7;aQR_Text16{$k})
  //APPEND TO ARRAY(aQR_Text11;JSON Get text (aQR_Text20{$k}))
  //If (aQR_Text7{$k}="rut")
  //$t_rut:=aQR_Text11{$k}
  //End if 
  //If (aQR_Text11{$k}="null")
  //aQR_Text11{$k}:=""
  //End if 
  //End for 

  //If (CTRY_CL_VerifRUT ($t_rut;False)#"")
  //$l_recNum:=Find in field([Personas]RUT;$t_rut)
  //If ($l_recNum=-1)  //si la madre existe en la base, no se importa.
  //CREATE RECORD([Personas])
  //[Personas]No:=SQ_SeqNumber (->[Personas]No)

  //$l_idApdoEducAnterior:=0
  //For ($r;1;Size of array(aQR_Text7))
  //$l_indice:=Find in array(aQR_Text9;aQR_Text7{$r})
  //If ($l_indice>0)

  //If (Table(->[STR_EducacionAnterior])=Table(aQR_Pointer2{$l_indice}))
  //If ((aQR_Text7{$r}="colegio_asistio") | (aQR_Text7{$r}="universidad_asistio"))
  //CREATE RECORD([STR_EducacionAnterior])
  //$l_idApdoEducAnterior:=SQ_SeqNumber (->[STR_EducacionAnterior]ID_EducacionAnterior)
  //[STR_EducacionAnterior]ID_EducacionAnterior:=$l_idApdoEducAnterior
  //[STR_EducacionAnterior]Tipo_Persona:="pe"
  //[STR_EducacionAnterior]ID_Persona:=[Personas]No
  //[STR_EducacionAnterior]País:=<>gPais
  //If (aQR_Text7{$r}="colegio_asistio")
  //[STR_EducacionAnterior]Tipo_Institucion:="Colegio"
  //Else 
  //[STR_EducacionAnterior]Tipo_Institucion:="Estudio Universitario"
  //End if 
  //[STR_EducacionAnterior]Nombre_Colegio:=aQR_Text11{$r}
  //Else 
  //If ($l_idApdoEducAnterior#0)
  //KRL_FindAndLoadRecordByIndex (->[STR_EducacionAnterior]ID_EducacionAnterior;->$l_idApdoEducAnterior;True)
  //If (ok=1)
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //If (aQR_Text7{$r}="rut")
  //$t_rut:=aQR_Text11{$r}
  //End if 
  //End if 
  //End if 
  //End if 
  //SAVE RECORD([STR_EducacionAnterior])
  //Else 
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //End if 

  //End if 
  //End for 

  //[Personas]Apellido_paterno:=ST_Format (->[Personas]Apellido_paterno)
  //[Personas]Apellido_materno:=ST_Format (->[Personas]Apellido_materno)
  //[Personas]Nombres:=ST_Format (->[Personas]Nombres)
  //[Personas]Apellidos_y_nombres:=Replace string([Personas]Apellido_paterno+" "+[Personas]Apellido_materno+" "+[Personas]Nombres;"  ";" ")
  //[Personas]Apellidos_y_nombres:=ST_Format (->[Personas]Apellidos_y_nombres)

  //SAVE RECORD([Personas])
  //$l_idMadre:=[Personas]No
  //Else 
  //$b_errorMadre:=True
  //GOTO RECORD([Personas];$l_recNum)
  //$l_idMadre:=[Personas]No
  //End if 
  //Else 
  //$b_errorRutMadre:=True
  //End if 

  //KRL_UnloadReadOnly (->[Personas])
  //KRL_UnloadReadOnly (->[STR_EducacionAnterior])

  //End if 

  //If ($t_tipo="padre")  // padre
  //$t_rut:=""
  //UFLD_LoadFileTplt (->[Personas])
  //JSON GET CHILD NODES (aQR_Text19{$i};aQR_Text20;aQR_Longint7;aQR_Text16)
  //ARRAY TEXT(aQR_Text7;0)
  //ARRAY TEXT(aQR_Text11;0)
  //For ($k;1;Size of array(aQR_Text20))
  //APPEND TO ARRAY(aQR_Text7;aQR_Text16{$k})
  //APPEND TO ARRAY(aQR_Text11;JSON Get text (aQR_Text20{$k}))
  //If (aQR_Text7{$k}="rut")
  //$t_rut:=aQR_Text11{$k}
  //End if 
  //If (aQR_Text11{$k}="null")
  //aQR_Text11{$k}:=""
  //End if 
  //End for 

  //If (CTRY_CL_VerifRUT ($t_rut;False)#"")
  //$l_recNum:=Find in field([Personas]RUT;$t_rut)
  //If ($l_recNum=-1)  //si el padre existe en la base, no se importa.
  //CREATE RECORD([Personas])
  //[Personas]No:=SQ_SeqNumber (->[Personas]No)

  //$l_idApdoEducAnterior:=0
  //For ($r;1;Size of array(aQR_Text7))
  //$l_indice:=Find in array(aQR_Text9;aQR_Text7{$r})
  //If ($l_indice>0)

  //If (Table(->[STR_EducacionAnterior])=Table(aQR_Pointer2{$l_indice}))
  //If ((aQR_Text7{$r}="colegio_asistio") | (aQR_Text7{$r}="universidad_asistio"))
  //CREATE RECORD([STR_EducacionAnterior])
  //$l_idApdoEducAnterior:=SQ_SeqNumber (->[STR_EducacionAnterior]ID_EducacionAnterior)
  //[STR_EducacionAnterior]ID_EducacionAnterior:=$l_idApdoEducAnterior
  //[STR_EducacionAnterior]Tipo_Persona:="pe"
  //[STR_EducacionAnterior]ID_Persona:=[Personas]No
  //[STR_EducacionAnterior]País:=<>gPais
  //If (aQR_Text7{$r}="colegio_asistio")
  //[STR_EducacionAnterior]Tipo_Institucion:="Colegio"
  //Else 
  //[STR_EducacionAnterior]Tipo_Institucion:="Estudio Universitario"
  //End if 
  //[STR_EducacionAnterior]Nombre_Colegio:=aQR_Text11{$r}
  //Else 
  //If ($l_idApdoEducAnterior#0)
  //KRL_FindAndLoadRecordByIndex (->[STR_EducacionAnterior]ID_EducacionAnterior;->$l_idApdoEducAnterior;True)
  //If (ok=1)
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //If (aQR_Text7{$r}="rut")
  //$t_rut:=aQR_Text11{$r}
  //End if 
  //End if 
  //End if 
  //End if 
  //SAVE RECORD([STR_EducacionAnterior])
  //Else 
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //End if 

  //End if 
  //End for 

  //[Personas]Apellido_paterno:=ST_Format (->[Personas]Apellido_paterno)
  //[Personas]Apellido_materno:=ST_Format (->[Personas]Apellido_materno)
  //[Personas]Nombres:=ST_Format (->[Personas]Nombres)
  //[Personas]Apellidos_y_nombres:=Replace string([Personas]Apellido_paterno+" "+[Personas]Apellido_materno+" "+[Personas]Nombres;"  ";" ")
  //[Personas]Apellidos_y_nombres:=ST_Format (->[Personas]Apellidos_y_nombres)

  //SAVE RECORD([Personas])
  //$l_idPadre:=[Personas]No
  //Else 
  //GOTO RECORD([Personas];$l_recNum)
  //$l_idPadre:=[Personas]No
  //$b_errorPadre:=True
  //End if 
  //Else 
  //$b_errorRutPadre:=True
  //End if 
  //KRL_UnloadReadOnly (->[Personas])

  //End if 

  //If ($t_tipo="apoacademico")  // ap academico
  //$t_rut:=""
  //UFLD_LoadFileTplt (->[Personas])
  //JSON GET CHILD NODES (aQR_Text19{$i};aQR_Text20;aQR_Longint7;aQR_Text16)
  //ARRAY TEXT(aQR_Text7;0)
  //ARRAY TEXT(aQR_Text11;0)
  //For ($k;1;Size of array(aQR_Text20))
  //APPEND TO ARRAY(aQR_Text7;aQR_Text16{$k})
  //APPEND TO ARRAY(aQR_Text11;JSON Get text (aQR_Text20{$k}))
  //If (aQR_Text7{$k}="rut")
  //$t_rut:=aQR_Text11{$k}
  //End if 
  //If (aQR_Text11{$k}="null")
  //aQR_Text11{$k}:=""
  //End if 
  //End for 

  //If (CTRY_CL_VerifRUT ($t_rut;False)#"")
  //$l_recNum:=Find in field([Personas]RUT;$t_rut)
  //If ($l_recNum=-1)
  //CREATE RECORD([Personas])
  //[Personas]No:=SQ_SeqNumber (->[Personas]No)

  //$l_idApdoEducAnterior:=0
  //For ($r;1;Size of array(aQR_Text7))
  //$l_indice:=Find in array(aQR_Text9;aQR_Text7{$r})
  //If ($l_indice>0)

  //If (Table(->[STR_EducacionAnterior])=Table(aQR_Pointer2{$l_indice}))
  //If ((aQR_Text7{$r}="colegio_asistio") | (aQR_Text7{$r}="universidad_asistio"))
  //CREATE RECORD([STR_EducacionAnterior])
  //$l_idApdoEducAnterior:=SQ_SeqNumber (->[STR_EducacionAnterior]ID_EducacionAnterior)
  //[STR_EducacionAnterior]ID_EducacionAnterior:=$l_idApdoEducAnterior
  //[STR_EducacionAnterior]Tipo_Persona:="pe"
  //[STR_EducacionAnterior]ID_Persona:=[Personas]No
  //[STR_EducacionAnterior]País:=<>gPais
  //If (aQR_Text7{$r}="colegio_asistio")
  //[STR_EducacionAnterior]Tipo_Institucion:="Colegio"
  //Else 
  //[STR_EducacionAnterior]Tipo_Institucion:="Estudio Universitario"
  //End if 
  //[STR_EducacionAnterior]Nombre_Colegio:=aQR_Text11{$r}
  //Else 
  //If ($l_idApdoEducAnterior#0)
  //KRL_FindAndLoadRecordByIndex (->[STR_EducacionAnterior]ID_EducacionAnterior;->$l_idApdoEducAnterior;True)
  //If (ok=1)
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //If (aQR_Text7{$r}="rut")
  //$t_rut:=aQR_Text11{$r}
  //End if 
  //End if 
  //End if 
  //End if 
  //SAVE RECORD([STR_EducacionAnterior])
  //Else 
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //End if 

  //End if 
  //End for 

  //[Personas]Apellido_paterno:=ST_Format (->[Personas]Apellido_paterno)
  //[Personas]Apellido_materno:=ST_Format (->[Personas]Apellido_materno)
  //[Personas]Nombres:=ST_Format (->[Personas]Nombres)
  //[Personas]Apellidos_y_nombres:=Replace string([Personas]Apellido_paterno+" "+[Personas]Apellido_materno+" "+[Personas]Nombres;"  ";" ")
  //[Personas]Apellidos_y_nombres:=ST_Format (->[Personas]Apellidos_y_nombres)

  //SAVE RECORD([Personas])
  //$l_idApAcad:=[Personas]No
  //Else 
  //GOTO RECORD([Personas];$l_recNum)
  //If (Records in selection([Personas])=1)
  //If (([Personas]No=$l_idMadre) | ([Personas]No=$l_idPadre))  // si es igual al padre importado o a la madre importada, continúo.
  //$l_idApAcad:=[Personas]No
  //Else 
  //$l_idApAcad:=[Personas]No
  //$b_errorApAcad:=True
  //End if 
  //Else 
  //$b_errorApAcad:=True
  //End if 
  //End if 
  //Else 
  //$b_errorRutApdoAcad:=True
  //End if 
  //KRL_UnloadReadOnly (->[Personas])

  //End if 

  //If ($t_tipo="apocuentas")  // ap cuentas
  //$t_rut:=""
  //UFLD_LoadFileTplt (->[Personas])
  //JSON GET CHILD NODES (aQR_Text19{$i};aQR_Text20;aQR_Longint7;aQR_Text16)
  //ARRAY TEXT(aQR_Text7;0)
  //ARRAY TEXT(aQR_Text11;0)
  //For ($k;1;Size of array(aQR_Text20))
  //APPEND TO ARRAY(aQR_Text7;aQR_Text16{$k})
  //APPEND TO ARRAY(aQR_Text11;JSON Get text (aQR_Text20{$k}))
  //If (aQR_Text7{$k}="rut")
  //$t_rut:=aQR_Text11{$k}
  //End if 
  //If (aQR_Text11{$k}="null")
  //aQR_Text11{$k}:=""
  //End if 
  //End for 

  //If (CTRY_CL_VerifRUT ($t_rut;False)#"")
  //$l_recNum:=Find in field([Personas]RUT;$t_rut)
  //If ($l_recNum=-1)

  //CREATE RECORD([Personas])
  //[Personas]No:=SQ_SeqNumber (->[Personas]No)

  //$l_idApdoEducAnterior:=0
  //For ($r;1;Size of array(aQR_Text7))
  //$l_indice:=Find in array(aQR_Text9;aQR_Text7{$r})
  //If ($l_indice>0)

  //If (Table(->[STR_EducacionAnterior])=Table(aQR_Pointer2{$l_indice}))
  //If ((aQR_Text7{$r}="colegio_asistio") | (aQR_Text7{$r}="universidad_asistio"))
  //CREATE RECORD([STR_EducacionAnterior])
  //$l_idApdoEducAnterior:=SQ_SeqNumber (->[STR_EducacionAnterior]ID_EducacionAnterior)
  //[STR_EducacionAnterior]ID_EducacionAnterior:=$l_idApdoEducAnterior
  //[STR_EducacionAnterior]Tipo_Persona:="pe"
  //[STR_EducacionAnterior]ID_Persona:=[Personas]No
  //[STR_EducacionAnterior]País:=<>gPais
  //If (aQR_Text7{$r}="colegio_asistio")
  //[STR_EducacionAnterior]Tipo_Institucion:="Colegio"
  //Else 
  //[STR_EducacionAnterior]Tipo_Institucion:="Estudio Universitario"
  //End if 
  //[STR_EducacionAnterior]Nombre_Colegio:=aQR_Text11{$r}
  //Else 
  //If ($l_idApdoEducAnterior#0)
  //KRL_FindAndLoadRecordByIndex (->[STR_EducacionAnterior]ID_EducacionAnterior;->$l_idApdoEducAnterior;True)
  //If (ok=1)
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //If (aQR_Text7{$r}="rut")
  //$t_rut:=aQR_Text11{$r}
  //End if 
  //End if 
  //End if 
  //End if 
  //SAVE RECORD([STR_EducacionAnterior])
  //Else 
  //$type:=Type(aQR_Pointer2{$l_indice}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer2{$l_indice}->:=aQR_Text11{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer2{$l_indice}->:=Num(aQR_Text11{$r})
  //: ($type=Is date)
  //aQR_Pointer2{$l_indice}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text11{$r};9;2));Num(Substring(aQR_Text11{$r};6;2));Num(Substring(aQR_Text11{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text11{$r}="true") | (aQR_Text11{$r}="verdadero") | (aQR_Text11{$r}="1") | (aQR_Text11{$r}="Si"))
  //aQR_Pointer2{$l_indice}->:=True
  //Else 
  //aQR_Pointer2{$l_indice}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //End if 

  //End if 
  //End for 

  //[Personas]Apellido_paterno:=ST_Format (->[Personas]Apellido_paterno)
  //[Personas]Apellido_materno:=ST_Format (->[Personas]Apellido_materno)
  //[Personas]Nombres:=ST_Format (->[Personas]Nombres)
  //[Personas]Apellidos_y_nombres:=Replace string([Personas]Apellido_paterno+" "+[Personas]Apellido_materno+" "+[Personas]Nombres;"  ";" ")
  //[Personas]Apellidos_y_nombres:=ST_Format (->[Personas]Apellidos_y_nombres)

  //SAVE RECORD([Personas])
  //$l_idApCuenta:=[Personas]No
  //Else 
  //GOTO RECORD([Personas];$l_recNum)
  //If (Records in selection([Personas])=1)
  //If (([Personas]No=$l_idMadre) | ([Personas]No=$l_idPadre))  // si es igual al padre importado o a la madre importada, continúo.
  //$l_idApCuenta:=[Personas]No
  //Else 
  //$l_idApCuenta:=[Personas]No
  //$b_errorApCta:=True
  //End if 
  //Else 
  //$b_errorApCta:=True
  //End if 
  //End if 
  //Else 
  //$b_errorRutApdoCta:=True
  //End if 
  //KRL_UnloadReadOnly (->[Personas])

  //End if 

  //End for 
  //JSON CLOSE ($root)

  //ARRAY LONGINT(aQR_Longint9;0)
  //ARRAY LONGINT(aQR_Longint10;0)

  //If (($b_errorMadre) | ($b_errorPadre) | ($b_errorApAcad) | ($b_errorApCta))

  //APPEND TO ARRAY(aQR_Longint10;$l_idMadre)
  //APPEND TO ARRAY(aQR_Longint10;$l_idPadre)
  //APPEND TO ARRAY(aQR_Longint10;$l_idApAcad)
  //APPEND TO ARRAY(aQR_Longint10;$l_idApCuenta)

  //For ($k;1;Size of array(aQR_Longint10))
  //READ ONLY([Personas])
  //READ ONLY([Familia_RelacionesFamiliares])
  //READ ONLY([Familia])
  //QUERY([Personas];[Personas]No=aQR_Longint10{$k})
  //KRL_RelateSelection (->[Familia_RelacionesFamiliares]ID_Persona;->[Personas]No;"")
  //KRL_RelateSelection (->[Familia]Numero;->[Familia_RelacionesFamiliares]ID_Familia;"")
  //While (Not(End selection([Familia])))
  //APPEND TO ARRAY(aQR_Longint9;[Familia]Numero)
  //NEXT RECORD([Familia])
  //End while 
  //End for 
  //AT_DistinctsArrayValues (->aQR_Longint9)

  //If (Size of array(aQR_Longint9)=1)
  //$b_errorMadre:=False
  //$b_errorPadre:=False
  //$b_errorApAcad:=False
  //$b_errorApCta:=False
  //End if 

  //End if 

  //If (((Size of array(aQR_Longint9)=0) | (Size of array(aQR_Longint9)=1)) & Not($b_errorAlumno) & Not($b_errorApAcad) & Not($b_errorApCta) & Not($b_errorCreaFamilia) & Not($b_errorMadre) & Not($b_errorPadre) & Not($b_errorRutMadre) & Not($b_errorRutPadre) & Not($b_errorRutAlumno) & Not($b_errorRutApdoAcad) & Not($b_errorRutApdoCta) & Not($b_errorCuenta))

  //  //crea familia
  //KRL_FindAndLoadRecordByIndex (->[Alumnos]Número;->aQR_Longint1{1})
  //If (Size of array(aQR_Longint9)=0)
  //CREATE RECORD([Familia])
  //[Familia]Numero:=SQ_SeqNumber (->[Familia]Numero)
  //Else 
  //KRL_FindAndLoadRecordByIndex (->[Familia]Numero;->aQR_Longint9{1};True)
  //End if 
  //[Familia]Nombre_de_la_familia:=[Alumnos]Apellido_paterno+" "+[Alumnos]Apellido_materno
  //[Familia]Grupo_Familia:=[Alumnos]Grupo
  //[Familia]Dirección:=[Alumnos]Direccion
  //[Familia]Comuna:=[Alumnos]Comuna
  //[Familia]Ciudad:=[Alumnos]Ciudad
  //[Familia]Telefono:=[Alumnos]Telefono
  //[Familia]Es_Postulante:=True
  //[Familia]Madre_Número:=$l_idMadre
  //[Familia]Padre_Número:=$l_idPadre

  //For ($r;1;Size of array(aQR_Text22))
  //  //APPEND TO ARRAY(aQR_Text22;aQR_Text6{$r})
  //  //APPEND TO ARRAY(aQR_Pointer3;aQR_Pointer1{$l_indice})
  //$type:=Type(aQR_Pointer3{$r}->)
  //Case of 
  //: (($type=Is alpha field) | ($type=Is string var) | ($type=Is text))
  //aQR_Pointer3{$r}->:=aQR_Text23{$r}
  //: (($type=Is real) | ($type=Is longint) | ($type=Is integer))
  //aQR_Pointer3{$r}->:=Num(aQR_Text23{$r})
  //: ($type=Is date)
  //aQR_Pointer3{$r}->:=DT_GetDateFromDayMonthYear (Num(Substring(aQR_Text23{$r};9;2));Num(Substring(aQR_Text23{$r};6;2));Num(Substring(aQR_Text23{$r};1;4)))
  //: ($type=Is Boolean)
  //If ((aQR_Text23{$r}="true") | (aQR_Text23{$r}="verdadero") | (aQR_Text23{$r}="1") | (aQR_Text23{$r}="Si"))
  //aQR_Pointer3{$r}->:=True
  //Else 
  //aQR_Pointer3{$r}->:=False
  //End if 
  //Else 
  //CD_Dlog (0;"CAMPO NO SOPORTADO")
  //End case 
  //End for 

  //SAVE RECORD([Familia])
  //$l_idFamilia:=[Familia]Numero
  //KRL_UnloadReadOnly (->[Familia])

  //For ($i;1;Size of array(aQR_Longint1))
  //KRL_FindAndLoadRecordByIndex (->[Alumnos]Número;->aQR_Longint1{$i};True)
  //If (ok=1)
  //[Alumnos]Familia_Número:=$l_idFamilia
  //[Alumnos]Apoderado_académico_Número:=$l_idApAcad
  //[Alumnos]Apoderado_Cuentas_Número:=$l_idApCuenta
  //SAVE RECORD([Alumnos])
  //Else 
  //$b_errorCreaFamilia:=True
  //End if 
  //KRL_UnloadReadOnly (->[Alumnos])
  //End for 

  //  //TGR_Familias

  //If (Size of array(aQR_Longint9)=0)
  //  //crea relaciones familiares
  //CREATE RECORD([Familia_RelacionesFamiliares])
  //[Familia_RelacionesFamiliares]ID_Familia:=$l_idFamilia
  //[Familia_RelacionesFamiliares]ID_Persona:=$l_idPadre
  //[Familia_RelacionesFamiliares]Tipo_Relación:=2
  //[Familia_RelacionesFamiliares]Parentesco:=__ ("Padre")
  //Case of 
  //: (($l_idPadre#$l_idApAcad) & ($l_idPadre#$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=0
  //: (($l_idPadre=$l_idApAcad) & ($l_idPadre#$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=1
  //: (($l_idPadre#$l_idApAcad) & ($l_idPadre=$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=2
  //: (($l_idPadre=$l_idApAcad) & ($l_idPadre=$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=3
  //End case 
  //SAVE RECORD([Familia_RelacionesFamiliares])
  //KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares])

  //CREATE RECORD([Familia_RelacionesFamiliares])
  //[Familia_RelacionesFamiliares]ID_Familia:=$l_idFamilia
  //[Familia_RelacionesFamiliares]ID_Persona:=$l_idMadre
  //[Familia_RelacionesFamiliares]Tipo_Relación:=1
  //[Familia_RelacionesFamiliares]Parentesco:=__ ("Madre")
  //Case of 
  //: (($l_idMadre#$l_idApAcad) & ($l_idMadre#$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=0
  //: (($l_idMadre=$l_idApAcad) & ($l_idMadre#$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=1
  //: (($l_idMadre#$l_idApAcad) & ($l_idMadre=$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=2
  //: (($l_idMadre=$l_idApAcad) & ($l_idMadre=$l_idApCuenta))
  //[Familia_RelacionesFamiliares]Apoderado:=3
  //End case 
  //SAVE RECORD([Familia_RelacionesFamiliares])
  //KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares])

  //If (($l_idMadre#$l_idApAcad) & ($l_idPadre#$l_idApAcad))  //si el apdo academico es distinto de la madre y padre, lo creo como relacion
  //CREATE RECORD([Familia_RelacionesFamiliares])
  //[Familia_RelacionesFamiliares]ID_Familia:=$l_idFamilia
  //[Familia_RelacionesFamiliares]ID_Persona:=$l_idApAcad
  //[Familia_RelacionesFamiliares]Tipo_Relación:=11
  //[Familia_RelacionesFamiliares]Parentesco:=__ ("Otros")
  //Case of 
  //: ($l_idApAcad#$l_idApCuenta)
  //[Familia_RelacionesFamiliares]Apoderado:=1
  //: ($l_idApAcad=$l_idApCuenta)
  //[Familia_RelacionesFamiliares]Apoderado:=3
  //End case 
  //SAVE RECORD([Familia_RelacionesFamiliares])
  //KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares])
  //End if 

  //If (($l_idMadre#$l_idApCuenta) & ($l_idPadre#$l_idApCuenta) & ($l_idApAcad#$l_idApCuenta))  //si el apdo de cuenta es distinto de la madre, padre y academico, lo creo como relacion
  //CREATE RECORD([Familia_RelacionesFamiliares])
  //[Familia_RelacionesFamiliares]ID_Familia:=$l_idFamilia
  //[Familia_RelacionesFamiliares]ID_Persona:=$l_idApCuenta
  //[Familia_RelacionesFamiliares]Tipo_Relación:=11
  //[Familia_RelacionesFamiliares]Parentesco:=__ ("Otros")
  //Case of 
  //: ($l_idApAcad#$l_idApCuenta)
  //[Familia_RelacionesFamiliares]Apoderado:=1
  //: ($l_idApAcad=$l_idApCuenta)
  //[Familia_RelacionesFamiliares]Apoderado:=3
  //End case 

  //Case of 
  //: ($l_idPadre#$l_idApAcad)
  //[Familia_RelacionesFamiliares]Apoderado:=2
  //: ($l_idPadre=$l_idApAcad)
  //[Familia_RelacionesFamiliares]Apoderado:=3
  //End case 

  //SAVE RECORD([Familia_RelacionesFamiliares])
  //KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares])
  //End if 
  //End if 
  //  //***** SchoolTrack *****

  //  //***** AccountTrack *****

  //AT_Text2Array (->aQR_Text1;$t_rutsAlumnos;",")

  //AT_Text2Array (->aQR_Text12;$t_itemsCobrados;",")

  //AT_Text2Array (->aQR_Text13;$t_montosCobrados;",")

  //AT_RedimArrays (Size of array(aQR_Text13);->aQR_Longint3)

  //  //conf item
  //For ($i;1;Size of array(aQR_Text12))
  //$l_recNum:=Find in field([xxACT_Items]Glosa;aQR_Text12{$i})
  //If ($l_recNum=-1)
  //$vt_glosa:=aQR_Text12{$i}
  //$vb_afecto:=False
  //$vb_esDescuento:=False
  //$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
  //$vr_monto:=Num(aQR_Text13{$i})
  //$vt_ctaContable:=""
  //$vt_ctaAuxiliar:=""
  //$vt_centroCosto:=""
  //$vt_cctaContable:=""
  //$vt_cctaAuxiliar:=""
  //$vt_ccentroCosto:=""
  //$vb_noIncluirDT:=False
  //$vt_obs:=__ ("Creado por proceso de importación de admisiones realizado por ")+<>tUSR_CurrentUser+__ (" el ")+String(Current date(*);7)+__ (" a las ")+String(Current time(*);2)
  //aQR_Longint3{$i}:=ACTitem_CreateRecord ($vt_glosa;$vb_afecto;$vb_esDescuento;$vt_moneda;$vr_monto;$vt_ctaContable;$vt_ctaAuxiliar;$vt_centroCosto;$vt_cctaContable;$vt_cctaAuxiliar;$vt_ccentroCosto;$vb_noIncluirDT;$vt_obs)
  //Else 
  //GOTO RECORD([xxACT_Items];$l_recNum)
  //aQR_Longint3{$i}:=[xxACT_Items]ID
  //  //$vl_idRecord:=[xxACT_Items]ID
  //End if 
  //End for 

  //  //cargo
  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_idApCuenta)
  //vdACT_FechaPago:=$d_fecha
  //vdACT_FechaE:=vdACT_FechaPago
  //C_REAL(RNApdo)
  //C_LONGINT(RNTercero)
  //C_REAL(vrACT_MontoAdeudado)
  //vrACT_MontoAdeudado:=0

  //ptrACTpgs_Table:=->[Personas]
  //ptrACTpgs_FieldID:=->[Personas]No
  //ptrACTpgs_VarRecNum:=->RNApdo
  //ptrACTpgs_FieldDT:=->[Personas]ACT_DocumentoTributario
  //ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
  //ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
  //ACTcfg_LeeBlob ("ACT_DescuentosFamilia")

  //$l_idCargo:=0
  //For ($i;1;Size of array(aQR_Text1))
  //$t_rut:=aQR_Text1{$i}
  //KRL_FindAndLoadRecordByIndex (->[Alumnos]RUT;->$t_rut)
  //KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes]ID_Alumno;->[Alumnos]Número)
  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_idApCuenta)
  //If ((Records in selection([ACT_CuentasCorrientes])=1) & (Records in selection([Personas])=1))
  //If ($i=1)
  //$b_mismoAviso:=False
  //Else 
  //$b_mismoAviso:=True
  //End if 
  //$b_enBoleta:=KRL_GetBooleanFieldData (->[xxACT_Items]ID;->aQR_Longint3{$i};->[xxACT_Items]No_incluir_en_DocTributario)

  //APPEND TO ARRAY(aQR_Longint4;ACTac_CreateCargoDocCargoImp (True;aQR_Longint3{$i};Num(aQR_Text13{$i});Current date(*);$b_mismoAviso;[ACT_CuentasCorrientes]ID;[Personas]No;$b_enBoleta;False;0;False;$l_idCargo;True))
  //KRL_GotoRecord (->[ACT_Cargos];aQR_Longint4{Size of array(aQR_Longint4)};True)
  //If (ok=1)
  //[ACT_Cargos]Venta_Directa:=False
  //$l_idCargo:=[ACT_Cargos]ID
  //SAVE RECORD([ACT_Cargos])
  //Else 
  //$b_errorCargos:=True
  //$i:=Size of array(aQR_Text1)
  //End if 
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //Else 
  //$b_errorCargos:=True
  //$i:=Size of array(aQR_Text1)
  //End if 
  //End for 

  //READ ONLY([ACT_Cargos])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //CREATE SELECTION FROM ARRAY([ACT_Cargos];aQR_Longint4;"")

  //If (Records in selection([ACT_Cargos])>0)
  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;"")
  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;"")
  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza]ID_Aviso;aQR_Longint2)
  //If (Records in selection([ACT_Avisos_de_Cobranza])#1)
  //$b_errorAvisos:=True
  //Else 
  //$t_idsAvisos:=AT_array2text (->aQR_Longint2;",";"############")
  //End if 
  //Else 
  //$b_errorCargos:=True
  //End if 

  //  //***** AccountTrack *****
  //End if 

  //Case of 
  //: ($b_errorAlumno)
  //$json:=ADTwa_RespuestaError (-4)
  //: ($b_errorApAcad)
  //$json:=ADTwa_RespuestaError (-5)
  //: ($b_errorApCta)
  //$json:=ADTwa_RespuestaError (-6)
  //: ($b_errorCreaFamilia)
  //$json:=ADTwa_RespuestaError (-7)
  //: ($b_errorMadre)
  //$json:=ADTwa_RespuestaError (-8)
  //: ($b_errorPadre)
  //$json:=ADTwa_RespuestaError (-9)
  //: ($b_errorAvisos)
  //$json:=ADTwa_RespuestaError (-10)
  //: ($b_errorCargos)
  //$json:=ADTwa_RespuestaError (-11)
  //: ($b_errorRutMadre)
  //$json:=ADTwa_RespuestaError (-12)
  //: ($b_errorRutPadre)
  //$json:=ADTwa_RespuestaError (-13)
  //: ($b_errorRutAlumno)
  //$json:=ADTwa_RespuestaError (-14)
  //: ($b_errorRutApdoAcad)
  //$json:=ADTwa_RespuestaError (-15)
  //: ($b_errorRutApdoCta)
  //$json:=ADTwa_RespuestaError (-16)
  //: ($b_errorCuenta)
  //$json:=ADTwa_RespuestaError (-17)
  //: (Size of array(aQR_Longint9)>1)
  //$json:=ADTwa_RespuestaError (-20)

  //Else 
  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_idApCuenta)
  //$json:=ACTwa_IngresaPago (Num($t_montoPagado);$t_idsAvisos;$d_fecha;"";False)
  //End case 

  //$root:=JSON Parse text ($json)
  //$nodeErr:=JSON Get child by name ($root;"estado")
  //$nodeErrCod:=JSON Get child by name ($nodeErr;"codigo")
  //$r_procesado:=JSON Get real ($nodeErrCod)
  //If ($r_procesado=0)
  //$nodeErr:=JSON Get child by name ($root;"pagos")
  //JSON GET CHILD NODES ($nodeErr;aQR_Text24;aQR_Longint11;aQR_Text25)
  //For ($i;1;Size of array(aQR_Text24))
  //JSON GET CHILD NODES (aQR_Text24{$i};aQR_Text26;aQR_Longint12;aQR_Text27)
  //For ($j;1;Size of array(aQR_Text27))
  //If (aQR_Text27{$j}="idpago")
  //APPEND TO ARRAY(aQR_Longint13;Num(JSON Get text (aQR_Text26{$j})))
  //$j:=Size of array(aQR_Text27)
  //End if 
  //End for 
  //End for 
  //End if 
  //JSON CLOSE ($root)

  //If ($r_procesado=0)
  //READ ONLY([ACT_Pagos])
  //READ ONLY([ACT_Transacciones])

  //QUERY WITH ARRAY([ACT_Pagos]ID;aQR_Longint13)
  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]Nulo=False;*)
  //QUERY SELECTION([ACT_Pagos]; & ;[ACT_Pagos]Fecha=$d_fecha;*)
  //QUERY SELECTION([ACT_Pagos]; & ;[ACT_Pagos]ID_WebpayOC=0)

  //If (Records in selection([ACT_Pagos])>1)
  //READ ONLY([ACT_CuentasCorrientes])
  //QUERY WITH ARRAY([ACT_CuentasCorrientes]ID_Alumno;aQR_Longint1)
  //While (Not(End selection([ACT_CuentasCorrientes])))
  //APPEND TO ARRAY(aQR_Longint14;[ACT_CuentasCorrientes]ID)
  //NEXT RECORD([ACT_CuentasCorrientes])
  //End while 
  //KRL_RelateSelection (->[ACT_Transacciones]ID_Pago;->[ACT_Pagos]ID;"")
  //QUERY SELECTION WITH ARRAY([ACT_Transacciones]ID_CuentaCorriente;aQR_Longint14)
  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
  //End if 

  //If (Records in selection([ACT_Pagos])=1)
  //KRL_ReloadInReadWriteMode (->[ACT_Pagos])
  //[ACT_Pagos]ID_WebpayOC:=Num($t_ordenDeCompraWP)
  //SAVE RECORD([ACT_Pagos])
  //KRL_UnloadReadOnly (->[ACT_Pagos])
  //End if 
  //End if 

  //If ($r_procesado=0)
  //VALIDATE TRANSACTION
  //Else 
  //CANCEL TRANSACTION
  //End if 

  //AT_Initialize (->aQR_Longint1;->aQR_Longint2;->aQR_Text1;->aQR_Longint5;->aQR_Longint6;->aQR_Longint7;->aQR_Longint8;->aQR_Pointer1;->aQR_Pointer2)
  //AT_Initialize (->aQR_Text6;->aQR_Text7;->aQR_Text8;->aQR_Text9;->aQR_Text10;->aQR_Text11;->aQR_Text12;->aQR_Text13;->aQR_Longint3)
  //AT_Initialize (->aQR_Text14;->aQR_Text15;->aQR_Text16;->aQR_Text17;->aQR_Text18;->aQR_Text19;->aQR_Text20;->aQR_Text21)
  //AT_Initialize (->aQR_Longint4;->aQR_Text22;->aQR_Pointer3;->aQR_Text23)
  //AT_Initialize (->aQR_Longint9;->aQR_Longint10)

  //  //para asignar orden de compra
  //AT_Initialize (->aQR_Text24;->aQR_Longint11;->aQR_Text25)
  //AT_Initialize (->aQR_Text26;->aQR_Longint12;->aQR_Text27)
  //AT_Initialize (->aQR_Longint13;->aQR_Longint14)  //ids cuentas corrientes

  //t_respuestaJSON:=$json
  //  //$0:=$json
