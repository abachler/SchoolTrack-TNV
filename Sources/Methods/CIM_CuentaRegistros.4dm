//%attributes = {}
  // CIM_CuentaRegistros()
  // Por: Alberto Bachler K.: 02-10-14, 17:53:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283(vi_Iteraciones)

C_BOOLEAN:C305($b_canceladoUsuario;$b_exito;$b_mostrarAvisos;$b_recontarRegistros;$b_triggerDesactivado1;$b_triggerDesactivado2)
C_LONGINT:C283($i;$i_numeroTabla;$l_accion;$l_diferencia;$l_error;$l_posicion;$l_recNum;$l_registrosAntes;$l_registrosDespues;$l_versionBD_Principal)
C_LONGINT:C283($l_versionBD_Revision;$l_versionEstructura_Principal)
C_POINTER:C301($y_nil)
C_TEXT:C284($t_asunto;$t_carpetaArchivoDatos;$t_copia;$t_copiaOculta;$t_Cuerpo;$t_dataFile;$t_descripcion;$t_destinatario;$t_detalles;$t_dts)
C_TEXT:C284($t_Error;$t_inicio;$t_json;$t_jsonPerdidaRegistros;$t_mensaje;$t_modo;$t_nombreArchivo;$t_nombreArchivo2;$t_nombreTabla;$t_operacion)
C_TEXT:C284($t_rdb;$t_recCountFile;$t_ruta;$t_rutaArchivoCount;$t_rutaCarpetaDatos;$t_terminoCompactacion;$t_terminoReparacion;$t_TextoErrores;$t_titulo;$t_uuidDatabase)
C_TEXT:C284($t_uuidNotificacion;$t_uuidSesion;$t_versionBaseDeDatos;$t_versionEstructura)
C_OBJECT:C1216($ob_contadores;$ob_datosBD;$ob_infoTabla;$ob_perdidas;$ob_raiz)

ARRAY LONGINT:C221($al_Perdidas_numeroTabla;0)
ARRAY LONGINT:C221($al_Perdidas_registrosAntes;0)
ARRAY LONGINT:C221($al_Perdidas_registrosDespues;0)
ARRAY LONGINT:C221($al_Perdidas_registrosPerdidos;0)
ARRAY LONGINT:C221($al_TablasExcluidas;0)
ARRAY TEXT:C222($at_adjuntos;0)
ARRAY TEXT:C222($at_nombrePropiedades;0)
ARRAY TEXT:C222($at_Perdidas_nombreTablas;0)
ARRAY TEXT:C222($at_rutas;0)
ARRAY OBJECT:C1221($ao_objetos;0)

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)

If ($l_versionBD_Principal<$l_versionEstructura_Principal)
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_BatchRequests:48]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_Logs:37]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_KeywordQueries:120]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_Tables:51]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_TableAlias:199]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_Tables_RelatedFiles:243]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_Fields:52]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_FieldAlias:198]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_ExecutableCommands:19]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_ExecCommands_Localized:232]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[XShell_ExecutableObjects:280]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_KeywordQueries:120]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_MensajesAplicacion:244]))
	APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_SequenceNumbers:67]))
	
	If (($l_versionBD_Principal=11) & ($l_versionEstructura_Principal=12))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[BBL_Items_Keywords:245]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xShell_KeywordQueries:120]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xxSNT_LOG:93]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[sync_diccionario:285]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[sync_Modificaciones:284]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xxSTR_HistoricoNiveles:191]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[xxSTR_DatosDeCierre:24]))
		APPEND TO ARRAY:C911($al_TablasExcluidas;Table:C252(->[Alumnos_SintesisAnual:210]))
	End if 
End if 


If (False:C215)
	C_TEXT:C284(CIM_CuentaRegistros ;$0)
	C_TEXT:C284(CIM_CuentaRegistros ;$1)
	C_TEXT:C284(CIM_CuentaRegistros ;$2)
	C_TEXT:C284(CIM_CuentaRegistros ;$3)
End if 

C_BOOLEAN:C305(<>vb_MsgON;<>b_NoGuardarCuentaRegistros)
C_TEXT:C284(<>t_uuidDatabase;<>t_uuidSesion;<>gRolBD)
C_TEXT:C284(vt_jsonPerdidaRegistros)


If ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6))
	
	If (Not:C34(CIM_esBaseDeDatosNueva ))
		$b_mostrarAvisos:=<>vb_MsgON
		<>vb_MsgON:=True:C214
		
		If (Count parameters:C259>=1)
			$t_modo:=$1
		End if 
		
		Case of 
			: ($t_modo="")
				$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
				$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionBD_Revision)
				$t_versionBaseDeDatos:=String:C10($l_versionBD_Principal;"00")+"."+String:C10($l_versionBD_Revision;"00")
				
				READ ONLY:C145([xShell_ApplicationData:45])
				ALL RECORDS:C47([xShell_ApplicationData:45])
				FIRST RECORD:C50([xShell_ApplicationData:45])
				<>t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
				<>t_uuidSesion:=[xShell_ApplicationData:45]UUID_Sesion:18
				<>gRolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
				
				$t_dataFile:=Data file:C490
				$t_recCountFile:=Substring:C12($t_dataFile;1;Length:C16($t_dataFile)-4)+".count"
				If (Test path name:C476($t_recCountFile)=Is a document:K24:1)
					$t_json:=Document to text:C1236($t_recCountFile;"UTF-8")
					$ob_raiz:=OB_JsonToObject ($t_json)
					OB_GET ($ob_raiz;->$ob_datosBD;"match")
					OB_GET ($ob_datosBD;->$t_uuidDatabase;"uuidDatabase")
					OB_GET ($ob_datosBD;->$t_uuidSesion;"uuidSesion")
					OB_GET ($ob_datosBD;->$t_rdb;"rdb")
					OB_GET ($ob_datosBD;->$t_dts;"dts")
					
				End if 
				
				Case of 
					: (CIM_esBaseDeDatosNueva )
						  // Si la BD es nueva
						  // creamos el registro único de [xShell_ApplicationData] para asignar el UUID de la base de datos
						$l_recNum:=LICENCIA_RegistroAplicacion 
						  // y llamamos nuevamente a este mismo método para crear el archivo .count
						CIM_CuentaRegistros ("GuardaArchivo")
						
						
					: ($t_versionBaseDeDatos<"11.09")
						  // Si la versión de la BD es anterior a 11.9
						  // forzamos la actualizacion del registro único de [xShell_ApplicationData] para asignar el UUID de la base de datos
						$l_recNum:=LICENCIA_RegistroAplicacion 
						  // y llamamos nuevamente a este mismo método para crear el archivo .count
						CIM_CuentaRegistros ("GuardaArchivo")
						
					: (Test path name:C476($t_recCountFile)#Is a document:K24:1)
						  // el archivo .count fue removido o desplazado
						$t_nombreArchivo:=SYS_GetServerProperty (XS_DataFileName)
						$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-4)+".count"
						$t_titulo:=__ ("Archivo de contabilización de registros no encontrado")
						$t_titulo:=Replace string:C233($t_titulo;"^0";$t_nombreArchivo)
						
						$t_nombreArchivo2:=IT_SetTextStyle_Bold (->$t_nombreArchivo;True:C214)
						$t_mensaje:=__ ("El archivo de contabilización de registros ^0 que debiera encontrarse junto al archivo de datos fue removido o desplazado.")+"\r\r"
						$t_mensaje:=$t_mensaje+__ ("SchoolTrack requiere de este archivo para detectar una eventual pérdida de registros luego de una operación de compactación o reparación de la base de datos.")+"\r\r"
						$t_mensaje:=$t_mensaje+__ ("Si usted cree saber donde se encuentra puede intentar localizarlo.\rEn caso contrario el archivo puede ser recreado con el conteo de registros actual.")
						$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreArchivo2)
						  //$l_accion:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Localizar archivo");__ ("Crear Archivo");__ ("Salir de la aplicación"))
						CIM_CuentaRegistros ("LocalizaArchivo";$t_titulo;$t_mensaje)
						
					: (Records in selection:C76([xShell_ApplicationData:45])=0)
						  // si la base de datos no es nueva y no hay registros en la tabla [xShell_ApplicationData]
						  // asumimos que el registro se perdió durante la compactación o reparacion.
						
						  // obtenemos el UUID de la base de datos desde la tabla colegio (duplicado del que se almacena en la tabla [xShell_ApplicationData]
						READ ONLY:C145([Colegio:31])
						ALL RECORDS:C47([Colegio:31])
						FIRST RECORD:C50([Colegio:31])
						If ([Colegio:31]UUID_database:27=$t_uuidDatabase)
							  // si el uuid es el mismo que el se trata de la misma instancia de la base de datos
							  // creamos el registro en la tabla [xShell_ApplicationData]
							$l_recNum:=LICENCIA_RegistroAplicacion 
							  // y asignamos el uuid de la base de datos leido del archivo .count a ese ese mismo registro
							KRL_LoadRecord (->[xShell_ApplicationData:45];$l_recNum;True:C214)
							[xShell_ApplicationData:45]UUID_database:13:=$t_uuidDatabase
							SAVE RECORD:C53([xShell_ApplicationData:45])
							  // y llamamos nuevamente a este mismo método en el mismo modo
							CIM_CuentaRegistros 
						Else 
							  // el archivo .count corresponde a otra base de datos (u otra instancia de la misma BD)
							$t_nombreArchivo:=SYS_GetServerProperty (XS_DataFileName)
							$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-4)+".count"
							$t_titulo:=__ ("Archivo de contabilización de registros inválido")
							$t_titulo:=Replace string:C233($t_titulo;"^0";$t_nombreArchivo)
							$t_nombreArchivo2:=IT_SetTextStyle_Bold (->$t_nombreArchivo;True:C214)
							$t_mensaje:=__ ("El archivo de contabilización de registros ^0 corresponde a otro archivo de datos.")+"\r\r"
							$t_mensaje:=$t_mensaje+__ ("SchoolTrack requiere de este archivo para detectar una eventual pérdida de registros luego de una operación de compactación o reparación de la base de datos.")+"\r\r"
							$t_mensaje:=$t_mensaje+__ ("Si usted cree saber donde se encuentra puede intentar localizarlo.\rEn caso contrario el archivo puede ser recreado con el conteo de registros actual.")
							$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreArchivo2)
							CIM_CuentaRegistros ("LocalizaArchivo";$t_titulo;$t_mensaje)
							
						End if 
						
					: (<>t_uuidDatabase#$t_uuidDatabase)
						$t_nombreArchivo:=SYS_GetServerProperty (XS_DataFileName)
						$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-4)+".count"
						$t_titulo:=__ ("Archivo de contabilización de registros inválido")
						$t_titulo:=Replace string:C233($t_titulo;"^0";$t_nombreArchivo)
						$t_nombreArchivo2:=IT_SetTextStyle_Bold (->$t_nombreArchivo;True:C214)
						$t_mensaje:=__ ("El archivo de contabilización de registros ^0 corresponde a otro archivo de datos.")+"\r\r"
						$t_mensaje:=$t_mensaje+__ ("SchoolTrack requiere de este archivo para detectar una eventual pérdida de registros luego de una operación de compactación o reparación de la base de datos.")+"\r\r"
						$t_mensaje:=$t_mensaje+__ ("Si usted cree saber donde se encuentra puede intentar localizarlo.\rEn caso contrario el archivo puede ser recreado con el conteo de registros actual.")
						$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreArchivo2)
						CIM_CuentaRegistros ("LocalizaArchivo";$t_titulo;$t_mensaje)
						
					: (<>t_uuidSesion#$t_uuidSesion)
						$t_nombreArchivo:=SYS_GetServerProperty (XS_DataFileName)
						$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-4)+".count"
						$t_titulo:=__ ("Archivo de contabilización de registros inválido")
						$t_titulo:=Replace string:C233($t_titulo;"^0";$t_nombreArchivo)
						$t_nombreArchivo2:=IT_SetTextStyle_Bold (->$t_nombreArchivo;True:C214)
						$t_mensaje:=__ ("El archivo de contabilización de registros ^0 corresponde a otra sesión.")+"\r\r"
						$t_mensaje:=$t_mensaje+__ ("SchoolTrack requiere de este archivo para detectar una eventual pérdida de registros luego de una operación de compactación o reparación de la base de datos.")+"\r\r"
						$t_mensaje:=$t_mensaje+__ ("Si usted cree saber donde se encuentra puede intentar localizarlo.\rEn caso contrario el archivo puede ser recreado con el conteo de registros actual.")
						$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreArchivo2)
						CIM_CuentaRegistros ("LocalizaArchivo";$t_titulo;$t_mensaje)
						
					Else 
						$t_jsonPerdidaRegistros:=CIM_CuentaRegistros ("InicioAplicacion")
						If ($t_jsonPerdidaRegistros#"")
							$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
							$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
							
							  // si estamos migrando desde v11 a v12 pueden perderse registros de algunas tablas
							If (($t_versionEstructura="12@") & ($t_versionBaseDeDatos="11@") & (vi_Iteraciones<4))  //maximo 5 iteraciones, sino mandamos el aviso de pérdida de registros
								vi_Iteraciones:=vi_Iteraciones+1  // solo para no entrar en un bucle sin fin
								
								  //llamo a metodos que inicializan variables interproceso  que son utilizadas por los métodos que reconstituyen registros perdidos en el paso a v12
								SQ_CargaDatos 
								STR_ReadGlobals 
								WS_InitWebServicesVariables 
								XS_ReadCustomerData 
								
								  // leo el json que contabiliza los registros perdidos
								$ob_perdidas:=OB_JsonToObject ($t_jsonPerdidaRegistros)
								OB_GET ($ob_perdidas;->$al_Perdidas_numeroTabla;"numeroTabla")
								OB_GET ($ob_perdidas;->$at_Perdidas_nombreTablas;"nombreTabla")
								OB_GET ($ob_perdidas;->$al_Perdidas_registrosAntes;"registrosAntes")
								OB_GET ($ob_perdidas;->$al_Perdidas_registrosDespues;"registrosDespues")
								OB_GET ($ob_perdidas;->$al_Perdidas_registrosPerdidos;"registrosPerdidos")
								
								  // tablas [ACT_CFG_DctosIndividuales] y [ACT_DctosIndividuales_Cuentas]
								$l_posicion:=Find in array:C230($al_Perdidas_numeroTabla;Table:C252(->[ACT_CFG_DctosIndividuales:229]))
								If ($l_posicion>0)
									  // determino si hay registros perdidos en estas tablas y si había un solo registro en la tabla [ACT_CFG_DctosIndividuales] antes de la apertura en v12
									If (($al_Perdidas_registrosAntes{$l_posicion}=1) & ($al_Perdidas_registrosDespues{$l_posicion}=0))
										  // los reconstruyo con la configuración por defecto llamando a…
										
										QUERY:C277([xShell_MetodoActualizacion:252];[xShell_MetodoActualizacion:252]NombreMetodo:2="UD_v20160712_DescuentosIndiv")
										KRL_DeleteRecord (->[xShell_MetodoActualizacion:252])
										UD_EjecutaMetodoActualizacion ("UD_v20160712_DescuentosIndiv")
										  // vuelvo a ejecutar el conteo compartivo de registros
										$b_recontarRegistros:=True:C214
									End if 
								End if 
								
								  // tablas [Asignaturas_Adjuntos]
								$l_posicion:=Find in array:C230($al_Perdidas_numeroTabla;Table:C252(->[Asignaturas_Adjuntos:230]))
								If ($l_posicion>0)
									If (($al_Perdidas_registrosAntes{$l_posicion}>$al_Perdidas_registrosDespues{$l_posicion}))
										  //si hay perdida de registros llamo a un web service en la Intranet y reconstruyo los registros
										  // desactivo la ejecución de triggers
										$b_omitirTriggers:=<>vb_ImportHistoricos_STX
										<>vb_ImportHistoricos_STX:=True:C214
										QUERY:C277([xShell_MetodoActualizacion:252];[xShell_MetodoActualizacion:252]NombreMetodo:2="UD_v20161017_ImportaMaterialDoc")
										KRL_DeleteRecord (->[xShell_MetodoActualizacion:252])
										UD_EjecutaMetodoActualizacion ("UD_v20161017_ImportaMaterialDoc")
										  // reactivo la ejecución de triggers
										<>vb_ImportHistoricos_STX:=$b_omitirTriggers
										$b_recontarRegistros:=True:C214
									End if 
								End if 
								
								
							End if 
							
							If ($b_recontarRegistros)
								CIM_CuentaRegistros ("")
							Else 
								CIM_CuentaRegistros ("MuestraAviso";$t_jsonPerdidaRegistros)
							End if 
						End if 
				End case 
				
				
			: ($t_modo="LocalizaArchivo")
				$t_titulo:=$2
				$t_mensaje:=$3
				$l_accion:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Localizar archivo");__ ("Crear Archivo");__ ("Salir de la aplicación"))
				
				Case of 
					: ($l_accion=1)
						$t_rutaCarpetaDatos:=SYS_GetServerProperty (XS_DataFileFolder)
						$t_ruta:=Get 4D folder:C485(Database folder:K5:14)
						$t_rutaArchivoCount:=Select document:C905($t_ruta;".count";__ ("Por favor seleccione el documento que contiene la contabilización de registros");2;$at_rutas)
						If (OK=1)
							COPY DOCUMENT:C541($at_rutas{1};$t_rutaCarpetaDatos+$t_nombreArchivo)
							If (OK=1)
								$t_titulo:=__ ("Archivo de contabilización de registros localizado")
								$t_mensaje:=__ ("El archivo de contabilización de registros fue copiado a:\r^0.\r\rSe conservó el archivo seleccionado en su ubicación original:\r^1")
								$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_rutaCarpetaDatos)
								$t_mensaje:=Replace string:C233($t_mensaje;"^1";$at_rutas{1})
								$l_accion:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Continuar"))
								CIM_CuentaRegistros 
							Else 
								$t_titulo:=__ ("Copia fallida del archivo de contabilización de registros")
								$t_mensaje:=__ ("El archivo de contabilización de registros no pudo ser copiado.")
								$l_accion:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Reintentar");__ ("Salir de la aplicación"))
								If ($l_accion=1)
									CIM_CuentaRegistros ("LocalizaArchivo")
								Else 
									<>b_NoGuardarCuentaRegistros:=True:C214
									QUIT 4D:C291
								End if 
							End if 
						Else 
							CIM_CuentaRegistros ("LocalizaArchivo")
						End if 
						
					: ($l_accion=2)
						If (<>t_uuidSesion="")
							<>t_uuidSesion:=Generate UUID:C1066
							READ WRITE:C146([xShell_ApplicationData:45])
							ALL RECORDS:C47([xShell_ApplicationData:45])
							FIRST RECORD:C50([xShell_ApplicationData:45])
							[xShell_ApplicationData:45]UUID_Sesion:18:=<>t_uuidSesion
							SAVE RECORD:C53([xShell_ApplicationData:45])
						End if 
						CIM_CuentaRegistros ("GuardaArchivo")
						CIM_CuentaRegistros 
						
					: ($l_accion=3)
						<>b_NoGuardarCuentaRegistros:=True:C214
						QUIT 4D:C291
				End case 
				
			: ($t_modo="GuardaArchivo")
				If (Not:C34(<>b_NoGuardarCuentaRegistros))
					$t_dataFile:=Data file:C490
					$t_recCountFile:=Substring:C12($t_dataFile;1;Length:C16($t_dataFile)-4)+".count"
					
					If (Test path name:C476($t_recCountFile)#Is a document:K24:1)
						<>t_uuidSesion:=""
						If ($t_versionBaseDeDatos>="11.09")
							$t_nombreArchivo:=SYS_Path2FileName ($t_recCountFile)
							$t_carpetaArchivoDatos:=SYS_GetServerProperty (XS_DataFileFolder)
							$t_mensaje:=__ ("Archivo de contabilizacion de registros fue removido o desplazado.")
							$t_descripcion:=__ ("El archivo ^0 que debe encontrarse siempre junto al archivo de datos fue renombrado, eliminado o desplazado.\r\rEl archivo fue recreado automáticamente en la carpeta ^1")
							
							$t_descripcion:=Replace string:C233($t_descripcion;"^0";IT_SetTextStyle_Bold (->$t_nombreArchivo))
							$t_descripcion:=Replace string:C233($t_descripcion;"^1";IT_SetTextStyle_Bold (->$t_carpetaArchivoDatos))
							$t_uuidNotificacion:=NTC_CreaMensaje ("";$t_mensaje;$t_descripcion)
							$t_detalles:=__ ("SchoolTrack utiliza un archivo de contabilización de registros que es continuamente actualizado durante la sesión y que permite detectar una eventual "+"pérdida de registros después de una reparación o compactación de la base de datos cuando ésta está muy severamente dañada.")
							NTC_Mensaje_Texto ($t_uuidNotificacion;$t_detalles)
						End if 
					End if 
					
					If (<>t_uuidSesion="")
						<>t_uuidSesion:=Generate UUID:C1066
						READ WRITE:C146([xShell_ApplicationData:45])
						ALL RECORDS:C47([xShell_ApplicationData:45])
						FIRST RECORD:C50([xShell_ApplicationData:45])
						[xShell_ApplicationData:45]UUID_Sesion:18:=<>t_uuidSesion
						SAVE RECORD:C53([xShell_ApplicationData:45])
					End if 
					$t_dts:=DTS_Get_GMT_TimeStamp 
					
					$ob_raiz:=OB_Create 
					$ob_datosBD:=OB_Create 
					$ob_contadores:=OB_Create 
					OB_SET ($ob_raiz;->$ob_datosBD;"match")
					OB_SET ($ob_raiz;-><>t_uuidDatabase;"match.uuidDatabase")
					OB_SET ($ob_raiz;-><>t_uuidSesion;"match.uuidSesion")
					OB_SET ($ob_raiz;-><>gRolBD;"match.rdb")
					OB_SET ($ob_raiz;->$t_dts;"match.dts")
					
					  //TRACE
					ON ERR CALL:C155("ERR_eventoError")
					For ($i_numeroTabla;1;Get last table number:C254)
						If (Is table number valid:C999($i_numeroTabla))
							If (Find in array:C230($al_TablasExcluidas;$i_numeroTabla)=-1)
								$t_nombreTabla:=Table name:C256($i_numeroTabla)
								$l_registrosAntes:=Records in table:C83(Table:C252($i_numeroTabla)->)
								
								CLEAR VARIABLE:C89($ob_infoTabla)
								$ob_infoTabla:=OB_Create 
								OB SET:C1220($ob_infoTabla;"numero";$i_numeroTabla)
								OB SET:C1220($ob_infoTabla;"nombre";$t_nombreTabla)
								OB SET:C1220($ob_infoTabla;"registros";$l_registrosAntes)
								OB SET:C1220($ob_contadores;"Tabla"+String:C10($i_numeroTabla);$ob_infoTabla)
								
							End if 
						End if 
					End for 
					OB SET:C1220($ob_raiz;"count";$ob_contadores)
					ON ERR CALL:C155("")
					
					$t_json:=OB_Object2Json ($ob_raiz;True:C214)
					TEXT TO DOCUMENT:C1237($t_recCountFile;$t_json;"UTF-8")
				End if 
				
			: ($t_modo="InicioAplicacion")
				vt_jsonPerdidaRegistros:=""
				
				$t_dataFile:=Data file:C490
				$t_recCountFile:=Substring:C12($t_dataFile;1;Length:C16($t_dataFile)-4)+".count"
				
				If (Test path name:C476($t_recCountFile)=Is a document:K24:1)
					$t_json:=Document to text:C1236($t_recCountFile;"UTF-8")
					$ob_raiz:=OB_JsonToObject ($t_json)
					OB_GET ($ob_raiz;->$t_uuidDatabase;"match.uuidDatabase")
					OB_GET ($ob_raiz;->$t_uuidSesion;"match.uuidSesion")
					OB_GET ($ob_raiz;->$t_rdb;"match.rdb")
					OB_GET ($ob_raiz;->$t_dts;"match.dts")
					
					
					OB_GET ($ob_raiz;->$ob_contadores;"count")
					OB_GetChildNodes ($ob_contadores;->$at_nombrePropiedades;->$ao_objetos)
					ON ERR CALL:C155("ERR_eventoError")  // para evitar errores del kernel cuando hay daño en la BD
					For ($i;1;Size of array:C274($ao_objetos))
						OB_GET ($ao_objetos{$i};->$i_numeroTabla;"numero")
						OB_GET ($ao_objetos{$i};->$t_nombreTabla;"nombre")
						OB_GET ($ao_objetos{$i};->$l_registrosAntes;"registros")
						
						If (Is table number valid:C999($i_numeroTabla))
							If (Find in array:C230($al_TablasExcluidas;$i_numeroTabla)=-1)
								$l_registrosDespues:=Records in table:C83(Table:C252($i_numeroTabla)->)
								$l_diferencia:=$l_registrosAntes-$l_registrosDespues
								If ($l_diferencia>0)
									APPEND TO ARRAY:C911($al_Perdidas_numeroTabla;$i_numeroTabla)
									APPEND TO ARRAY:C911($at_Perdidas_nombreTablas;$t_nombreTabla)
									APPEND TO ARRAY:C911($al_Perdidas_registrosPerdidos;$l_diferencia)
									APPEND TO ARRAY:C911($al_Perdidas_registrosAntes;$l_registrosAntes)
									APPEND TO ARRAY:C911($al_Perdidas_registrosDespues;$l_registrosDespues)
								End if 
							End if 
						End if 
					End for 
					ON ERR CALL:C155("")
					
					
					AT_MultiLevelSort ("<>";->$al_Perdidas_registrosPerdidos;->$at_Perdidas_nombreTablas;->$al_Perdidas_numeroTabla;->$al_Perdidas_registrosAntes;->$al_Perdidas_registrosDespues)
					If (Size of array:C274($al_Perdidas_numeroTabla)>0)
						$ob_perdidas:=OB_Create 
						OB_SET ($ob_perdidas;->$al_Perdidas_numeroTabla;"numeroTabla")
						OB_SET ($ob_perdidas;->$at_Perdidas_nombreTablas;"nombreTabla")
						OB_SET ($ob_perdidas;->$al_Perdidas_registrosAntes;"registrosAntes")
						OB_SET ($ob_perdidas;->$al_Perdidas_registrosDespues;"registrosDespues")
						OB_SET ($ob_perdidas;->$al_Perdidas_registrosPerdidos;"registrosPerdidos")
						$0:=OB_Object2Json ($ob_perdidas;True:C214)
						
					Else 
						<>t_uuidSesion:=Generate UUID:C1066
						READ WRITE:C146([xShell_ApplicationData:45])
						ALL RECORDS:C47([xShell_ApplicationData:45])
						FIRST RECORD:C50([xShell_ApplicationData:45])
						[xShell_ApplicationData:45]UUID_Sesion:18:=<>t_uuidSesion
						SAVE RECORD:C53([xShell_ApplicationData:45])
						CIM_CuentaRegistros ("GuardaArchivo")
					End if 
				End if 
				  //JSON CLOSE ($t_refJson)  //20150421 RCH Se agrega cierre
				
			: ($t_modo="MuestraAviso")
				vt_jsonPerdidaRegistros:=$2
				vt_resultadoEnvioCorreo:=CIM_CuentaRegistros ("EnviarInforme")
				WDW_OpenFormWindow ($y_nil;"CIM_DiferenciasRegistros";-1;Movable form dialog box:K39:8)
				DIALOG:C40("CIM_DiferenciasRegistros")
				CLOSE WINDOW:C154
				
			: ($t_modo="EnviarInforme")
				$t_jsonPerdidaRegistros:=vt_jsonPerdidaRegistros
				$ob_perdidas:=OB_JsonToObject ($t_jsonPerdidaRegistros)
				OB_GET ($ob_perdidas;->$al_Perdidas_numeroTabla;"numeroTabla")
				OB_GET ($ob_perdidas;->$at_Perdidas_nombreTablas;"nombreTabla")
				OB_GET ($ob_perdidas;->$al_Perdidas_registrosAntes;"registrosAntes")
				OB_GET ($ob_perdidas;->$al_Perdidas_registrosDespues;"registrosDespues")
				OB_GET ($ob_perdidas;->$al_Perdidas_registrosPerdidos;"registrosPerdidos")
				
				$l_error:=CIM_InfoReparacion (->$t_inicio;->$t_terminoReparacion;->$b_exito;->$b_canceladoUsuario)
				$l_error:=CIM_InfoCompactacion (->$t_inicio;->$t_terminoCompactacion;->$b_exito;->$b_canceladoUsuario)
				$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
				$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
				
				Case of 
					: (($t_versionEstructura="12@") & ($t_versionBaseDeDatos="11@"))
						$t_operacion:=__ ("Migración a SchoolTrack v12")
						
					: ($t_terminoReparacion="") & ($t_terminoCompactacion#"")
						  // no hay log de reparacion pero hay log de compactación
						  // se asume que la última operación después del cierre fue una compactacion
						$t_operacion:=__ ("Compactación de base de datos")+" ("+$t_terminoCompactacion+")"
						
					: ($t_terminoReparacion#"") & ($t_terminoCompactacion="")
						  // hay log de reparacion y no hay log de compactación
						  // se asume que la última operación después del cierre fue una reparacion
						$t_operacion:=__ ("Reparación de base de datos")+" ("+$t_terminoReparacion+")"
						
					: ($t_terminoReparacion>$t_terminoCompactacion)
						  // el log de reparación indica una reparación más reciente que la última compactacion
						  // se asume que la última operación antes de la apertura de la base fue una reparacion
						$t_operacion:=__ ("Reparación de base de datos")+" ("+$t_terminoReparacion+")"
						
					: ($t_terminoReparacion<$t_terminoCompactacion)
						  // el log de reparación indica una compctacion más reciente que la última reparacion
						  // se asume que la última operación antes de la apertura de la base fue una compactacion
						$t_operacion:=__ ("Compactación de base de datos ")+" ("+$t_terminoCompactacion+")"
				End case 
				$t_dataFile:=Data file:C490
				APPEND TO ARRAY:C911($at_adjuntos;Substring:C12($t_dataFile;1;Length:C16($t_dataFile)-4)+".count")
				
				$t_TextoErrores:="Nº Tabla\tNombre de la tabla\tRegistros antes\tRegistros despues\tDiferencia\r"
				$t_TextoErrores:=$t_TextoErrores+AT_Arrays2Text ("\r";"\t";->$al_Perdidas_numeroTabla;->$at_Perdidas_nombreTablas;->$al_Perdidas_registrosAntes;->$al_Perdidas_registrosDespues;->$al_Perdidas_registrosPerdidos)
				$t_Cuerpo:=__ ("Se detectó pérdida de registros en algunas tablas después de una operación de ^0 en la base de datos de ")+<>gCustom+": \r\r"
				$t_Cuerpo:=$t_Cuerpo+$t_TextoErrores+"\r\r"
				$t_Cuerpo:=$t_Cuerpo+"Version Aplicación: "+SYS_LeeVersionEstructura +"\r"
				$t_Cuerpo:=$t_Cuerpo+"Version Base de datos: "+SYS_LeeVersionBaseDeDatos +"\r\r"
				$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos se encuentra en el servidor SchoolTrack del colegio en la ruta siguiente:\r")+Data file:C490+"\r\r"
				$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("En adjunto el documento de contablización de registros.")
				$t_cuerpo:=Replace string:C233($t_Cuerpo;"^0";$t_operacion)
				
				$t_asunto:="Reporte de pérdida de registros en base de datos de "+<>gCustom
				$t_destinatario:="soporte@colegium.com"
				$t_copia:="qa@colegium.com"
				$t_copiaOculta:="abachler@colegium.com"
				
				$t_mensaje:=__ ("Perdida de registros detectada...")+"\r"+__ ("Enviando informe a Colegium...")
				$t_error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaOculta;->$at_adjuntos;$t_mensaje)
				
				If ($t_error="")
					$0:=__ ("Se envió un informe Colegium. Si necesita apoyo por favor pongase en contacto con la mesa de ayuda.")
				Else 
					$0:=__ ("No fue posible enviar automáticamente el informe a Colegium. Si necesita apoyo por favor envíe el informe y pongase en contacto con la mesa de ayuda.")
				End if 
				
				
		End case 
		<>vb_MsgON:=$b_mostrarAvisos
		KRL_UnloadReadOnly (->[xShell_ApplicationData:45])  //ASM 20141006 Se quedaba tomado el registro.
	End if 
End if 


