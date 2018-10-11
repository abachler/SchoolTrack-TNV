//%attributes = {}
  //SIGE_Iniciar
  //inicializar arrays para los reportes del sige
$proc:=IT_UThermometer (1;0;__ ("Iniciando SIGE ..."))

ARRAY TEXT:C222($at_opc;0)
ARRAY LONGINT:C221($al_num_opc;0)
ARRAY BOOLEAN:C223($ab_status;4)
ARRAY TEXT:C222($at_ultima_ejec;4)

APPEND TO ARRAY:C911($at_opc;"verificar_alumno")
APPEND TO ARRAY:C911($al_num_opc;1)
APPEND TO ARRAY:C911($at_opc;"enviar_tipo_enseñanza")
APPEND TO ARRAY:C911($al_num_opc;2)
APPEND TO ARRAY:C911($at_opc;"enviar_cursos")
APPEND TO ARRAY:C911($al_num_opc;3)
APPEND TO ARRAY:C911($at_opc;"enviar_asistencia")
APPEND TO ARRAY:C911($al_num_opc;4)

  //listas por opcion

  //Alumnos
ARRAY LONGINT:C221($al_id_alumno;0)
ARRAY LONGINT:C221($al_cod_ejec_alu;0)

  //Tipo enseñanza
ARRAY LONGINT:C221($al_cod_tipo_ens;0)
ARRAY TEXT:C222($at_rolbd;0)
ARRAY LONGINT:C221($al_cod_ejec_tipo_ens;0)
ARRAY TEXT:C222($at_listado_error_tipo_ens;0)

  //Curso
ARRAY TEXT:C222($at_curso;0)
ARRAY LONGINT:C221($al_cod_ejec_curso;0)
ARRAY TEXT:C222($at_listado_error_curso;0)

  //Asistencia
ARRAY TEXT:C222($at_key_asistencia;0)  //rbd.cod_tipo_ens.cod_grado.fecha
ARRAY LONGINT:C221($al_cod_respuesta_asist;0)
ARRAY LONGINT:C221($al_cod_envio_asist;0)
ARRAY LONGINT:C221($al_cod_envio_asist_resp;0)
ARRAY TEXT:C222($at_error_envio_asist_resp;0)

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->$at_opc;->$al_num_opc;->$ab_status;->$at_ultima_ejec;->$al_id_alumno;->$al_cod_ejec_alu;->$al_cod_tipo_ens;->$at_rolbd;->$al_cod_ejec_tipo_ens;->$at_listado_error_tipo_ens;->$at_curso;->$al_cod_ejec_curso;->$at_listado_error_curso;->$at_key_asistencia;->$al_cod_respuesta_asist;->$al_cod_envio_asist;->$al_cod_envio_asist_resp;->$at_error_envio_asist_resp)
PREF_SetBlob (0;"SIGE_INFO"+String:C10(<>gyear);xBlob)
SET BLOB SIZE:C606(xBlob;0)

IT_UThermometer (-2;$proc)