//%attributes = {}
  //C_TEXT($json;$0)
  //C_LONGINT($periodo;$1)

  //$periodo:=$1
  //$profID:=$2
  //$userID:=$3

  //PERIODOS_Init 
  //PERIODOS_LoadData ([Asignaturas]Numero_del_Nivel)
  //  //If (($periodo=0) | ($periodo>aiSTR_Periodos_Numero{Size of array(aiSTR_Periodos_Numero)}))
  //  //$periodo:=PERIODOS_PeriodosActuales (Current date(*);True)
  //  //End if 
  //If ($periodo=0)
  //$periodo:=viSTR_PeriodoActual_Numero
  //End if 
  //If ($periodo>aiSTR_Periodos_Numero{Size of array(aiSTR_Periodos_Numero)})
  //$periodo:=Size of array(aiSTR_Periodos_Numero)
  //End if 
  //EVS_initialize 
  //EVS_ReadStyleData ([Asignaturas]Numero_de_EstiloEvaluacion)
  //AS_PropEval_Lectura ("";$periodo)
  //EV2_LeeCalificaciones ([Asignaturas]Numero;$periodo)
  //$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles]NoNivel;->[Asignaturas]Numero_del_Nivel;->[xxSTR_Niveles]AttendanceMode)

  //  //NTA_ModeConversion (1;iEvaluationMode)  //fuerza el despliegue en iEvaluationMode

  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort (" >>";->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF)
  //Else 
  //SORT ARRAY(aNtaStdNme;aNtaOrden;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF)
  //End if 
  //: (<>gOrdenNta=1)
  //SORT ARRAY(aNtaOrden;aNtaStdNme;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF)
  //: (<>gOrdenNta=2)
  //SORT ARRAY(aNtaStdNme;aNtaOrden;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort ("< >>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF)
  //Else 
  //AT_MultiLevelSort ("<  >";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF)
  //End if 
  //: (<>gOrdenNta=1)
  //AT_MultiLevelSort ("<>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF)
  //: (<>gOrdenNta=2)
  //AT_MultiLevelSort ("<  >";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF)
  //End case 
  //End if 

  //  //20150915 ASM Ticket 149071 
  //ARRAY TEXT(par1_edit;0)
  //ARRAY TEXT(par2_edit;0)
  //ARRAY TEXT(par3_edit;0)
  //ARRAY TEXT(par4_edit;0)
  //ARRAY TEXT(par5_edit;0)
  //ARRAY TEXT(par6_edit;0)
  //ARRAY TEXT(par7_edit;0)
  //ARRAY TEXT(par8_edit;0)
  //ARRAY TEXT(par9_edit;0)
  //ARRAY TEXT(par10_edit;0)
  //ARRAY TEXT(par11_edit;0)
  //ARRAY TEXT(par12_edit;0)
  //If ((<>viSTR_NoModificarNotas=1) & (Not(USR_checkRights ("M";->[Alumnos_Calificaciones]))))
  //For ($l_indice;1;12)
  //$y_Nta:=Get pointer("aNta"+String($l_indice))
  //$y_parEdit:=Get pointer("par"+String($l_indice)+"_edit")
  //ARRAY TEXT($y_parEdit->;0)
  //For ($l_indice2;1;Size of array($y_Nta->))
  //APPEND TO ARRAY($y_parEdit->;"edit")
  //End for 
  //End for 
  //Else 
  //For ($l_indice;1;12)
  //$y_Nta:=Get pointer("aNta"+String($l_indice))
  //$y_parEdit:=Get pointer("par"+String($l_indice)+"_edit")
  //ARRAY TEXT($y_parEdit->;0)
  //For ($l_indice2;1;Size of array($y_Nta->))
  //If ($y_Nta->{$l_indice2}#"")
  //APPEND TO ARRAY($y_parEdit->;"no-edit")
  //Else 
  //APPEND TO ARRAY($y_parEdit->;"edit")
  //End if 
  //End for 
  //End for 
  //End if 

  //C_BLOB($blob)
  //C_TEXT($text)
  //GET PICTURE FROM LIBRARY(5006;$nonEnterableIconP)
  //GET PICTURE FROM LIBRARY(5005;$enterableIconP)
  //GET PICTURE FROM LIBRARY(5007;$subasignatura_iconoP)
  //GET PICTURE FROM LIBRARY(5008;$consolidante_iconoP)
  //$text:=""
  //SET BLOB SIZE($blob;0)
  //PICTURE TO BLOB($nonEnterableIconP;$blob;".jpg")
  //BASE64 ENCODE($blob;$text)
  //$nonEnterableIconDEF:=Replace string($text;"\n";"")
  //$text:=""
  //SET BLOB SIZE($blob;0)
  //PICTURE TO BLOB($enterableIconP;$blob;".jpg")
  //BASE64 ENCODE($blob;$text)
  //$enterableIconDEF:=Replace string($text;"\n";"")
  //$text:=""
  //SET BLOB SIZE($blob;0)
  //PICTURE TO BLOB($subasignatura_iconoP;$blob;".jpg")
  //BASE64 ENCODE($blob;$text)
  //$subasignatura_iconoDEF:=Replace string($text;"\n";"")
  //$text:=""
  //SET BLOB SIZE($blob;0)
  //PICTURE TO BLOB($consolidante_iconoP;$blob;".jpg")
  //BASE64 ENCODE($blob;$text)
  //$consolidante_iconoDEF:=Replace string($text;"\n";"")

  //$nonEnterableIcon:="noingresable"
  //$enterableIcon:="ingresable"
  //$subasignatura_icono:="subasignatura"
  //$consolidante_icono:="consolidante"


  //ARRAY LONGINT($aEnterable;0)
  //ARRAY TEXT($aIcono;0)
  //ARRAY LONGINT($aTableNumbers;0)
  //ARRAY LONGINT($aFieldNumbers;0)

  //  //$vb_CanModify:=((((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas]Profesor_firmante_numero)) | ($profID=[Asignaturas]Profesor_Numero) | (USR_checkRights ("M";->[Alumnos_Calificaciones];$userID))) & ((adSTR_Periodos_Cierre{$periodo}>Current date(*)) | (adSTR_Periodos_Cierre{$periodo}=!00/00/00!)))
  //  //$vb_CanModify:=(($vb_canModify) | (USR_IsGroupMember_by_GrpID (-15001;$userID)))

  //$calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices]ID_Matriz;->[Asignaturas]EVAPR_IdMatriz;->[MPA_AsignaturasMatrices]Convertir_a_Notas)
  //  //If (((iResults=3) | ([Asignaturas]Resultado_no_calculado)) & ($calculosSobreCompetencias=False) & ($vb_CanModify))
  //  //$promedios_icono:=$enterableIcon
  //  //$promedios_Ingresable:=1
  //  //Else 
  //  //$promedios_icono:=$nonEnterableIcon
  //  //$promedios_Ingresable:=0
  //  //End if 

  //$b_calificacionesEditables:=Not(<>vb_BloquearModifSituacionFinal)
  //$b_calificacionesEditables:=$b_calificacionesEditables & (((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas]Profesor_firmante_numero)) | ($profID=[Asignaturas]Profesor_Numero) | (USR_checkRights ("M";->[Alumnos_Calificaciones];$userID)))
  //$b_calificacionesEditables:=$b_calificacionesEditables & ((adSTR_Periodos_Cierre{$periodo}>Current date(*)) | (adSTR_Periodos_Cierre{$periodo}=!00-00-00!))
  //$b_calificacionesEditables:=$b_calificacionesEditables | (USR_IsGroupMember_by_GrpID (-15001;$userID) | ($userID<0))

  //$b_PromediosEditables:=Not(<>vb_BloquearModifSituacionFinal)
  //$b_PromediosEditables:=$b_PromediosEditables & (((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas]Profesor_firmante_numero)) | ($profID=[Asignaturas]Profesor_Numero) | (USR_checkRights ("M";->[Alumnos_Calificaciones];$userID)))
  //$b_PromediosEditables:=$b_PromediosEditables | ((USR_IsGroupMember_by_GrpID (-15001;$userID)))
  //$b_PromediosEditables:=$b_PromediosEditables & AS_PromediosSonEditables ([Asignaturas]Numero)

  //$b_examenesEditables:=Not(<>vb_BloquearModifSituacionFinal)
  //$b_examenesEditables:=$b_examenesEditables & (((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas]Profesor_firmante_numero)) | ($profID=[Asignaturas]Profesor_Numero) | (USR_checkRights ("M";->[Alumnos_Calificaciones];$userID)))
  //$b_examenesEditables:=$b_examenesEditables | (USR_IsGroupMember_by_GrpID (-15001;$userID) | ($userID<0))

  //$examenesIngresables:=Num($b_examenesEditables)
  //$promedios_Ingresable:=Num($b_PromediosEditables)

  //If ($b_PromediosEditables)
  //$promedios_icono:=$enterableIcon
  //Else 
  //$promedios_icono:=$nonEnterableIcon
  //End if 

  //If ($calculosSobreCompetencias)
  //$b_CalificacionesEditables:=False
  //End if 

  //$enSimbolos:=(iEvaluationMode=Simbolos)

  //$json:=JSON New 
  //STWA2_json_array2json(->$json;->aNtaOrden;"ordenes";"")
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;"")
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]NoDeLista))
  //STWA2_json_array2json(->$json;->aNtaStdNme;"alumnos";"")
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;"")
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos]Apellidos_y_Nombres))
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //STWA2_json_array2json(->$json;->aNtaCurso;"cursos";"")
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;"")
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos]Curso))
  //End if 
  //If ($modoRegistroAsistencia=4)
  //STWA2_json_array2json(->$json;->alSTR_InasistenciasPeriodo;"inasistencia";"########0")
  //If (<>vb_BloquearModifSituacionFinal)
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //Else 
  //APPEND TO ARRAY($aEnterable;1)
  //APPEND TO ARRAY($aIcono;$enterableIcon)
  //End if 
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_ComplementoEvaluacion]))
  //APPEND TO ARRAY($aFieldNumbers;Field(KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String($periodo)+"_Inasistencias")))
  //End if 
  //STWA2_json_array2json(->$json;->antap1;"p1";"")
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P01_Final_Literal))
  //Case of 
  //: (vlSTR_Periodos_Tipo=2 Semestres)
  //STWA2_json_array2json(->$json;->antap2;"p2";"")
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P02_Final_Literal))
  //: (vlSTR_Periodos_Tipo=3 Trimestres)
  //STWA2_json_array2json(->$json;->antap2;"p2";"")
  //STWA2_json_array2json(->$json;->antap3;"p3";"")
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P02_Final_Literal))
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P03_Final_Literal))
  //: (vlSTR_Periodos_Tipo=4 Bimestres)
  //STWA2_json_array2json(->$json;->antap2;"p2";"")
  //STWA2_json_array2json(->$json;->antap3;"p3";"")
  //STWA2_json_array2json(->$json;->antap4;"p4";"")
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P02_Final_Literal))
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P03_Final_Literal))
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P04_Final_Literal))
  //Else 
  //If (vlSTR_Periodos_Tipo#Anual)
  //STWA2_json_array2json(->$json;->antap2;"p2";"")
  //STWA2_json_array2json(->$json;->antap3;"p3";"")
  //STWA2_json_array2json(->$json;->antap4;"p4";"")
  //STWA2_json_array2json(->$json;->antap5;"p5";"")
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P02_Final_Literal))
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P03_Final_Literal))
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P04_Final_Literal))
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]P05_Final_Literal))
  //End if 
  //End case 
  //If (vi_UsarExamenes#0)
  //STWA2_json_array2json(->$json;->aNtaPF;"pf";"")
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]Anual_Literal))
  //STWA2_json_array2json(->$json;->aNtaEX;"ex";"")
  //If ($enSimbolos)
  //STWA2_json_array2json(->$json;->aRealNtaEX;"realex";"")
  //End if 
  //APPEND TO ARRAY($aEnterable;$examenesIngresables)
  //If ($b_examenesEditables)
  //APPEND TO ARRAY($aIcono;$enterableIcon)
  //Else 
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //End if 
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]ExamenAnual_Literal))
  //End if 
  //If (vi_UsarExamenExtra#0)
  //STWA2_json_array2json(->$json;->aNtaEXX;"exx";"")
  //If ($enSimbolos)
  //STWA2_json_array2json(->$json;->aRealNtaEXX;"realexx";"")
  //End if 
  //APPEND TO ARRAY($aEnterable;$examenesIngresables)
  //If ($b_examenesEditables)
  //APPEND TO ARRAY($aIcono;$enterableIcon)
  //Else 
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //End if 
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]ExamenExtra_Literal))
  //End if 
  //STWA2_json_array2json(->$json;->aNtaF;"f";"")
  //If ($enSimbolos)
  //STWA2_json_array2json(->$json;->aRealNtaF;"realf";"")
  //End if 
  //APPEND TO ARRAY($aEnterable;$promedios_Ingresable)
  //APPEND TO ARRAY($aIcono;$promedios_icono)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]EvaluacionFinal_Literal))
  //STWA2_json_array2json(->$json;->aNtaOf;"of";"")
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(->[Alumnos_Calificaciones]EvaluacionFinalOficial_Literal))
  //If ([Asignaturas]Ingresa_Esfuerzo)
  //STWA2_json_array2json(->$json;->aNtaEsfuerzo;"esfuerzo";"")
  //If (<>vb_BloquearModifSituacionFinal)
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //Else 
  //If ($b_calificacionesEditables)
  //APPEND TO ARRAY($aEnterable;1)
  //APPEND TO ARRAY($aIcono;$enterableIcon)
  //Else 
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //End if 
  //End if 
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_ComplementoEvaluacion]))
  //APPEND TO ARRAY($aFieldNumbers;Field(KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String($periodo)+"_Esfuerzo")))
  //End if 
  //If (vi_UsarControlesFinPeriodo#0)
  //STWA2_json_array2json(->$json;->aNtaEXP;"exp";"")
  //If (<>vb_BloquearModifSituacionFinal)
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //Else 
  //If ($b_calificacionesEditables)
  //APPEND TO ARRAY($aEnterable;1)
  //APPEND TO ARRAY($aIcono;$enterableIcon)
  //Else 
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //End if 
  //End if 
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String($periodo)+"_Control_Literal")))
  //End if 

  //  //20150915 ASM Ticket 149071 
  //STWA2_json_array2json(->$json;->par1_edit;"par1_edit";"")
  //STWA2_json_array2json(->$json;->par2_edit;"par2_edit";"")
  //STWA2_json_array2json(->$json;->par3_edit;"par3_edit";"")
  //STWA2_json_array2json(->$json;->par4_edit;"par4_edit";"")
  //STWA2_json_array2json(->$json;->par5_edit;"par5_edit";"")
  //STWA2_json_array2json(->$json;->par6_edit;"par6_edit";"")
  //STWA2_json_array2json(->$json;->par7_edit;"par7_edit";"")
  //STWA2_json_array2json(->$json;->par8_edit;"par8_edit";"")
  //STWA2_json_array2json(->$json;->par9_edit;"par9_edit";"")
  //STWA2_json_array2json(->$json;->par10_edit;"par10_edit";"")
  //STWA2_json_array2json(->$json;->par11_edit;"par11_edit";"")
  //STWA2_json_array2json(->$json;->par12_edit;"par12_edit";"")

  //STWA2_json_array2json(->$json;->aNta1;"par1";"")
  //STWA2_json_array2json(->$json;->aNta2;"par2";"")
  //STWA2_json_array2json(->$json;->aNta3;"par3";"")
  //STWA2_json_array2json(->$json;->aNta4;"par4";"")
  //STWA2_json_array2json(->$json;->aNta5;"par5";"")
  //STWA2_json_array2json(->$json;->aNta6;"par6";"")
  //STWA2_json_array2json(->$json;->aNta7;"par7";"")
  //STWA2_json_array2json(->$json;->aNta8;"par8";"")
  //STWA2_json_array2json(->$json;->aNta9;"par9";"")
  //STWA2_json_array2json(->$json;->aNta10;"par10";"")
  //STWA2_json_array2json(->$json;->aNta11;"par11";"")
  //STWA2_json_array2json(->$json;->aNta12;"par12";"")

  //ARRAY TEXT($aNTARecuperatorio;Size of array(aRealEXRecuperatorio))
  //NTA_PercentArray2StrGradeArray (->aRealEXRecuperatorio;->$aNTARecuperatorio)

  //STWA2_json_array2json(->$json;->$aNTARecuperatorio;"recuperatorio";"")

  //  //$isOpen:=((adSTR_Periodos_Cierre{$periodo}>Current date(*)) | (adSTR_Periodos_Cierre{$periodo}=!00/00/00!) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | ($userID<0))
  //  //If (<>vb_BloquearModifSituacionFinal)
  //  //$isOpen:=False
  //  //End if 
  //  //$calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices]ID_Matriz;->[Asignaturas]EVAPR_IdMatriz;->[MPA_AsignaturasMatrices]Convertir_a_Notas)
  //  //If ($calculosSobreCompetencias)
  //  //$isOpen:=False
  //  //End if 
  //For ($i;1;12)
  //Case of 
  //: (alAS_EvalPropSourceID{$i}>0)
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$consolidante_icono)
  //: (alAS_EvalPropSourceID{$i}<0)
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$subasignatura_icono)
  //: (Not(USR_checkRights ("L";->[Alumnos_Calificaciones];$userID)))
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //: ((aiAS_EvalPropEnterable{$i}=1) & ($b_calificacionesEditables))
  //APPEND TO ARRAY($aEnterable;1)
  //APPEND TO ARRAY($aIcono;$enterableIcon)
  //Else 
  //APPEND TO ARRAY($aEnterable;0)
  //APPEND TO ARRAY($aIcono;$nonEnterableIcon)
  //End case 
  //APPEND TO ARRAY($aTableNumbers;Table(->[Alumnos_Calificaciones]))
  //APPEND TO ARRAY($aFieldNumbers;Field(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String($periodo)+"_Eval"+String($i;"0#")+"_Literal")))
  //End for 
  //STWA2_json_array2json(->$json;->alAS_EvalPropSourceID;"evalpropid";"#####0")
  //STWA2_json_array2json(->$json;->atAS_EvalPropSourceName;"evalpropsrcname";"")
  //STWA2_json_array2json(->$json;->atAS_EvalPropPrintName;"evalpropname";"")
  //STWA2_json_array2json(->$json;->arAS_EvalPropCoefficient;"coeffprop";"")
  //STWA2_json_array2json(->$json;->arAS_EvalPropPercent;"percprop";"")
  //STWA2_json_array2json(->$json;->aNtaStatus;"status";"")
  //STWA2_json_array2json(->$json;->aNtaReprobada;"reprobada";"")
  //STWA2_json_array2json(->$json;->aNtaRegEximicion;"regeximicion";"")
  //STWA2_json_array2json(->$json;->aNtaIDAlumno;"idalumno";"########0")
  //STWA2_json_array2json(->$json;->aNtaRecNum;"recnum";"########0")

  //STWA2_json_array2json(->$json;->$aEnterable;"ingresable";"")
  //STWA2_json_array2json(->$json;->$aIcono;"iconos";"")
  //STWA2_json_array2json(->$json;->$aTableNumbers;"tablas";"###")
  //STWA2_json_array2json(->$json;->$aFieldNumbers;"campos";"###")

  //$jsonIconos:=JSON New 
  //json_addText(->$jsonIconos;ST_Qte ($enterableIconDEF);ST_Qte ($enterableIcon))
  //json_addText(->$jsonIconos;ST_Qte ($nonEnterableIconDEF);ST_Qte ($nonEnterableIcon))
  //json_addText(->$jsonIconos;ST_Qte ($subasignatura_iconoDEF);ST_Qte ($subasignatura_icono))
  //json_addText(->$jsonIconos;ST_Qte ($consolidante_iconoDEF);ST_Qte ($consolidante_icono))
  //json_addObj(->$json;$jsonIconos;ST_Qte ("iconosDEF"))

  //$jsonPeriodos:=JSON New 
  //ARRAY TEXT($aCierre4JS;0)
  //ARRAY TEXT($aDesde4JS;0)
  //ARRAY TEXT($aHasta4JS;0)
  //For ($i;1;Size of array(adSTR_Periodos_Cierre))
  //APPEND TO ARRAY($aCierre4JS;STWA2_MakeDate4JS (adSTR_Periodos_Cierre{$i}))
  //APPEND TO ARRAY($aDesde4JS;STWA2_MakeDate4JS (adSTR_Periodos_Desde{$i}))
  //APPEND TO ARRAY($aHasta4JS;STWA2_MakeDate4JS (adSTR_Periodos_Hasta{$i}))
  //End for 
  //STWA2_json_array2json(->$jsonPeriodos;->atSTR_Periodos_Nombre;"nombres";"")
  //STWA2_json_array2json(->$jsonPeriodos;->aiSTR_Periodos_Numero;"numeros";"###0")
  //STWA2_json_array2json(->$jsonPeriodos;->$aDesde4JS;"desde";"")
  //STWA2_json_array2json(->$jsonPeriodos;->$aHasta4JS;"hasta";"")
  //STWA2_json_array2json(->$jsonPeriodos;->$aCierre4JS;"cierre";"")
  //json_addObj(->$json;$jsonPeriodos;ST_Qte ("periodos"))

  //$jsonOpcionesEX:=JSON New 
  //json_addText(->$jsonOpcionesEX;ST_Qte (NTA_PercentValue2StringValue (vr_MinimoExRecuperatorio));ST_Qte ("minexrecuperatorio"))
  //If ($enSimbolos)
  //json_addText(->$jsonOpcionesEX;ST_Qte (String(vr_MinimoExRecuperatorio));ST_Qte ("minexrecuperatorioreal"))
  //End if 
  //  //json_addText (->$jsonOpcionesEX;ST_Qte (String(vi_UsarExRecuperatorio));ST_Qte ("usarexrecuperatorio"))
  //json_addText(->$jsonOpcionesEX;ST_Qte (String(Choose(vi_UsarExamenExtra=1;vi_UsarExRecuperatorio;vi_UsarExamenExtra)));ST_Qte ("usarexrecuperatorio"))  // ASM 20141204 139424
  //json_addObj(->$json;$jsonOpcionesEX;ST_Qte ("opcionesEX"))

  //viSTR_NoModificarNotas:=<>viSTR_NoModificarNotas
  //If (USR_IsGroupMember_by_GrpID (-15001;$userID))
  //viSTR_NoModificarNotas:=0
  //End if 

  //If (vb_NotaOficialVisible=False)
  //For ($i;1;Size of array(aNtaOf))
  //If (aNtaOf{$i}#aNtaF{$i})
  //vb_NotaOficialVisible:=True
  //$i:=Size of array(aNtaOf)+1
  //End if 
  //End for 
  //End if 

  //vtFechaBloqueo:=String(<>vd_FechaBloqueoSchoolTrack;Internal date short)
  //vbBloqueo:=<>vb_BloquearModifSituacionFinal

  //$jsonParametros:=JSON New 
  //json_addText(->$jsonParametros;ST_Qte (vtFechaBloqueo);ST_Qte ("fechabloqueo"))
  //json_addText(->$jsonParametros;ST_Qte (String(Num(vbBloqueo)));ST_Qte ("bloqueo"))
  //json_addText(->$jsonParametros;ST_Qte (String($periodo));ST_Qte ("periodo"))
  //json_addText(->$jsonParametros;ST_Qte (String(Num([Asignaturas]Resultado_no_calculado)));ST_Qte ("resnocalculado"))
  //json_addText(->$jsonParametros;ST_Qte (String(PERIODOS_PeriodosActuales (Current date(*);True)));ST_Qte ("periodoactual"))
  //json_addText(->$jsonParametros;ST_Qte (String(viSTR_NoModificarNotas));ST_Qte ("nomodificarnotas"))
  //json_addText(->$jsonParametros;ST_Qte (String(Num([Asignaturas]Consolidacion_TipoPonderacion)));ST_Qte ("coef_porc"))
  //json_addText(->$jsonParametros;ST_Qte (String(Num(vb_NotaOficialVisible)));ST_Qte ("notaoficialvisible"))
  //If ($modoRegistroAsistencia=4)
  //$horas:=[Asignaturas]Horas_de_clases_efectivas
  //json_addText(->$jsonParametros;ST_Qte (String($horas));ST_Qte ("horasclase"))
  //End if 
  //json_addObj(->$json;$jsonParametros;ST_Qte ("parametros"))

  //rMinSimbolo:=""
  //vt_MinEscalaNotaSim:=""
  //$jsonEstiloEvaluacion:=JSON New 
  //If ([Asignaturas]Ingresa_Esfuerzo)
  //STWA2_json_array2json(->$jsonEstiloEvaluacion;->aIndEsfuerzo;"indicadoresesfuerzo")
  //End if 
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(iConversionTable));ST_Qte ("bonificacion"))
  //Case of 
  //: (iEvaluationMode=Notas)
  //rMinimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
  //vr_MinEscalaNota:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte ("notas");ST_Qte ("evaluationmode"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rGradesFrom));ST_Qte ("desde"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rGradesTo));ST_Qte ("hasta"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(iGradesDec));ST_Qte ("decimales"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rGradesInterval));ST_Qte ("intervalo"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rMinimo));ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(vr_MinEscalaNota));ST_Qte ("minimoescala"))
  //If (iConversionTable=1)
  //STWA2_json_array2json(->$jsonEstiloEvaluacion;->arEVS_ConvGrades;"BON";vs_GradesFormat)
  //End if 
  //: (iEvaluationMode=Puntos)
  //rMinimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
  //vr_MinEscalaNota:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte ("puntos");ST_Qte ("evaluationmode"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rPointsFrom));ST_Qte ("desde"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rPointsTo));ST_Qte ("hasta"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(iPointsDec));ST_Qte ("decimales"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rPointsInterval));ST_Qte ("intervalo"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rMinimo));ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(vr_MinEscalaNota));ST_Qte ("minimoescala"))
  //If (iConversionTable=1)
  //STWA2_json_array2json(->$jsonEstiloEvaluacion;->arEVS_ConvPoints;"BON";vs_pointsFormat)
  //End if 
  //: (iEvaluationMode=Simbolos)
  //rMinSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
  //vt_MinEscalaNotaSim:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte ("simbolos");ST_Qte ("evaluationmode"))
  //STWA2_json_array2json(->$jsonEstiloEvaluacion;->aSymbol;"simbolos")
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (rMinSimbolo);ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (vt_MinEscalaNotaSim);ST_Qte ("minimoescala"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rPctMinimum));ST_Qte ("minimoreal"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(vrNTA_MinimoEscalaReferencia));ST_Qte ("minimoescalareal"))
  //: (iEvaluationMode=Porcentaje)
  //rMinimo:=rPctMinimum
  //vr_MinEscalaNota:=vrNTA_MinimoEscalaReferencia
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(rMinimo));ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (String(vr_MinEscalaNota));ST_Qte ("minimoescala"))
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte ("porcentaje");ST_Qte ("evaluationmode"))
  //End case 
  //json_addText(->$jsonEstiloEvaluacion;ST_Qte (<>tXS_RS_DecimalSeparator);ST_Qte ("separador"))
  //If ([Asignaturas]Ingresa_Esfuerzo)
  //STWA2_json_array2json(->$jsonEstiloEvaluacion;->aIndEsfuerzo;"ESF_indicadores")
  //json_addText(->$jsonEstiloEvaluacion;String(r1_EvEsfuerzoIndicadores);ST_Qte ("ESF_usaindicadores"))
  //json_addText(->$jsonEstiloEvaluacion;String(r2_EvEsfuerzoBonificacion);ST_Qte ("ESF_usabonificacion"))
  //End if 
  //json_addObj(->$json;$jsonEstiloEvaluacion;ST_Qte ("estiloEV"))

  //  //============

  //$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles]NoNivel;->[Asignaturas]Numero_del_Nivel;->[xxSTR_Niveles]EvStyle_oficial)
  //EVS_ReadStyleData ($idEstiloOficial)
  //$jsonEstiloOficial:=JSON New 
  //Case of 
  //: (iEvaluationMode=Notas)
  //rMinimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
  //vr_MinEscalaNota:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
  //json_addText(->$jsonEstiloOficial;ST_Qte ("notas");ST_Qte ("evaluationmode"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(rMinimo));ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(vr_MinEscalaNota));ST_Qte ("minimoescala"))
  //: (iEvaluationMode=Puntos)
  //rMinimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
  //vr_MinEscalaNota:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
  //json_addText(->$jsonEstiloOficial;ST_Qte ("puntos");ST_Qte ("evaluationmode"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(rMinimo));ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(vr_MinEscalaNota));ST_Qte ("minimoescala"))
  //: (iEvaluationMode=Simbolos)
  //json_addText(->$jsonEstiloOficial;ST_Qte ("simbolos");ST_Qte ("evaluationmode"))
  //rMinSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
  //vt_MinEscalaNotaSim:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
  //STWA2_json_array2json(->$jsonEstiloOficial;->aSymbol;"simbolos")
  //json_addText(->$jsonEstiloOficial;ST_Qte (rMinSimbolo);ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (vt_MinEscalaNotaSim);ST_Qte ("minimoescala"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(rPctMinimum));ST_Qte ("minimoreal"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(vrNTA_MinimoEscalaReferencia));ST_Qte ("minimoescalareal"))
  //: (iEvaluationMode=Porcentaje)
  //rMinimo:=rPctMinimum
  //vr_MinEscalaNota:=vrNTA_MinimoEscalaReferencia
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(rMinimo));ST_Qte ("minimo"))
  //json_addText(->$jsonEstiloOficial;ST_Qte (String(vr_MinEscalaNota));ST_Qte ("minimoescala"))
  //json_addText(->$jsonEstiloOficial;ST_Qte ("porcentaje");ST_Qte ("evaluationmode"))
  //End case 
  //json_addObj(->$json;$jsonEstiloOficial;ST_Qte ("estiloEVOficial"))

  //  //============

  //$jsonPrivilegios:=JSON New 
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("A";->[Alumnos_Calificaciones];$userID))));ST_Qte ("calificaciones_A"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("M";->[Alumnos_Calificaciones];$userID))));ST_Qte ("calificaciones_M"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("D";->[Alumnos_Calificaciones];$userID))));ST_Qte ("calificaciones_D"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("L";->[Alumnos_Calificaciones];$userID))));ST_Qte ("calificaciones_L"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("A";->[Asignaturas];$userID))));ST_Qte ("asignaturas_A"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("M";->[Asignaturas];$userID))));ST_Qte ("asignaturas_M"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("D";->[Asignaturas];$userID))));ST_Qte ("asignaturas_D"))
  //json_addText(->$jsonPrivilegios;ST_Qte (String(Num(USR_checkRights ("L";->[Asignaturas];$userID))));ST_Qte ("asignaturas_L"))
  //json_addObj(->$json;$jsonPrivilegios;ST_Qte ("privilegios"))

  //$json:=Replace string($json;"\t";"\\t")

  //  //$0:=$json