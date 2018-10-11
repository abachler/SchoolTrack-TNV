//%attributes = {}
  //  //SIGE_Carga_pag_Panel
  //metodo obsoleto reemplazo por SIGE_loadDataarrays
  //$accion:=$1
  //
  //  //Generales
  //  //status de la operación
  //
  //If (at_ultima_ejec{$accion}#"")
  //vt_fechaejec:=at_ultima_ejec{$accion}
  //Else 
  //vt_fechaejec:="nunca ejecutado..."
  //End if 
  //
  //  //Por función
  //
  //AL_UpdateArrays (xALP_SIGE;0)
  //ALP_RemoveAllArrays (xALP_SIGE)
  //$lineas_visibles_por_linea:=2
  //Case of 
  //: ($accion=1)  //Verificación de alumnos
  //
  //READ ONLY([Alumnos])
  //C_TEXT(vt_ultima_fecha_alu)
  //
  //  //la fecha tiene que ser con hora
  //
  //If (vt_ultima_fecha_alu#vt_fechaejec)
  //
  //vt_ultima_fecha_alu:=vt_fechaejec
  //ARRAY LONGINT(al_alu_fail_verif;0)
  //
  //ARRAY TEXT(at_alumno;0)
  //ARRAY TEXT(at_cur;0)
  //ARRAY TEXT(at_problema_alu;0)
  //
  //Case of 
  //: ((Not(ab_status{$accion})) & (Size of array(al_id_alumno)=0))  //nunca se ha ejecutado el proceso
  //
  //QUERY WITH ARRAY([Cursos]Nivel_Numero;<>al_NumeroNivelesActivos)
  //QUERY SELECTION([Cursos];[Cursos]Número_del_curso>0)  //filtrar Cursos ADT
  //KRL_RelateSelection (->[Alumnos]Curso;->[Cursos]Curso;"")
  //ORDER BY([Alumnos];[Alumnos]Nivel_Número;>;[Cursos]Curso;>)
  //SELECTION TO ARRAY([Alumnos]Número;al_id_alumno)
  //ARRAY LONGINT(al_cod_ejec_alu;Size of array(al_id_alumno))
  //REDUCE SELECTION([Alumnos];0)
  //
  //: (Size of array(al_id_alumno)>0)  //Verificar si hay alumnos nuevos que no se han agregado al proceso
  //ARRAY LONGINT($al_new_alu;0)
  //QUERY WITH ARRAY([Alumnos]Número;al_id_alumno)
  //CREATE SET([Alumnos];"alu_proc")
  //QUERY WITH ARRAY([Cursos]Nivel_Numero;<>al_NumeroNivelesActivos)
  //QUERY SELECTION([Cursos];[Cursos]Número_del_curso>0)  //filtrar Cursos ADT
  //KRL_RelateSelection (->[Alumnos]Curso;->[Cursos]Curso;"")
  //CREATE SET([Alumnos];"todos")
  //DIFFERENCE("todos";"alu_proc";"todos")
  //USE SET("todos")
  //SELECTION TO ARRAY([Alumnos]Número;$al_new_alu)
  //SET_ClearSets ("todos";"alu_proc")
  //For ($i;1;Size of array($al_new_alu))
  //APPEND TO ARRAY(al_id_alumno;$al_new_alu{$i})
  //APPEND TO ARRAY(al_cod_ejec_alu;0)
  //End for 
  //End case 
  //
  //For ($i;1;Size of array(al_id_alumno))
  //
  //If (al_cod_ejec_alu{$i}#1)
  //QUERY([Alumnos];[Alumnos]Número=al_id_alumno{$i})
  //APPEND TO ARRAY(al_alu_fail_verif;al_id_alumno{$i})
  //If (Records in selection([Alumnos])=1)
  //
  //APPEND TO ARRAY(at_alumno;[Alumnos]Apellidos_y_Nombres)
  //APPEND TO ARRAY(at_cur;[Alumnos]Curso)
  //UNLOAD RECORD([Alumnos])
  //
  //Case of 
  //: (al_cod_ejec_alu{$i}=-1)  //respuesta interna para alumnos no verificados
  //APPEND TO ARRAY(at_problema_alu;"Alumnos sin RUN en Schooltrack")
  //: (al_cod_ejec_alu{$i}=0)
  //APPEND TO ARRAY(at_problema_alu;"Alumnos sin proceso de verificación")
  //: (al_cod_ejec_alu{$i}=2)  //respuestas de error entregadas por el mineduc en el archivo API Servicios SIGE v-0.2
  //APPEND TO ARRAY(at_problema_alu;"RUN de entrada tiene Ficha SIGE, pero la identificación proporcionada no correspo"+"nde a SRCel.")
  //: (al_cod_ejec_alu{$i}=3)
  //APPEND TO ARRAY(at_problema_alu;"RUN de entrada NO tiene Ficha SIGE, pero la identificación proporcionada correspo"+"nde a SRCel.")
  //: (al_cod_ejec_alu{$i}=4)
  //APPEND TO ARRAY(at_problema_alu;"RUN de entrada NO tiene Ficha SIGE y la identificación proporcionada no correspo"+"nde a SRCel.")
  //: (al_cod_ejec_alu{$i}=5)
  //APPEND TO ARRAY(at_problema_alu;"RUN de entrada NO válido")
  //End case 
  //
  //End if 
  //
  //End if 
  //
  //End for 
  //
  //
  //End if 
  //
  //vl_alumnosnoverif:=Size of array(at_alumno)
  //
  //  //para el botón de status
  //If (vl_alumnosnoverif=0)
  //ab_status{$accion}:=True
  //Else 
  //ab_status{$accion}:=False
  //End if 
  //
  //ta_1:=1
  //ta_2:=0
  //OBJECT SET ENABLED(*;"bti_blockAL";True)
  //
  //C_LONGINT($Error)
  //
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;1;"at_alumno";"Alumnos";200;"")
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;2;"at_cur";"Curso";40;"")
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;3;"at_problema_alu";"Detalle";500;"")
  //
  //: ($accion=2)  //Ingreso Tipo enseñanza
  //
  //  //verificamos todos los tipos de enseñanza con distinto rol de bd
  //ARRAY TEXT($at_RolBD;0)
  //ARRAY LONGINT($al_Educ_Codes;0)
  //READ ONLY([Cursos])
  //QUERY([Cursos];[Cursos]Número_del_curso>=0)
  //ORDER BY([Cursos];[Cursos]cl_RolBaseDatos;>;[Cursos]cl_CodigoTipoEnseñanza;>)
  //
  //AT_DistinctsFieldValues (->[Cursos]cl_RolBaseDatos;->$at_RolBD)
  //
  //If (Size of array($at_RolBD)>1)
  //SELECTION TO ARRAY([Cursos]cl_CodigoTipoEnseñanza;$al_Educ_Codes;[Cursos]cl_RolBaseDatos;$at_RolBD)
  //For ($i;Size of array($al_Educ_Codes);1;-1)
  //If (($al_Educ_Codes{$i}=$al_Educ_Codes{$i-1}) & ($at_RolBD{$i}=$at_RolBD{$i-1}))
  //AT_Delete ($i;1;->$al_Educ_Codes;->$at_RolBD)
  //End if 
  //End for 
  //Else 
  //AT_DistinctsFieldValues (->[Cursos]cl_CodigoTipoEnseñanza;->$al_Educ_Codes)
  //While (Size of array($at_RolBD)<Size of array($al_Educ_Codes))
  //APPEND TO ARRAY($at_RolBD;$at_RolBD{1})
  //End while 
  //End if 
  //
  //If (Size of array(al_cod_tipo_ens)=0)
  //COPY ARRAY($at_RolBD;at_rolbd)
  //COPY ARRAY($al_Educ_Codes;al_cod_tipo_ens)
  //Else 
  //$text:=AT_Arrays2Text (";";"-";->at_rolbd;->al_cod_tipo_ens)
  //For ($i;1;Size of array($at_RolBD))
  //$pos:=Position($at_RolBD{$i}+"-"+String($al_Educ_Codes{$i});$text)
  //If ($pos=0)
  //APPEND TO ARRAY(at_rolbd;$at_RolBD{$i})
  //APPEND TO ARRAY(al_cod_tipo_ens;$al_Educ_Codes{$i})
  //End if 
  //End for 
  //End if 
  //ARRAY LONGINT(al_cod_ejec_tipo_ens;Size of array(at_rolbd))
  //ARRAY TEXT(at_listado_error_tipo_ens;Size of array(at_rolbd))
  //
  //  //array para despliegue de los que no han sido verificados o tuvieron problemas
  //ARRAY TEXT(at_CodTipoEns_P;0)
  //ARRAY TEXT(at_RolBD_P;0)
  //ARRAY TEXT(at_detalle_P;0)
  //
  //For ($i;1;Size of array(al_cod_tipo_ens))
  //
  //  //para mostrar las enseñanzas en el arealist que no han sido procesados correctamente
  //  //If (al_cod_ejec_tipo_ens{$i}#1)//antes ocultaba lo enviado satisfactoriamente
  //APPEND TO ARRAY(at_CodTipoEns_P;String(al_cod_tipo_ens{$i}))
  //APPEND TO ARRAY(at_RolBD_P;at_rolbd{$i})
  //
  //Case of 
  //: (al_cod_ejec_tipo_ens{$i}=0)
  //APPEND TO ARRAY(at_detalle_P;"Porceso de ingreso no ejecutado")
  //: ((al_cod_ejec_tipo_ens{$i}=2) | (al_cod_ejec_tipo_ens{$i}=1) | (al_cod_ejec_tipo_ens{$i}=-1))
  //APPEND TO ARRAY(at_detalle_P;Lowercase(ST_GetCleanString (at_listado_error_tipo_ens{$i})))
  //: (al_cod_ejec_tipo_ens{$i}=3)
  //APPEND TO ARRAY(at_detalle_P;"RBD NO tiene servicio disponible")
  //: (al_cod_ejec_tipo_ens{$i}=4)
  //APPEND TO ARRAY(at_detalle_P;"Convenio no tiene asociado RBD")
  //: (al_cod_ejec_tipo_ens{$i}=5)
  //APPEND TO ARRAY(at_detalle_P;"Servicio no disponible")
  //: (al_cod_ejec_tipo_ens{$i}=7)
  //APPEND TO ARRAY(at_detalle_P;"Error Interno de Servicio")
  //End case 
  //
  //  //End if 
  //
  //End for 
  //
  //vl_IngTipoEns:=Size of array(at_CodTipoEns_P)
  //
  //If (vl_IngTipoEns=0)
  //ab_status{$accion}:=True
  //Else 
  //ab_status{$accion}:=False
  //End if 
  //
  //te_1:=1
  //te_2:=0
  //OBJECT SET ENABLED(*;"bti_blockAL";True)
  //
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;1;"at_RolBD_P";"Rol";60;"")
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;2;"at_CodTipoEns_P";"Código de Enseñanaza";120;"")
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;3;"at_detalle_P";"Detalle";400;"")
  //
  //: ($accion=3)  //Ingreso de Cursos
  //
  //READ ONLY([Cursos])
  //  //arrays de despliegue en arealist
  //ARRAY TEXT(at_curso_P;0)
  //ARRAY TEXT(at_cod_ejec_curso_P;0)
  //
  //QUERY([Cursos];[Cursos]Número_del_curso>0)
  //CREATE SET([Cursos];"todos")
  //
  //If (Size of array(at_curso)>0)
  //ORDER BY([Cursos];[Cursos]Nivel_Numero;>;[Cursos]Curso;>)
  //SELECTION TO ARRAY([Cursos]Curso;at_curso)
  //ARRAY LONGINT(al_cod_ejec_curso;Size of array(at_curso))
  //ARRAY TEXT(at_listado_error_curso;Size of array(at_curso))
  //Else 
  //ARRAY TEXT($at_cursos_nuevos;0)
  //QUERY WITH ARRAY([Cursos]Curso;at_curso)
  //CREATE SET([Cursos];"cursos_reg")
  //CREATE EMPTY SET([Cursos];"cursos_nuevos")
  //DIFFERENCE("todos";"cursos_reg";"cursos_nuevos")
  //USE SET("cursos_nuevos")
  //SELECTION TO ARRAY([Cursos]Curso;$at_cursos_nuevos)
  //For ($i;1;Size of array($at_cursos_nuevos))
  //APPEND TO ARRAY(at_curso;$at_cursos_nuevos{$i})
  //APPEND TO ARRAY(al_cod_ejec_curso;0)
  //APPEND TO ARRAY(at_listado_error_curso;"")
  //End for 
  //SET_ClearSets ("cursos_reg";"cursos_nuevos")
  //End if 
  //CLEAR SET("todos")
  //
  //$lineas_visibles_por_linea:=3
  //
  //For ($i;1;Size of array(at_curso))
  //
  //  //If (al_cod_ejec_curso{$i}#1)  //1)solicitud ingresada ok - 2) Curso ya existente en SIGE
  //APPEND TO ARRAY(at_curso_P;at_curso{$i})
  //Case of 
  //: (al_cod_ejec_curso{$i}=0)
  //APPEND TO ARRAY(at_cod_ejec_curso_P;"Proceso no ejecutado")
  //: ((al_cod_ejec_curso{$i}=2) | (al_cod_ejec_curso{$i}=1))  //esto se llena en la misma llamada al WS que devuelve el detalle de los errores.
  //APPEND TO ARRAY(at_cod_ejec_curso_P;Lowercase(ST_GetCleanString (at_listado_error_curso{$i})))
  //: (al_cod_ejec_curso{$i}=3)
  //APPEND TO ARRAY(at_cod_ejec_curso_P;"RBD No tiene servicio disponible")
  //: (al_cod_ejec_curso{$i}=4)
  //APPEND TO ARRAY(at_cod_ejec_curso_P;"Convenio NO tiene asociado RBD")
  //: (al_cod_ejec_curso{$i}=5)
  //APPEND TO ARRAY(at_cod_ejec_curso_P;"Servicio NO disponible")
  //: (al_cod_ejec_curso{$i}=7)
  //APPEND TO ARRAY(at_cod_ejec_curso_P;"Error interno de servicio")
  //: ((al_cod_ejec_curso{$i}=-10) | (al_cod_ejec_curso{$i}=-9))
  //APPEND TO ARRAY(at_cod_ejec_curso_P;at_listado_error_curso{$i})
  //
  //End case 
  //  //End if 
  //
  //End for 
  //
  //vl_IngCursos:=Size of array(at_curso_P)
  //
  //If (vl_IngCursos=0)
  //ab_status{$accion}:=True
  //Else 
  //ab_status{$accion}:=False
  //End if 
  //
  //cu_1:=1
  //cu_2:=0
  //OBJECT SET ENABLED(*;"bti_blockAL";True)
  //
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;1;"at_curso_P";"Cursos";80;"")
  //$Error:=ALP_DefaultColSettings (xALP_SIGE;2;"at_cod_ejec_curso_P";"Detalle";500;"")
  //
  //: ($accion=4)
  //
  //pc_1:=1
  //pc_2:=0
  //opt1:=1
  //opt2:=0
  //opt3:=0
  //OBJECT SET VISIBLE(pc_1;True)
  //OBJECT SET VISIBLE(pc_2;True)
  //OBJECT SET VISIBLE(*;"Texto_dias";False)
  //OBJECT SET VISIBLE(*;"Texto_mes";True)
  //OBJECT SET VISIBLE(*;"btn_enviar_asist";True)
  //
  //OBJECT SET VISIBLE(*;"Nivel_txt";False)
  //OBJECT SET VISIBLE(*;"vt_nivel";False)
  //OBJECT SET VISIBLE(*;"btni_nivel";False)
  //OBJECT SET VISIBLE(*;"pic_triangulo_nivel";False)
  //
  //OBJECT SET TITLE(*;"btn_enviar_asist";"Enviar Asistencias")
  //OBJECT SET ENABLED(*;"bti_blockAL";True)
  //
  //$lineas_visibles_por_linea:=SIGE_Asist_CargaVista (1;vi_MesNum)
  //
  //End case 
  //
  //If (ab_status{$accion})
  //GET PICTURE FROM LIBRARY("XS_EntryAccept";ico_status)
  //Else 
  //GET PICTURE FROM LIBRARY("XS_EntryCancel";ico_status)
  //End if 
  //
  //ALP_SetDefaultAppareance (xALP_SIGE;9;$lineas_visibles_por_linea;6;2;8)
  //
  //AL_SetColOpts (xALP_SIGE;1;1;1;0;0)
  //AL_SetRowOpts (xALP_SIGE;1;0;0;0;1;0)
  //AL_SetCellOpts (xALP_SIGE;0;1;1)
  //AL_SetMiscOpts (xALP_SIGE;0;3;"\\";0;1)
  //AL_SetMainCalls (xALP_SIGE;"";"")
  //AL_SetScroll (xALP_SIGE;0;0)
  //AL_SetSortOpts (xALP_SIGE;0;0;0;"";0;0)
  //  //AL_SetEntryOpts (xALP_SIGE;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
  //  //AL_SetDrgOpts (xALP_SIGE;0;30;0)
  //  //AL_SetHeight (xALP_SIGE;1;2;1;2;0;0)
  //
  //  //AL_SetDrgSrc (xALP_SIGE;1;"";"";"")
  //  //AL_SetDrgSrc (xALP_SIGE;2;"";"";"")
  //  //AL_SetDrgSrc (xALP_SIGE;3;"";"";"")
  //  //AL_SetDrgDst (xALP_SIGE;1;"";"";"")
  //  //AL_SetDrgDst (xALP_SIGE;1;"";"";"")
  //  //AL_SetDrgDst (xALP_SIGE;1;"";"";"")
  //AL_UpdateArrays (xALP_SIGE;-2)
  //
  //
  //C_BLOB(xBlob)
  //SET BLOB SIZE(xBlob;0)
  //BLOB_Variables2Blob (->xBlob;0;->at_opc;->al_num_opc;->ab_status;->at_ultima_ejec;->al_id_alumno;->al_cod_ejec_alu;->al_cod_tipo_ens;->at_rolbd;->al_cod_ejec_tipo_ens;->at_listado_error_tipo_ens;->at_curso;->al_cod_ejec_curso;->at_listado_error_curso;->at_key_asistencia;->al_cod_respuesta_asist;->al_cod_envio_asist;->al_cod_envio_asist_resp;->at_error_envio_asist_resp)
  //PREF_SetBlob (0;"SIGE_INFO"+String(<>gyear);xBlob)
  //SET BLOB SIZE(xBlob;0)