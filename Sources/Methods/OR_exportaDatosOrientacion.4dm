//%attributes = {}
  //OR_exportaDatosOrientacion(true)
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 18-12-17, 13:14:14
  // ----------------------------------------------------
  // Método: OR_exportaDatosOrientacion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($1)
C_BLOB:C604($blob)
C_BOOLEAN:C305($b_depliegaForm;$b_esEntrevista;$b_exportar;$b_validaEnvio)
C_LONGINT:C283($i;$l_indDatos;$l_indice;$l_largoJson;$l_pos;$l_resp;$l_resultado;$l_therm;$x;$y;$l_fin)
C_POINTER:C301($y_interlocutor)
C_TEXT:C284($err;$json;$jsonT;$node;$response;$t_antecedentes;$t_asunto;$t_autenticacion;$t_comentario_colegio;$t_comentarios)
C_TEXT:C284($t_comentarios_interlocutor;$t_detalle;$t_direccionCondor;$t_export;$t_fecha_evento;$t_inter;$t_inter_noBD;$t_llaveBase;$t_parametro;$t_passLocal)
C_TEXT:C284($t_textoAblob;$t_tipo_evento;$t_uuid_alumno;$t_uuid_evento;$t_uuid_institucion;$t_uuid_tipo_evento;$t_uuid_usuario;$text)

ARRAY TEXT:C222($headers;0)
ARRAY TEXT:C222($values;0)
ARRAY LONGINT:C221($al_recNumEvPersonales;0)
ARRAY LONGINT:C221($al_recNumOrientacion;0)
ARRAY TEXT:C222($at_arrayTipoEvento;0)
ARRAY TEXT:C222(at_tipo_evento;0)
ARRAY BOOLEAN:C223(ab_entrevista;0)
ARRAY BOOLEAN:C223(ab_observacion;0)
ARRAY TEXT:C222($at_arrayTipoEventoOrien;0)
ARRAY OBJECT:C1221($ao_datos;0)


READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_EventosOrientacion:21])
READ ONLY:C145([Alumnos_EventosPersonales:16])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Profesores:4])

  // Si lleva uno o mas parametros, la aplicación va a direccionar a BETA, en caso contrario, se direccion a producción.
If (Count parameters:C259>0)
	$t_direccionCondor:="betaorientacion.colegium.com/servicios/importaDatosST"
Else 
	$t_direccionCondor:="orientacion.colegium.com/servicios/importaDatosST"
End if 

$b_validaEnvio:=True:C214
$t_uuid_institucion:=LICENCIA_ObtieneUUIDinstitucion 

$l_therm:=IT_UThermometer (1;0;"Recopilando información...")
ALL RECORDS:C47([Alumnos_EventosOrientacion:21])
ALL RECORDS:C47([Alumnos_EventosPersonales:16])
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EventosOrientacion:21];$al_recNumOrientacion;"")
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EventosPersonales:16];$al_recNumEvPersonales;"")
AT_DistinctsFieldValues (->[Alumnos_EventosOrientacion:21]Tipo_evento:11;->$at_arrayTipoEventoOrien)
IT_UThermometer (-2;$l_therm)

If (Size of array:C274($al_recNumEvPersonales)>0)
	$l_resp:=CD_Dlog (0;"¿Desea exportar las observaciones, eventos y entrevistas de la pestaña comentarios? ";"";"Continuar";"Cancelar")
	If ($l_resp=1)
		ARRAY TEXT:C222($at_ArrayTipoEventoPerso;0)
		AT_DistinctsFieldValues (->[Alumnos_EventosPersonales:16]Tipo_de_evento:6;->$at_ArrayTipoEventoPerso)
		AT_Union (->$at_ArrayTipoEventoPerso;->$at_arrayTipoEventoOrien;->$at_arrayTipoEvento)
	End if 
Else 
	COPY ARRAY:C226($at_arrayTipoEventoOrien;$at_arrayTipoEvento)
End if 

