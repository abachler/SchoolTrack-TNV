//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
C_LONGINT:C283($idAlumno)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_alumnouuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumno")
$t_statusNuevo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"statusnuevo")
$idAlumno:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_alumnouuid;->[Alumnos:2]numero:1)
$idFamilia:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_alumnouuid;->[Alumnos:2]Familia_Número:24)
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (STWA2_Priv_GetMethodAccess ("AL_CambiaStatusAlumno";$idUser))
		If (KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno;False:C215)>-1)
			$t_statusActual:=[Alumnos:2]Status:50
			Case of 
				: ($t_statusNuevo="Promovido anticipadamente")  //PROBADO
					$date:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fechapromocion")
					$d_fechaPromoción:=Date:C102($date)
					$d_fechaPromoción:=DT_GetDateFromDayMonthYear (Day of:C23($d_fechaPromoción);Month of:C24($d_fechaPromoción);Year of:C25($d_fechaPromoción))
					If ($d_fechaPromoción#!00-00-00!)
						KRL_ReloadInReadWriteMode (->[Alumnos:2])
						[Alumnos:2]Fecha_de_retiro:42:=$d_fechaPromoción
						[Alumnos:2]Status:50:=$t_statusNuevo
						[Alumnos:2]Tutor_numero:36:=0
						If (AL_EliminaInfoPostRetiro )
							SAVE RECORD:C53([Alumnos:2])
							KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
							[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
							SAVE RECORD:C53([Alumnos_SintesisAnual:210])
							KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
							AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
							KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
							LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_statusActual+" a "+$t_statusNuevo)
							$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
						Else 
							$0:=SERwa_GeneraRespuesta ("-5";"No fue posible eliminar informaciones posteriores a la fecha. Cambio no realizado")
						End if 
					Else 
						$0:=SERwa_GeneraRespuesta ("-4";"Fecha inválida")
					End if 
				: (($t_statusActual="Retirado@") & ($t_statusNuevo="Retirado@"))
					$t_fecharetiro:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecharetiro")
					$d_fecharetiro:=Date:C102($t_fecharetiro)
					$d_fecharetiro:=DT_GetDateFromDayMonthYear (Day of:C23($d_fecharetiro);Month of:C24($d_fecharetiro);Year of:C25($d_fecharetiro))
					If ($d_fecharetiro#!00-00-00!)
						$b_ocultoennominas:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ocultoennominas")="True")
						$b_retiradotemporal:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"retiradotemporal")="True")
						$t_colegiodestino:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"colegiodestino")
						$b_colegiogrupo:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"colegiogrupo")="True")
						KRL_ReloadInReadWriteMode (->[Alumnos:2])
						[Alumnos:2]ocultoEnNominas:89:=$b_ocultoennominas
						If ($b_retiradotemporal)
							[Alumnos:2]Status:50:="Retirado temporalmente"
						Else 
							[Alumnos:2]Status:50:="Retirado"
						End if 
						[Alumnos:2]Fecha_de_retiro:42:=$d_fecharetiro
						[Alumnos:2]Colegio_destino:102:=$t_colegiodestino
						[Alumnos:2]Va_a_colegio_del_grupo:101:=$b_colegiogrupo
						SAVE RECORD:C53([Alumnos:2])
						LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_statusActual+" a "+$t_statusNuevo)
						KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
						[Alumnos_SintesisAnual:210]Curso:7:=[Alumnos:2]curso:20
						[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
						AL_CalculaSituacionFinal ($idAlumno)
						If (($t_statusNuevo="Retirado@") & (($t_statusActual="Activo") | ($t_statusActual="Oyente") | ($t_statusActual="En Trámite")))
							AL_RetiroAlumno_EstadoADT ($idAlumno)
							BM_CreateRequest ("co-AsignaNumerosDeFolio")  // solo se ejecuta para Colombia
						End if 
						QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="activo";*)
						QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$idAlumno;*)
						QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=$idFamilia)
						If (Records in selection:C76([Alumnos:2])=0)
							AL_InactivaRegistroRelacionados ("InactivaFamilia";$idFamilia)
							AL_InactivaRegistroRelacionados ("InactivaPersonasRelacionadas";$idFamilia)
						End if 
						KRL_UnloadReadOnly (->[Alumnos:2])
						$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
					Else 
						$0:=SERwa_GeneraRespuesta ("-4";"Fecha inválida")
					End if 
				: ($t_statusNuevo="Egresado")
					$l_año:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"yearpromocion"))
					If (($l_año>=1492) & ($l_año<<>gYear))
						KRL_ReloadInReadWriteMode (->[Alumnos:2])
						[Alumnos:2]nivel_numero:29:=Nivel_Egresados
						[Alumnos:2]Nivel_Nombre:34:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nivel:1)
						[Alumnos:2]curso:20:="EGR-"+String:C10($l_año)
						[Alumnos:2]Sección:26:="Egresados"
						[Alumnos:2]Tutor_numero:36:=0
						[Alumnos:2]Status:50:="Egresado"
						[Alumnos:2]Apoderado_académico_Número:27:=0
						SAVE RECORD:C53([Alumnos:2])
						LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_statusActual+" a "+$t_statusNuevo)
						KRL_UnloadReadOnly (->[Alumnos:2])
						$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
					Else 
						$0:=SERwa_GeneraRespuesta ("-6";"El año de egreso no puede ser inferior a 1492 ni igual o superior al año actual.")
					End if 
				: (($t_statusNuevo="Activo") | ($t_statusNuevo="Oyente") | ($t_statusNuevo="En Trámite"))
					KRL_ReloadInReadWriteMode (->[Alumnos:2])
					$l_recNumAlumno:=Record number:C243([Alumnos:2])
					[Alumnos:2]ocultoEnNominas:89:=False:C215
					If ([Alumnos:2]nivel_numero:29=Nivel_Retirados)
						[Alumnos:2]nivel_numero:29:=[Alumnos:2]NoNIvel_alRetirarse:84
						[Alumnos:2]curso:20:=[Alumnos:2]Curso_alRetirarse:83
						[Alumnos:2]Nivel_Nombre:34:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]NoNIvel_alRetirarse:84;->[xxSTR_Niveles:6]Nivel:1)
					End if 
					[Alumnos:2]Fecha_de_retiro:42:=!00-00-00!
					[Alumnos:2]Status:50:=$t_statusNuevo
					[Alumnos:2]Situacion_final:33:=""
					[Alumnos:2]Motivo_de_retiro:43:=""
					[Alumnos:2]Colegio_destino:102:=""
					SAVE RECORD:C53([Alumnos:2])
					KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
					[Alumnos_SintesisAnual:210]Curso:7:=[Alumnos:2]curso:20
					[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
					KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
					AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
					KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
					LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_statusActual+" a "+$t_statusNuevo)
					AL_CreateGradeRecords 
					KRL_UnloadReadOnly (->[Alumnos:2])
					$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
				: ($t_statusNuevo#"")
					$t_fecharetiro:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecharetiro")
					$d_fecharetiro:=Date:C102($t_fecharetiro)
					$d_fecharetiro:=DT_GetDateFromDayMonthYear (Day of:C23($d_fecharetiro);Month of:C24($d_fecharetiro);Year of:C25($d_fecharetiro))
					If ($d_fecharetiro#!00-00-00!)
						$b_ocultoennominas:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ocultoennominas")="True")
						$b_retiradotemporal:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"retiradotemporal")="True")
						$t_colegiodestino:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"colegiodestino")
						$b_colegiogrupo:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"colegiogrupo")="True")
						KRL_ReloadInReadWriteMode (->[Alumnos:2])
						[Alumnos:2]ocultoEnNominas:89:=$b_ocultoennominas
						[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
						[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
						[Alumnos:2]Status:50:=$t_statusNuevo
						[Alumnos:2]Situacion_final:33:="Y"
						[Alumnos:2]Tutor_numero:36:=0
						If ($b_retiradotemporal)
							[Alumnos:2]Status:50:="Retirado temporalmente"
						Else 
							[Alumnos:2]Status:50:="Retirado"
						End if 
						[Alumnos:2]Colegio_destino:102:=$t_colegiodestino
						[Alumnos:2]Va_a_colegio_del_grupo:101:=$b_colegiogrupo
						[Alumnos:2]Motivo_de_retiro:43:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivoretiro")
						SAVE RECORD:C53([Alumnos:2])
						KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
						AL_CalculaSituacionFinal ($idAlumno)
						If (($t_statusNuevo="Retirado@") & (($t_statusActual="Activo") | ($t_statusActual="Oyente") | ($t_statusActual="En Trámite")))
							AL_RetiroAlumno_EstadoADT ($idAlumno)
							BM_CreateRequest ("co-AsignaNumerosDeFolio")  // solo se ejecuta para Colombia
						End if 
						QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="activo";*)
						QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$idAlumno;*)
						QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=$idFamilia)
						If (Records in selection:C76([Alumnos:2])=0)
							AL_InactivaRegistroRelacionados ("InactivaFamilia";$idFamilia)
							AL_InactivaRegistroRelacionados ("InactivaPersonasRelacionadas";$idFamilia)
						End if 
						KRL_UnloadReadOnly (->[Alumnos:2])
						$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
					Else 
						$0:=SERwa_GeneraRespuesta ("-4";"Fecha inválida")
					End if 
				Else 
					$0:=SERwa_GeneraRespuesta ("-3";"Status inválido.")
			End case 
		Else 
			$0:=SERwa_GeneraRespuesta ("-2";"Alumno no encontrado.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 