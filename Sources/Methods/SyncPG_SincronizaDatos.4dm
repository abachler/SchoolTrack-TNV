//%attributes = {"executedOnServer":true}
  // SyncPG_SincronizaDatos()
  // Por: Alberto Bachler K.: 13-04-15, 18:24:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_actualizarRegistroST;$b_datoModificado;$b_ejecutar;$b_esIndexado;$b_esNuevo;$b_esUnico;$b_modificadoCondor;$b_modificadoST)
_O_C_INTEGER:C282($i_campos;$i_registros)
C_LONGINT:C283($i;$l_campo4D;$l_campoST;$l_conexion;$l_conexionActiva;$l_filasAfectadas;$l_idProceso;$l_largoAlpha;$l_ms;$l_numeroCampo)
C_LONGINT:C283($l_numeroCampos;$l_recNum;$l_recNumSyncModificaciones;$l_refDeclaracion_INSERT;$l_refDeclaracion_UDPropiedades;$l_refDeclaracion_UPDATE;$l_refDeclaracion_UPPropiedades;$l_refFilas;$l_tabla4D;$l_tablaST)
C_LONGINT:C283($l_tipo4DST;$l_tipoCampo;$l_version_Mayor;$l_version_Revision;$l_versionCondor;$l_versionDatoSchoolTrack)
C_POINTER:C301($y_campo;$y_IdRegistro;$y_tabla)
C_TEXT:C284($t_declaracion;$t_declaracion_INSERT;$t_declaracion_UDpropiedades;$t_declaracion_UPDATE;$t_dtsCondor;$t_dtsDatoSchoolTrack;$t_nombreBD;$t_nombreCampo;$t_nombreProceso;$t_nombreTabla)
C_TEXT:C284($t_nuevoValorCondor;$t_select;$t_usuario;$t_usuarioMaquina;$t_uuid;$t_uuidColegio;$t_uuidCondor;$t_uuidPG;$t_uuidRegistro;$t_valorDatoSchoolTrack)
C_TEXT:C284($t_version;$t_version_SinBuild)
C_BLOB:C604($blob)

C_BOOLEAN:C305(<>vb_NoSincroHaciaCondor_2;<>vb_NoSincroHaciaCondor_4;<>vb_NoSincroHaciaCondor_7;<>vb_NoSincroHaciaCondor_78;<>vb_NoSincroHaciaCondor_77;<>vb_NoSincroHaciaCondor_47)

ARRAY BOOLEAN:C223($ab_modificadoCondor;0)
ARRAY LONGINT:C221($al_campo4D;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_tabla4D;0)
ARRAY LONGINT:C221($al_version;0)
ARRAY TEXT:C222($at_auto_uuid;0)
ARRAY TEXT:C222($at_dts;0)
ARRAY TEXT:C222($at_uuidRegistro;0)
ARRAY TEXT:C222($at_valor;0)

C_BOOLEAN:C305(<>stopDaemons)
C_BOOLEAN:C305(<>bXS_esServidorOficial)

C_OBJECT:C1216($answer;$contenido;$emptyobject)
C_TEXT:C284($err)