For ($i;1;Size of array:C274($at_arrayTipoEvento))
	AT_Insert (0;1;->at_tipo_evento;->ab_entrevista;->ab_observacion)
	at_tipo_evento{Size of array:C274(at_tipo_evento)}:=$at_arrayTipoEvento{$i}
	ab_entrevista{Size of array:C274(ab_entrevista)}:=($at_arrayTipoEvento{$i}="entrevista")
	ab_observacion{Size of array:C274(ab_observacion)}:=($at_arrayTipoEvento{$i}#"entrevista")
End for 

WDW_OpenFormWindow (->[Alumnos_EventosOrientacion:21];"TipoEventoSelec";0;-Palette form window:K39:9;__ ("Exportación datos de Orientación"))
DIALOG:C40([Alumnos_EventosOrientacion:21];"TipoEventoSelec")
CLOSE WINDOW:C154

If (b_OK=1)
	
	CD_THERMOMETREXSEC (1;0;"Recopilando datos de Orientación...")
	
	For ($i;1;Size of array:C274($al_recNumOrientacion))
		GOTO RECORD:C242([Alumnos_EventosOrientacion:21];$al_recNumOrientacion{$i})
		
		  // verifico si es entrevista u observación
		If ([Alumnos_EventosOrientacion:21]Tipo_evento:11="")
			$t_tipo_evento:="Sin información en ST"
		Else 
			$t_tipo_evento:=Lowercase:C14(ST_CleanString ([Alumnos_EventosOrientacion:21]Tipo_evento:11))
			$l_pos:=Find in array:C230($at_arrayTipoEvento;[Alumnos_EventosOrientacion:21]Tipo_evento:11)
			$b_esEntrevista:=ab_entrevista{$l_pos}
		End if 
		$t_uuid_tipo_evento:=Generate UUID:C1066
		
		  //uuid del alumno
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_EventosOrientacion:21]Alumno_Numero:1)
		$t_uuid_alumno:=[Alumnos:2]auto_uuid:72
		
		  //cargo el uuid de usuario que registra el evento.
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosOrientacion:21]Autor_Numero:10)
		$t_uuid_usuario:=[Profesores:4]Auto_UUID:41
		
		  // cargo el uuid del evento
		$t_uuid_evento:=[Alumnos_EventosOrientacion:21]Auto_UUID:25
		
		  //cargo los datos del interlocutor
		For ($x;1;5)
			$y:=Choose:C955($x=1;7;15+$x)
			$y_interlocutor:=Field:C253(21;$y)
			VQR_pointer1:=Get pointer:C304("vQR_text"+String:C10($x))
			vQR_pointer2:=Get pointer:C304("vQR_text1"+String:C10($x))
			C_TEXT:C284(VQR_pointer1->;vQR_pointer2->)
			VQR_pointer1->:=""
			vQR_pointer2->:=""
			If ($y_interlocutor->#"")
				QUERY:C277([Alumnos:2];[Alumnos:2]Nombre_Común:30=$y_interlocutor->)
				
				If (Records in selection:C76([Alumnos:2])>0)
					VQR_pointer1->:=[Alumnos:2]auto_uuid:72
					vQR_pointer2->:="true"
				Else 
					QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=$y_interlocutor->)
					If (Records in selection:C76([Personas:7])>0)
						VQR_pointer1->:=[Personas:7]Auto_UUID:36
						vQR_pointer2->:="true"
					Else 
						QUERY:C277([Profesores:4];[Profesores:4]Nombre_comun:21=$y_interlocutor->)
						If (Records in selection:C76([Profesores:4])>0)
							VQR_pointer1->:=[Profesores:4]Auto_UUID:41
							vQR_pointer2->:="true"
						Else 
							vQR_pointer2->:=Replace string:C233(Replace string:C233(ST_CleanString ($y_interlocutor->);Char:C90(13);" ");"'";Char:C90(34))
						End if 
					End if 
				End if 
			End if 
		End for 
		
		  //cargo  detalle del evento
		
		$t_fecha_evento:=Choose:C955([Alumnos_EventosOrientacion:21]Fecha:2=!00-00-00!;"";String:C10([Alumnos_EventosOrientacion:21]Fecha:2))
		$t_asunto:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosOrientacion:21]Asunto:3);Char:C90(13);" ");"'";Char:C90(34))
		$t_detalle:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosOrientacion:21]Detalles:5);Char:C90(13);" ");"'";Char:C90(34))
		$t_antecedentes:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosOrientacion:21]Entrevista_Antecedentes:21);Char:C90(13);" ");"'";Char:C90(34))
		$t_comentarios_interlocutor:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosOrientacion:21]Entrevista_VisionInter:23);Char:C90(13);" ");"'";Char:C90(34))
		$t_comentario_colegio:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosOrientacion:21]Entrevista_VisionColegio:22);Char:C90(13);" ");"'";Char:C90(34))
		$t_comentarios:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosOrientacion:21]Observaciones:6);Char:C90(13);" ");"'";Char:C90(34))
		
		C_OBJECT:C1216($ob_temporal)
		OB SET:C1220($ob_temporal;"uuid_alumno";$t_uuid_alumno)
		OB SET:C1220($ob_temporal;"uuid_evento";$t_uuid_evento)
		OB SET:C1220($ob_temporal;"tipo_evento";$t_tipo_evento)
		OB SET:C1220($ob_temporal;"uuid_tipo_evento";$t_uuid_tipo_evento)
		OB SET:C1220($ob_temporal;"uuid_usuario";$t_uuid_usuario)
		OB SET:C1220($ob_temporal;"interlocutor1";vQR_text1)
		OB SET:C1220($ob_temporal;"interlocutor1_alumno";vQR_text11)
		OB SET:C1220($ob_temporal;"interlocutor2";vQR_text2)
		OB SET:C1220($ob_temporal;"interlocutor2_alumno";vQR_text12)
		OB SET:C1220($ob_temporal;"interlocutor3";vQR_text3)
		OB SET:C1220($ob_temporal;"interlocutor3_alumno";vQR_text13)
		OB SET:C1220($ob_temporal;"interlocutor4";vQR_text4)
		OB SET:C1220($ob_temporal;"interlocutor4_alumno";vQR_text14)
		OB SET:C1220($ob_temporal;"interlocutor5";vQR_text5)
		OB SET:C1220($ob_temporal;"interlocutor5_alumno";vQR_text15)
		OB SET:C1220($ob_temporal;"fecha_evento";$t_fecha_evento)
		OB SET:C1220($ob_temporal;"asunto";$t_asunto)
		OB SET:C1220($ob_temporal;"detalle";$t_detalle)
		OB SET:C1220($ob_temporal;"antecedentes";$t_antecedentes)
		OB SET:C1220($ob_temporal;"comentario_interlocutor";$t_comentarios_interlocutor)
		OB SET:C1220($ob_temporal;"comentario_colegio";$t_comentario_colegio)
		OB SET:C1220($ob_temporal;"resumen";$t_comentarios)
		OB SET:C1220($ob_temporal;"es_entrevista";$b_esEntrevista)
		APPEND TO ARRAY:C911($ao_datos;$ob_temporal)
		CLEAR VARIABLE:C89($ob_temporal)
		CD_THERMOMETREXSEC (0;$i/Size of array:C274($al_recNumOrientacion)*100;"Recopilando datos de Orientación...")
	End for 
	CD_THERMOMETREXSEC (-1)
	
	If (Size of array:C274($ao_datos)>0)
		  // creo llave
		$t_llaveBase:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
		$t_parametro:=Generate UUID:C1066
		$t_textoAblob:=$t_parametro+$t_llaveBase
		TEXT TO BLOB:C554($t_textoAblob;$blob;UTF8 text without length:K22:17)
		$t_passLocal:=SHA512 ($blob;Crypto HEX)
		
		  //genero autenticación
		C_OBJECT:C1216($ob_auten)
		OB SET:C1220($ob_auten;"aplicacion";8)
		OB SET:C1220($ob_auten;"llave";$t_passLocal)
		OB SET:C1220($ob_auten;"parametro";$t_parametro)
		
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$ob_auten;"autenticacion")
		OB_SET ($ob_raiz;->$t_uuid_institucion;"uuid_institucion")
		OB_SET ($ob_raiz;->$ao_datos;"datos")
		$t_export:=OB_Object2Json ($ob_raiz)
		
		APPEND TO ARRAY:C911($headers;"content-type")
		APPEND TO ARRAY:C911($values;"application/json")
		$l_resultado:=HTTP Request:C1158(HTTP POST method:K71:2;$t_direccionCondor;$t_export;$response;$headers;$values)
		
		If ($l_resultado#200)
			$b_validaEnvio:=False:C215
			$l_indDatos:=0
		End if 
		
	End if 
	
	If ($b_validaEnvio)
		If ($l_resp=1)
			
			AT_Initialize (->$ao_datos)
			$t_export:=""
			
			CD_THERMOMETREXSEC (1;0;"Recopilando información de  Eventos personales...")
			For ($i;1;Size of array:C274($al_recNumEvPersonales))
				GOTO RECORD:C242([Alumnos_EventosPersonales:16];$al_recNumEvPersonales{$i})
				
				  // verifico si es entrevista u observación
				If ([Alumnos_EventosPersonales:16]Tipo_de_evento:6="")
					$t_tipo_evento:="Sin información en ST"
				Else 
					$t_tipo_evento:=Lowercase:C14(ST_CleanString ([Alumnos_EventosPersonales:16]Tipo_de_evento:6))
					$l_pos:=Find in array:C230($at_arrayTipoEvento;[Alumnos_EventosPersonales:16]Tipo_de_evento:6)
					$b_esEntrevista:=ab_entrevista{$l_pos}
				End if 
				$t_uuid_tipo_evento:=Generate UUID:C1066
				
				  //uuid del alumno
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_EventosPersonales:16]Alumno_Numero:1)
				$t_uuid_alumno:=[Alumnos:2]auto_uuid:72
				
				  //cargo el uuid de usuario que registra el evento.
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosPersonales:16]ID_Autor:11)
				$t_uuid_usuario:=[Profesores:4]Auto_UUID:41
				
				  // cargo el uuid del evento
				$t_uuid_evento:=[Alumnos_EventosPersonales:16]Auto_UUID:27
				
				
				  //cargo los datos del interlocutor
				For ($x;1;5)
					$y:=Choose:C955($x=1;10;15+$x)
					$y_interlocutor:=Field:C253(16;$y)
					VQR_pointer1:=Get pointer:C304("vQR_text"+String:C10($x))
					vQR_pointer2:=Get pointer:C304("vQR_text1"+String:C10($x))
					VQR_pointer1->:=""
					vQR_pointer2->:=""
					If ($y_interlocutor->#"")
						QUERY:C277([Alumnos:2];[Alumnos:2]Nombre_Común:30=$y_interlocutor->)
						
						If (Records in selection:C76([Alumnos:2])>0)
							VQR_pointer1->:=[Alumnos:2]auto_uuid:72
							vQR_pointer2->:="true"
						Else 
							QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=$y_interlocutor->)
							If (Records in selection:C76([Personas:7])>0)
								VQR_pointer1->:=[Personas:7]Auto_UUID:36
								vQR_pointer2->:="true"
							Else 
								QUERY:C277([Profesores:4];[Profesores:4]Nombre_comun:21=$y_interlocutor->)
								If (Records in selection:C76([Profesores:4])>0)
									VQR_pointer1->:=[Profesores:4]Auto_UUID:41
									vQR_pointer2->:="true"
								Else 
									vQR_pointer2->:=Replace string:C233(Replace string:C233(ST_CleanString ($y_interlocutor->);Char:C90(13);" ");"'";Char:C90(34))
								End if 
							End if 
						End if 
					End if 
				End for 
				
				  //cargo  detalle del evento
				$t_fecha_evento:=Choose:C955([Alumnos_EventosPersonales:16]Fecha:3=!00-00-00!;"";String:C10([Alumnos_EventosPersonales:16]Fecha:3))
				$t_asunto:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosPersonales:16]Asunto:5);Char:C90(13);" ");"'";Char:C90(34))
				$t_detalle:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosPersonales:16]Detalles:15);Char:C90(13);" ");"'";Char:C90(34))
				$t_antecedentes:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosPersonales:16]Entrevista_Antecedentes:12);Char:C90(13);" ");"'";Char:C90(34))
				$t_comentarios_interlocutor:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosPersonales:16]Entrevista_VisionInter:13);Char:C90(13);" ");"'";Char:C90(34))
				$t_comentario_colegio:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosPersonales:16]Entrevista_VisionColegio:14);Char:C90(13);" ");"'";Char:C90(34))
				$t_comentarios:=Replace string:C233(Replace string:C233(ST_CleanString ([Alumnos_EventosPersonales:16]Observaciones:7);Char:C90(13);" ");"'";Char:C90(34))
				
				C_OBJECT:C1216($ob_temporal)
				OB SET:C1220($ob_temporal;"uuid_alumno";$t_uuid_alumno)
				OB SET:C1220($ob_temporal;"uuid_evento";$t_uuid_evento)
				OB SET:C1220($ob_temporal;"tipo_evento";$t_tipo_evento)
				OB SET:C1220($ob_temporal;"uuid_tipo_evento";$t_uuid_tipo_evento)
				OB SET:C1220($ob_temporal;"uuid_usuario";$t_uuid_usuario)
				OB SET:C1220($ob_temporal;"interlocutor1";vQR_text1)
				OB SET:C1220($ob_temporal;"interlocutor1_alumno";vQR_text11)
				OB SET:C1220($ob_temporal;"interlocutor2";vQR_text2)
				OB SET:C1220($ob_temporal;"interlocutor2_alumno";vQR_text12)
				OB SET:C1220($ob_temporal;"interlocutor3";vQR_text3)
				OB SET:C1220($ob_temporal;"interlocutor3_alumno";vQR_text13)
				OB SET:C1220($ob_temporal;"interlocutor4";vQR_text4)
				OB SET:C1220($ob_temporal;"interlocutor4_alumno";vQR_text14)
				OB SET:C1220($ob_temporal;"interlocutor5";vQR_text5)
				OB SET:C1220($ob_temporal;"interlocutor5_alumno";vQR_text15)
				OB SET:C1220($ob_temporal;"fecha_evento";$t_fecha_evento)
				OB SET:C1220($ob_temporal;"asunto";$t_asunto)
				OB SET:C1220($ob_temporal;"detalle";$t_detalle)
				OB SET:C1220($ob_temporal;"antecedentes";$t_antecedentes)
				OB SET:C1220($ob_temporal;"comentario_interlocutor";$t_comentarios_interlocutor)
				OB SET:C1220($ob_temporal;"comentario_colegio";$t_comentario_colegio)
				OB SET:C1220($ob_temporal;"resumen";$t_comentarios)
				OB SET:C1220($ob_temporal;"es_entrevista";$b_esEntrevista)
				APPEND TO ARRAY:C911($ao_datos;$ob_temporal)
				CLEAR VARIABLE:C89($ob_temporal)
				
				CD_THERMOMETREXSEC (0;$i/Size of array:C274($al_recNumEvPersonales)*100;"Recopilando información de Eventos personales...")
			End for 
			CD_THERMOMETREXSEC (-1)
			
			If (Size of array:C274($ao_datos)>0)
				  // creo llave
				$t_llaveBase:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
				$t_parametro:=Generate UUID:C1066
				$t_textoAblob:=$t_parametro+$t_llaveBase
				TEXT TO BLOB:C554($t_textoAblob;$blob;UTF8 text without length:K22:17)
				$t_passLocal:=SHA512 ($blob;Crypto HEX)
				
				  //genero autenticación
				C_OBJECT:C1216($ob_auten)
				OB SET:C1220($ob_auten;"aplicacion";8)
				OB SET:C1220($ob_auten;"llave";$t_passLocal)
				OB SET:C1220($ob_auten;"parametro";$t_parametro)
				
				
				C_OBJECT:C1216($ob_raiz)
				$ob_raiz:=OB_Create 
				OB_SET ($ob_raiz;->$ob_auten;"autenticacion")
				OB_SET ($ob_raiz;->$t_uuid_institucion;"uuid_institucion")
				OB_SET ($ob_raiz;->$ao_datos;"datos")
				$t_export:=OB_Object2Json ($ob_raiz)
				
				APPEND TO ARRAY:C911($headers;"content-type")
				APPEND TO ARRAY:C911($values;"application/json")
				$l_resultado:=HTTP Request:C1158(HTTP POST method:K71:2;$t_direccionCondor;$t_export;$response;$headers;$values)
				
				If ($l_resultado#200)
					$b_validaEnvio:=False:C215
					$l_indDatos:=0
				End if 
				
			End if 
			
			If ($b_validaEnvio)
				  // para crear la preferencia
				PREF_Set (0;"OR_DatosPersonales";"SI")
			End if 
			
		End if 
	End if 
	If ($b_validaEnvio)
		PREF_Set (0;"OR_datosOrientacionExportados";"SI")
		CD_Dlog (0;"Datos exportados exitosamente.")
	Else 
		CD_Dlog (0;"Se produjo un problema en la exportación."+<>cr+"Inténtelo nuevamente.")
	End if 
End if 


KRL_UnloadReadOnly (->[Alumnos_EventosOrientacion:21])
KRL_UnloadReadOnly (->[Alumnos_EventosPersonales:16])
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[Profesores:4])
KRL_UnloadReadOnly (->[Personas:7])