If (Sync_Activar )
	$cUUID:=Util_MakeUUIDCanonical (<>GUUID)
	While (Not:C34(<>stopDaemons) & (<>b_sincronizar))
		OK:=0
		error:=0
		
		$t_nombreBD:=<>t_nombreBDCondor
		$t_uuidColegio:=$cUUID
		
		  // busco los registros modificados en Condor ewn SyncDB para esta institucion los cargo en arreglos
		
		$answer:=SYNC_APICall ("obtienemodificadoscondor";HTTP GET method:K71:1;$emptyobject;$cUUID)
		ARRAY OBJECT:C1221($aob_modificacionesCondor;0)
		OB GET ARRAY:C1229($answer;"data";$aob_modificacionesCondor)
		ARRAY BOOLEAN:C223($ab_modificadoCondor;Size of array:C274($aob_modificacionesCondor))
		ARRAY LONGINT:C221($al_campo4D;Size of array:C274($aob_modificacionesCondor))
		ARRAY LONGINT:C221($al_tabla4D;Size of array:C274($aob_modificacionesCondor))
		ARRAY LONGINT:C221($al_version;Size of array:C274($aob_modificacionesCondor))
		ARRAY TEXT:C222($at_auto_uuid;Size of array:C274($aob_modificacionesCondor))
		ARRAY TEXT:C222($at_dts;Size of array:C274($aob_modificacionesCondor))
		ARRAY TEXT:C222($at_uuidRegistro;Size of array:C274($aob_modificacionesCondor))
		ARRAY TEXT:C222($at_valor;Size of array:C274($aob_modificacionesCondor))
		For ($i;1;Size of array:C274($aob_modificacionesCondor))
			$at_auto_uuid{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"autouuid")
			$at_uuidRegistro{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"uuid_registro")
			$al_tabla4D{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"st_tabla";Is longint:K8:6)
			$al_campo4D{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"st_campo";Is longint:K8:6)
			$al_version{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"version";Is longint:K8:6)
			$at_dts{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"dts")
			$at_valor{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"nuevovalor")
			$ab_modificadoCondor{$i}:=OB Get:C1224($aob_modificacionesCondor{$i};"modificadocondor";Is boolean:K8:9)
		End for 
		
		  // recorro los arreglos con los registros modificados
		For ($i;1;Size of array:C274($at_auto_uuid))
			$t_uuidPG:=$at_auto_uuid{$i}
			$t_uuid:=Util_MakeUUIDNonCanonical ($t_uuidPG)
			$l_tabla4D:=$al_tabla4D{$i}
			$l_campo4D:=$al_campo4D{$i}
			$t_dtsCondor:=$at_dts{$i}
			$t_nuevoValorCondor:=$at_valor{$i}
			$l_versionCondor:=$al_version{$i}
			$t_uuidRegistro:=$at_uuidRegistro{$i}
			
			If (Position:C15("T";$t_dtsCondor)=0)  // normalizo el DTS al formato 4D
				$t_dtsCondor:=Replace string:C233($t_dtsCondor;" ";"T")
				$t_dtsCondor:=Substring:C12($t_dtsCondor;1;Position:C15(".";$t_dtsCondor)-1)+"Z"
			End if 
			
			$l_recNumSyncModificaciones:=Find in field:C653([sync_Modificaciones:284]autouuid:1;$t_uuid)
			  // determino si el registro existe en la tabla local SchoolTrack sync_modificaciones
			If ($l_recNumSyncModificaciones>No current record:K29:2)
				KRL_GotoRecord (->[sync_Modificaciones:284];$l_recNumSyncModificaciones;True:C214)
				If (OK=1)
					  //si el registro existe y puede ser accedido en escritura determino si el valor existente y el valor en Condor son distintos
					$t_valorDatoSchoolTrack:=[sync_Modificaciones:284]nuevoValor:12
					$l_versionDatoSchoolTrack:=[sync_Modificaciones:284]version:13
					$t_dtsDatoSchoolTrack:=[sync_Modificaciones:284]dts:16
					$b_datoModificado:=Not:C34(ST_SonTextosIdenticos ($t_nuevoValorCondor;[sync_Modificaciones:284]nuevoValor:12))
					
				End if 
			Else 
				  //  el registro NO existe en la tabla local SchoolTrack sync_modificaciones, será creado
				OK:=1
			End if 
			
			If (OK=1)
				$b_actualizarRegistroST:=False:C215
				$b_esNuevo:=False:C215
				
				Case of 
					: ($l_recNumSyncModificaciones=No current record:K29:2)
						  //el registro de modificación no existe en la tabla local SchoolTrack sync_modificaciones
						CREATE RECORD:C68([sync_Modificaciones:284])
						[sync_Modificaciones:284]autouuid:1:=$t_uuid
						[sync_Modificaciones:284]condor_nombrebd:2:=<>t_nombreBDCondor
						[sync_Modificaciones:284]st_tabla:6:=$l_tabla4D
						[sync_Modificaciones:284]st_campo:7:=$l_campo4D
						[sync_Modificaciones:284]dts:16:=$t_dtsCondor
						[sync_Modificaciones:284]nuevoValor:12:=$t_nuevoValorCondor
						[sync_Modificaciones:284]modificadocondor:14:=False:C215
						[sync_Modificaciones:284]modificadost:15:=False:C215
						[sync_Modificaciones:284]version:13:=$l_versionCondor
						[sync_Modificaciones:284]uuid_colegio:21:=$t_uuidColegio
						[sync_Modificaciones:284]uuid_registro:11:=$t_uuidRegistro
						Sync_GuardaRegistro 
						$l_recNumSyncModificaciones:=Record number:C243([sync_Modificaciones:284])
						$b_actualizarRegistroST:=True:C214  //el registro objetivo debe ser actualizado con la información recibida desde Condor
						$b_esNuevo:=True:C214
						
					: (Not:C34($b_datoModificado))
						  // el valor del dato es exactamente el mismo en SyncDB y en la BD local
						  // copiamos el numero de versión y el dts desde Condor a la BD local y ponemos en FALSE los atributos indicadores de modificación en ambos lados
						$contenido:=OB_Create 
						OB_SET ($contenido;->$t_uuidPG;"autouuid")
						$answer:=SYNC_APICall ("cambiaestadomodificacion";HTTP POST method:K71:2;$contenido)
						If (Not:C34(SYNC_CHECKERROR ($answer)))
							[sync_Modificaciones:284]version:13:=$l_versionCondor
							[sync_Modificaciones:284]dts:16:=$t_dtsCondor
							[sync_Modificaciones:284]modificadocondor:14:=False:C215
							[sync_Modificaciones:284]modificadost:15:=False:C215
							Sync_GuardaRegistro 
							If ([sync_Modificaciones:284]st_campo:7=0)
								Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_nuevoValorCondor+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack)
							Else 
								Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_nuevoValorCondor+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack)
							End if 
						Else 
							Sync_LogEvento ("Condor -> ST";"Actualización fallida. ERROR API: "+OB Get:C1224($answer;"MSG");$t_nuevoValorCondor+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack)
						End if 
						
					: (($b_datoModificado) & ($l_versionCondor>[sync_Modificaciones:284]version:13))
						  // el numero de versión en Condor es mayor que en ST
						$b_actualizarRegistroST:=True:C214  //el registro objetivo debe ser actualizado con la información recibida desde Condor
						
					: (($b_datoModificado) & ($l_versionCondor<=[sync_Modificaciones:284]version:13))
						  // hay un conflicto: el numero de versión en SyncDB (condor) es  inferior o igual al numero de versión en ST y los datos son distintos
						  // nos quedamos con el dato mas reciente
						  // ***** SE PUEDE MANEJAR MEJOR PARA QUE UN HUMANO RESUELVA EL CONFLICTO ***** //
						If ($t_dtsCondor>[sync_Modificaciones:284]dts:16)
							  // el DTS es superior en Condor, la modificación es mas reciente
							$b_actualizarRegistroST:=True:C214  //el registro objetivo debe ser actualizado con la información recibida desde Condor
							
						Else 
							  // el DTS es superior en SchoolTrack, la modificación es mas reciente
							  // actualizamos datos en SyncDB con lo almacenado en la tabla sync_modificaciones local y ponemos en TRUE el atributo modificadoST en SyncDB
							$t_dtsDatoSchoolTrack:=[sync_Modificaciones:284]dts:16
							$l_versionDatoSchoolTrack:=[sync_Modificaciones:284]version:13
							$t_valorDatoSchoolTrack:=[sync_Modificaciones:284]nuevoValor:12
							$b_modificadoCondor:=False:C215
							$b_modificadoST:=True:C214
							$contenido:=OB_Create 
							OB_SET ($contenido;->$t_dtsDatoSchoolTrack;"dts")
							OB_SET ($contenido;->$l_versionDatoSchoolTrack;"version")
							OB_SET ($contenido;->$t_valorDatoSchoolTrack;"nuevovalor")
							OB_SET ($contenido;->$b_modificadoCondor;"modificadocondor")
							OB_SET ($contenido;->$b_modificadoST;"modificadost")
							OB_SET ($contenido;->$t_uuidPG;"autouuid")
							$answer:=SYNC_APICall ("updatemodificacion";HTTP POST method:K71:2;$contenido)
							If (Not:C34(SYNC_CHECKERROR ($answer)))
								[sync_Modificaciones:284]modificadocondor:14:=False:C215
								[sync_Modificaciones:284]modificadost:15:=False:C215
								Sync_GuardaRegistro 
								If ([sync_Modificaciones:284]st_campo:7=0)
									Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								Else 
									Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								End if 
							Else 
								Sync_LogEvento ("Condor -> ST";"Actualización fallida. ERROR API: "+OB Get:C1224($answer;"MSG");$t_nuevoValorCondor+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
							End if 
						End if 
						
					Else 
						$b_actualizarRegistroST:=False:C215
				End case 
				
				If ($b_actualizarRegistroST)
					  // el dato modificado debe ser actualizado en SchoolTrack
					  // determino el campo a actualizar
					RELATE ONE:C42([sync_Modificaciones:284]keyDiccionario:20)
					If ([sync_Modificaciones:284]st_campo:7#0)  //0 indica eliminaciones
						If ([sync_Modificaciones:284]st_tabla:6=Table:C252(->[xShell_Users:47]))
							  //READ ONLY([Profesores])
							  //$idprof:=KRL_GetNumericFieldData (->[Profesores]Auto_UUID;->[sync_Modificaciones]uuid_registro;->[Profesores]Numero)
							  //$l_recnum2:=KRL_FindAndLoadRecordByIndex (->[xShell_Users]NoEmployee;->$idprof;True)
							$l_recNum2:=Sync_UsuarioST ([sync_Modificaciones:284]uuid_registro:11)  //160692 MONO
						Else 
							$y_IdRegistro:=Field:C253([sync_Modificaciones:284]st_tabla:6;[sync_diccionario:285]st_RefCampoIdRegistro:15)
							  // cargo el registro objetivo
							$l_recNum2:=KRL_FindAndLoadRecordByIndex ($y_IdRegistro;->[sync_Modificaciones:284]uuid_registro:11;True:C214)
						End if 
						
						$y_tabla:=Table:C252([sync_Modificaciones:284]st_tabla:6)  //MONO 160692
						
						If (($l_recNum2=No current record:K29:2) & ([sync_Modificaciones:284]st_tabla:6#Table:C252(->[xShell_Users:47])))  //el registro de xshellUser actualmente no debe ser creado.
							$recnum:=Record number:C243([sync_Modificaciones:284])
							  //$y_tabla:=Table([sync_Modificaciones]st_tabla)//MONO 160692
							READ WRITE:C146($y_tabla->)
							CREATE RECORD:C68($y_tabla->)
							$y_IdRegistro->:=[sync_Modificaciones:284]uuid_registro:11
							  //$ptr:=Get pointer("<>vb_NoSincroHaciaCondor_"+String([sync_Modificaciones]st_tabla))
							  //$ptr->:=True
							SAVE RECORD:C53($y_tabla->)
							GOTO RECORD:C242([sync_Modificaciones:284];$recnum)
						End if 
						
						If ((OK=1) & (Records in selection:C76($y_tabla->)=1))  //MONO 160692
							  // el registro objetivo fue accesado en escritura, sin errores
							$y_tabla:=Table:C252([sync_Modificaciones:284]st_tabla:6)
							$y_campo:=Field:C253([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7)
							$l_tipoCampo:=Type:C295($y_campo->)
							
							  // ponemos en FALSE los atributos de modificación en ambas BDs
							$contenido:=OB_Create 
							OB_SET ($contenido;->$t_uuidPG;"autouuid")
							$answer:=SYNC_APICall ("cambiaestadomodificacion";HTTP POST method:K71:2;$contenido)
							If (Not:C34(SYNC_CHECKERROR ($answer)))
								  // los atributos de modificación fueron puestos en FALSE sin errores en Condor
								  // aplico la modificación en el registro objetivo en ST
								$modificado:=dhSync_HandleReceivingChanges ($y_campo;->$t_nuevoValorCondor)
								Case of 
									: ($l_tipoCampo=Is picture:K8:10)
										BASE64 DECODE:C896($t_nuevoValorCondor;$blob)
										BLOB TO PICTURE:C682($blob;$y_campo->;".jpg")
									: ($l_tipoCampo=Is BLOB:K8:12)
										BASE64 DECODE:C896($t_nuevoValorCondor;$y_campo->)
									: ($l_tipoCampo=Is boolean:K8:9)
										$y_campo->:=($t_nuevoValorCondor="1")
									: (($l_tipoCampo=Is alpha field:K8:1) | ($l_tipoCampo=Is text:K8:3))
										If (Type:C295(at_ExcepcionesFormato)=Is undefined:K8:13)
											ST_LoadModuleFormatExceptions ("SchoolTrack")
										End if 
										$y_campo->:=$t_nuevoValorCondor
										$y_campo->:=ST_Format ($y_campo)
									: ($l_tipoCampo=Is date:K8:7)
										$t_nuevoValorCondor:=$t_nuevoValorCondor+"T00:00:00"
										$y_campo->:=Date:C102($t_nuevoValorCondor)
									Else 
										$y_campo->:=Num:C11($t_nuevoValorCondor)
								End case 
								dhSync_PostProcessData ($y_campo)
								  //$ptr:=Get pointer("<>vb_NoSincroHaciaCondor_"+String([sync_Modificaciones]st_tabla))
								  //$ptr->:=True
								
								KRL_GotoRecord (->[sync_Modificaciones:284];$l_recNumSyncModificaciones;True:C214)
								If (OK=1)
									[sync_Modificaciones:284]dts:16:=$t_dtsCondor
									[sync_Modificaciones:284]nuevoValor:12:=$t_nuevoValorCondor
									[sync_Modificaciones:284]version:13:=$l_versionCondor
									[sync_Modificaciones:284]modificadocondor:14:=False:C215
									[sync_Modificaciones:284]modificadost:15:=False:C215
									Sync_GuardaRegistro 
									Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);[sync_Modificaciones:284]nuevoValor:12+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								End if 
								
								SAVE RECORD:C53($y_tabla->)
								KRL_UnloadReadOnly ($y_tabla)
							Else 
								If ($b_esNuevo)
									KRL_DeleteRecord (->[sync_Modificaciones:284];$l_recNumSyncModificaciones)
								End if 
								Sync_LogEvento ("Condor -> ST";"Actualización fallida. ERROR API: "+OB Get:C1224($answer;"MSG");[sync_Modificaciones:284]nuevoValor:12+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
							End if 
						End if 
						KRL_UnloadReadOnly ($y_tabla)
					End if 
				End if 
			Else 
				  // solo para depuración
				LOCKED BY:C353([sync_Modificaciones:284];$l_idProceso;$t_usuario;$t_usuarioMaquina;$t_nombreProceso)
			End if 
		End for 
		
		
		  // ***  ENVIO DE DATOS MODIFICADOS EN ST A SYNCDB  *** //
		
		  // busco los registros modificados de la tabla sync_modificaciones que han sido modificados en ST
		QUERY:C277([sync_Modificaciones:284];[sync_Modificaciones:284]modificadost:15=True:C214)
		If (Records in selection:C76([sync_Modificaciones:284])>0)
			LONGINT ARRAY FROM SELECTION:C647([sync_Modificaciones:284];$al_RecNums;"")
			For ($i_registros;1;Size of array:C274($al_RecNums))
				READ WRITE:C146([sync_Modificaciones:284])
				GOTO RECORD:C242([sync_Modificaciones:284];$al_RecNums{$i_registros})
				  // asigno los valores locales a variable
				$t_uuid:=[sync_Modificaciones:284]autouuid:1
				$l_tablaST:=[sync_Modificaciones:284]st_tabla:6
				$l_campoST:=[sync_Modificaciones:284]st_campo:7
				$l_tipo4DST:=[sync_Modificaciones:284]st_tipo4d:10
				$l_versionDatoSchoolTrack:=[sync_Modificaciones:284]version:13
				$t_dtsDatoSchoolTrack:=[sync_Modificaciones:284]dts:16
				$t_valorDatoSchoolTrack:=[sync_Modificaciones:284]nuevoValor:12
				$t_uuidRegistro:=[sync_Modificaciones:284]uuid_registro:11
				
				  // cargo los datos desde SyncDB
				  // para compararlos con el registro par en la tabla sync_modificaciones local
				$t_uuidCondor:=""
				$l_versionCondor:=0
				$t_dtsCondor:=""
				$t_nuevoValorCondor:=""
				$b_modificadoCondor:=False:C215
				$b_modificadoST:=False:C215
				  //$t_declaracion:="SELECT autouuid, version, dts, nuevovalor, modificadoCondor, modificadoST FROM sync_modificaciones WHERE autouuid='"+$t_uuid+"'"
				
				$t_uuidPG:=Util_MakeUUIDCanonical ($t_uuid)
				$answer:=SYNC_APICall ("obtienemodificacionporuuid";HTTP GET method:K71:1;$emptyobject;$t_uuidPG)
				If (Not:C34(SYNC_CHECKERROR ($answer)))
					$l_versionCondor:=OB Get:C1224($answer;"version";Is longint:K8:6)
					$t_dtsCondor:=OB Get:C1224($answer;"dts")
					$t_nuevoValorCondor:=OB Get:C1224($answer;"nuevovalor")
					$b_modificadoCondor:=OB Get:C1224($answer;"modificadoCondor";Is boolean:K8:9)
					$b_modificadoST:=OB Get:C1224($answer;"modificadoST";Is boolean:K8:9)
					$t_uuidCondor:=Util_MakeUUIDNonCanonical (OB Get:C1224($answer;"autouuid"))
					If (Position:C15("T";$t_dtsCondor)=0)  // normalizo el DTS al formato 4D
						$t_dtsCondor:=Replace string:C233($t_dtsCondor;" ";"T")
						$t_dtsCondor:=Substring:C12($t_dtsCondor;1;Position:C15(".";$t_dtsCondor)-1)+"Z"
					End if 
					
					
					  //If (vl_pgSQL_ErrorCode=0)
					$b_datoModificado:=Not:C34(ST_SonTextosIdenticos ($t_nuevoValorCondor;$t_valorDatoSchoolTrack))
					
					Case of 
						: (Not:C34(Util_isValidUUID ($t_uuidCondor)))
							  // no existe el registro en Condor, lo envío a syncDB en Condor
							$ins_uuid:=Util_MakeUUIDCanonical ([sync_Modificaciones:284]autouuid:1)
							$ins_uuidregistro:=Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_registro:11)
							$ins_uuidpersona:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_persona:22);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_persona:22);"")
							$ins_uuidprofesor:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_profesor:23);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_profesor:23);"")
							$ins_uuidalumno:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_alumno:24);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_alumno:24);"")
							
							$contenido:=OB_Create 
							OB_SET ($contenido;->$ins_uuid;"autouuid")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_nombrebd:2;"condor_nombrebd")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_tablaatributo:3;"condor_tablaatributo")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_tipoatributo:4;"condor_tipoatributo")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_valorAtributo:5;"condor_valoratributo")
							OB_SET ($contenido;->[sync_Modificaciones:284]st_tabla:6;"st_tabla")
							OB_SET ($contenido;->[sync_Modificaciones:284]st_campo:7;"st_campo")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_tabla:8;"condor_tabla")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_columna:9;"condor_columna")
							OB_SET ($contenido;->[sync_Modificaciones:284]st_tipo4d:10;"st_tipo4d")
							OB_SET ($contenido;->$ins_uuidregistro;"uuid_registro")
							OB_SET ($contenido;->$ins_uuidpersona;"uuid_persona")
							OB_SET ($contenido;->$ins_uuidprofesor;"uuid_profesor")
							OB_SET ($contenido;->$ins_uuidalumno;"uuid_alumno")
							OB_SET ($contenido;->[sync_Modificaciones:284]nuevoValor:12;"nuevovalor")
							OB_SET ($contenido;->[sync_Modificaciones:284]version:13;"version")
							OB_SET ($contenido;->[sync_Modificaciones:284]modificadocondor:14;"modificadocondor")
							OB_SET ($contenido;->[sync_Modificaciones:284]modificadost:15;"modificadost")
							OB_SET ($contenido;->[sync_Modificaciones:284]dts:16;"dts")
							OB_SET ($contenido;->[sync_Modificaciones:284]st_pkey:17;"st_pkey")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_pkey:18;"condor_pkey")
							OB_SET ($contenido;->[sync_Modificaciones:284]condor_tiposql:19;"condor_tiposql")
							OB_SET ($contenido;->[sync_Modificaciones:284]keyDiccionario:20;"keydiccionario")
							OB_SET ($contenido;->$cUUID;"uuid_colegio")
							$answer:=SYNC_APICall ("insertamodificaciondesdest";HTTP POST method:K71:2;$contenido)
							If (Not:C34(SYNC_CHECKERROR ($answer)))
								[sync_Modificaciones:284]modificadocondor:14:=False:C215
								[sync_Modificaciones:284]modificadost:15:=False:C215
								Sync_GuardaRegistro 
								If ([sync_Modificaciones:284]st_campo:7=0)
									Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								Else 
									Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								End if 
							Else 
								Sync_LogEvento ("ST -> Condor";"Actualización fallida. ERROR API: "+OB Get:C1224($answer;"MSG");$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
							End if 
							
						: (Not:C34($b_datoModificado))
							  // el valor del dato es exactamente el mismo en SyncDB y en la BD local
							  // copiamos el numero de versión y el dts desde Condor a la BD local y ponemos en FALSE los atributos indicadores de modificación en la BD local
							[sync_Modificaciones:284]version:13:=$l_versionCondor
							[sync_Modificaciones:284]dts:16:=$t_dtsCondor
							[sync_Modificaciones:284]modificadocondor:14:=False:C215
							[sync_Modificaciones:284]modificadost:15:=False:C215
							Sync_GuardaRegistro 
							If ([sync_Modificaciones:284]st_campo:7=0)
								Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
							Else 
								Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
							End if 
						: (($b_datoModificado) & ($l_versionCondor>=$l_versionDatoSchoolTrack))
							  // el valor del dato es distinto en SyncDB y en la BD local.
							If ($t_dtsCondor>$t_dtsDatoSchoolTrack)
								  // el dts en SyncDB es superior al de la BD local, copiamos los datos desde SyncDB
								  // y ponemos en FALSE los atributos de modificacion
								[sync_Modificaciones:284]version:13:=$l_versionCondor
								[sync_Modificaciones:284]nuevoValor:12:=$t_nuevoValorCondor
								[sync_Modificaciones:284]modificadocondor:14:=False:C215
								[sync_Modificaciones:284]modificadost:15:=False:C215
								Sync_GuardaRegistro 
								If ([sync_Modificaciones:284]st_campo:7=0)
									Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_nuevoValorCondor+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								Else 
									Sync_LogEvento ("Condor -> ST";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_nuevoValorCondor+" ("+$t_valorDatoSchoolTrack+")";$l_versionCondor;$t_dtsCondor;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								End if 
							Else 
								$b_modificadoCondor:=False:C215
								$b_modificadoST:=True:C214
								$ins_uuid:=Util_MakeUUIDCanonical ($t_uuidPG)
								$ins_uuidpersona:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_persona:22);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_persona:22);"")
								$ins_uuidprofesor:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_profesor:23);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_profesor:23);"")
								$ins_uuidalumno:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_alumno:24);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_alumno:24);"")
								$contenido:=OB_Create 
								OB_SET ($contenido;->$t_dtsDatoSchoolTrack;"dts")
								OB_SET ($contenido;->$l_versionDatoSchoolTrack;"version")
								OB_SET ($contenido;->$t_valorDatoSchoolTrack;"nuevovalor")
								OB_SET ($contenido;->$b_modificadoCondor;"modificadocondor")
								OB_SET ($contenido;->$b_modificadoST;"modificadost")
								OB_SET ($contenido;->$ins_uuidpersona;"uuid_persona")
								OB_SET ($contenido;->$ins_uuidprofesor;"uuid_profesor")
								OB_SET ($contenido;->$ins_uuidalumno;"uuid_alumno")
								OB_SET ($contenido;->$ins_uuid;"autouuid")
								TRACE:C157
								$answer:=SYNC_APICall ("updatemodificacion";HTTP POST method:K71:2;$contenido)
								If (Not:C34(SYNC_CHECKERROR ($answer)))
									[sync_Modificaciones:284]modificadocondor:14:=False:C215
									[sync_Modificaciones:284]modificadost:15:=False:C215
									Sync_GuardaRegistro 
									If ([sync_Modificaciones:284]st_campo:7=0)
										Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
									Else 
										Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
									End if 
								Else 
									Sync_LogEvento ("ST -> Condor";"Actualización fallida. ERROR API: "+OB Get:C1224($answer;"MSG");$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								End if 
							End if 
							
						: (($b_datoModificado) & ($l_versionCondor<=$l_versionDatoSchoolTrack))
							  // el numero de versión en Condor es inferior al de la BD local y los valores del campo son distintos
							  // actualizo el registro en SyncDB y pongo el flag modificadoST en true
							$b_modificadoCondor:=False:C215
							$b_modificadoST:=True:C214
							$ins_uuid:=Util_MakeUUIDCanonical ($t_uuidPG)
							$ins_uuidpersona:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_persona:22);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_persona:22);"")
							$ins_uuidprofesor:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_profesor:23);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_profesor:23);"")
							$ins_uuidalumno:=ST_Boolean2Text (Util_isValidUUID ([sync_Modificaciones:284]uuid_alumno:24);Util_MakeUUIDCanonical ([sync_Modificaciones:284]uuid_alumno:24);"")
							
							$contenido:=OB_Create 
							OB_SET ($contenido;->$t_dtsDatoSchoolTrack;"dts")
							OB_SET ($contenido;->$l_versionDatoSchoolTrack;"version")
							OB_SET ($contenido;->$t_valorDatoSchoolTrack;"nuevovalor")
							OB_SET ($contenido;->$b_modificadoCondor;"modificadocondor")
							OB_SET ($contenido;->$b_modificadoST;"modificadost")
							OB_SET ($contenido;->$ins_uuidpersona;"uuid_persona")
							OB_SET ($contenido;->$ins_uuidprofesor;"uuid_profesor")
							OB_SET ($contenido;->$ins_uuidalumno;"uuid_alumno")
							OB_SET ($contenido;->$ins_uuid;"autouuid")
							
							$answer:=SYNC_APICall ("updatemodificacion";HTTP POST method:K71:2;$contenido)
							If (Not:C34(SYNC_CHECKERROR ($answer)))
								[sync_Modificaciones:284]modificadocondor:14:=False:C215
								[sync_Modificaciones:284]modificadost:15:=False:C215
								Sync_GuardaRegistro 
								If ([sync_Modificaciones:284]st_campo:7=0)
									Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+".eliminado";$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								Else 
									Sync_LogEvento ("ST -> Condor";Table name:C256([sync_Modificaciones:284]st_tabla:6)+"."+Field name:C257([sync_Modificaciones:284]st_tabla:6;[sync_Modificaciones:284]st_campo:7);$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
								End if 
							Else 
								Sync_LogEvento ("ST -> Condor";"Actualización fallida. ERROR API: "+OB Get:C1224($answer;"MSG");$t_valorDatoSchoolTrack+" ("+$t_nuevoValorCondor+")";$l_versionDatoSchoolTrack;$t_dtsDatoSchoolTrack;[sync_Modificaciones:284]version:13;[sync_Modificaciones:284]dts:16)
							End if 
					End case 
					
				End if 
			End for 
			KRL_UnloadReadOnly (->[sync_Modificaciones:284])
		End if 
		DELAY PROCESS:C323(Current process:C322;60*5)
	End while 
	
	If (<>h_refArchivoSyncLog#?00:00:00?)
		CLOSE DOCUMENT:C267(<>h_refArchivoSyncLog)
	End if 
	
End if 