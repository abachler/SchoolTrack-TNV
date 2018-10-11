//%attributes = {}
  //AL_CalculaSituacionfinal_cl

  //20130829 ASM quito la localización de los textos que van en actas

C_LONGINT:C283($lastGradeReaded;$1;$idAlumno)
C_TEXT:C284($lastClassReaded)
C_REAL:C285($minimum0;$minimum1;$minimum2;$minimum3)
C_BOOLEAN:C305($succes;$autoAbs;$wasReadOnly)

If (Count parameters:C259=1)
	$idAlumno:=$1
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno;True:C214)
	
	If (OK=1)
		$succes:=True:C214
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno;True:C214)
		If (OK=1)
			$succes:=True:C214
		End if 
	End if 
Else 
	$succes:=True:C214
End if 


$wasReadOnly:=Read only state:C362([Alumnos:2])
$recNum:=Record number:C243([Alumnos:2])

$comentarioSituacionFinal:=""
If (($succes) & (Records in selection:C76([Alumnos:2])=1))
	  //lectura de parametros de evaluación del nivel del alumno
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
	
	If (([xxSTR_Niveles:6]EsNIvelActivo:30) & (Not:C34([xxSTR_Niveles:6]EsNivelSistema:10)))
		$autoPromote:=[xxSTR_Niveles:6]Promoción_auto:18
		If ([Alumnos:2]nivel_numero:29#$lastGradeReaded)
			EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
		End if 
		
		
		If ([Alumnos:2]curso:20#$lastClassReaded)
			If (Application version:C493>="1400")
				ACTAS_LeeConfiguracion ([Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20;<>gYear)
			Else 
				ACTAS_LeeConfiguracion ([Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20;<>gYear)
			End if 
			$lastClassReaded:=[Alumnos:2]curso:20
			
			READ WRITE:C146([Alumnos:2])
			KRL_GotoRecord (->[Alumnos:2];$recNum;True:C214)  //ABC
			  //calculo de la situación final según evaluación
			$customComments:=""
			$startCustomComments:=Position:C15("[";[Alumnos:2]Observaciones_en_Acta:58)
			$endCustomComments:=Position:C15("]";[Alumnos:2]Observaciones_en_Acta:58)
			If (($startCustomComments>0) & ($endCustomComments>0))
				$endCustomComments:=Position:C15("]";[Alumnos:2]Observaciones_en_Acta:58)
				$length:=$endCustomComments-$startCustomComments+1
				$customComments:=Substring:C12([Alumnos:2]Observaciones_en_Acta:58;$startCustomComments;$length)
			End if 
			
			$strExim:=""
			$strExim1:=""
			$strExim2:=""
			$strPendiente:=""
			
			  //$recNum:=Record number([Alumnos])
			
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			
			
			If (Not:C34([Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61))
				
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$idAsig;[Asignaturas:18]Asignatura:3;$aName;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;$aEximido;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7;$aDateEximicion;[Asignaturas:18]Incluida_en_Actas:44;$aEnActas;[Alumnos_Calificaciones:208]Reprobada:9;$reprobada;[Alumnos_ComplementoEvaluacion:209]Eximicion_Obs:9;$aObsEximicion;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$aRealNtaF;[Asignaturas:18]Electiva:11;$aElectiva)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				  //READ WRITE([Alumnos])
				  //KRL_GotoRecord (->[Alumnos];$recNum;True)
				
				If (Size of array:C274($idAsig)>0)
					For ($i;1;Size of array:C274($aRealNtaF))
						Case of 
							: (($adateEximicion{$i}>!00-00-00!) & ($aEnActas{$i}))
								If ($aObsEximicion{$i}#"")
									$strExim2:=$aObsEximicion{$i}
								Else 
									If ([Alumnos:2]nivel_numero:29>=11)
										$strExim1:="Reg. Int. Nº:"+String:C10($aEximido{$i})+" Fecha: "+String:C10($adateEximicion{$i};dt_GetNullDateString )
									Else 
										$strExim1:="Reg. Int. Nº:"+String:C10($aEximido{$i})+" Fecha: "+String:C10($adateEximicion{$i};dt_GetNullDateString )
									End if 
								End if 
							: (($aRealNtaF{$i}=-2) & ($aEnActas{$i}))
								$strPendiente:="PENDIENTE"
						End case 
					End for 
					
					
					Case of 
						: (($strExim1#"") & ($strExim2#""))
							$strExim:=$strExim1+"; "+$strExim2
						: ($strExim1#"")
							$strExim:=$strExim1
						: (($strExim2#"") & ($strExim1=""))
							$strExim:=$strExim2
					End case 
					
					
					$Reprobada{0}:=True:C214
					$insuf:=0
					$adjustGrade11:=False:C215
					For ($j;1;Size of array:C274($reprobada))
						If ($reprobada{$j})
							$insuf:=$insuf+1
							  //De acuerdo al Decreto exento 083 del 1991 del ministerio de Educación, titulo 1, párrafo 2, articulo 5, letra C, indica que la nota de aprobación debe ser mínimo de 5,5 si el alumno tiene reprobado Leguaje y comunicación o Matemáticas en 3ro y 4to Medio.
							  //http://edufacil.cl/documentos/DEX83_01.pdf documento con el decreto
							If (([Alumnos:2]nivel_numero:29>=11) & ($aElectiva{$j}=False:C215) & (($aName{$j}="Lengua Castellan@") | ($aName{$j}="Lenguaje y Comunicación") | ($aName{$j}="Matematica@")))
								$adjustGrade11:=True:C214
							End if 
						End if 
					End for 
					
					
					
					Case of 
						: (iPrintActa=Notas)
							$minimum0:=EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_0:25;0;iGradesDec)
							$minimum1:=EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_1:26;0;iGradesDec)
							$minimum2:=EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_2:27;0;iGradesDec)
							$minimum3:=EV2_Real_a_Nota ([xxSTR_Niveles:6]Minimo_3:31;0;iGradesDec)
						: (iPrintActa=Puntos)
							$minimum0:=EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_0:25;0;iPointsDec)
							$minimum1:=EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_1:26;0;iPointsDec)
							$minimum2:=EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_2:27;0;iPointsDec)
							$minimum3:=EV2_Real_a_Puntos ([xxSTR_Niveles:6]Minimo_3:31;0;iPointsDec)
						: ((iPrintActa=Porcentaje) | (iPrintActa=Simbolos))
							$minimum0:=[xxSTR_Niveles:6]Minimo_0:25
							$minimum1:=[xxSTR_Niveles:6]Minimo_1:26
							$minimum2:=[xxSTR_Niveles:6]Minimo_2:27
							$minimum3:=[xxSTR_Niveles:6]Minimo_3:31
					End case 
					
					$asist:=0
					$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
					AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;->$asist)
					$asist:=Round:C94($asist;0)
					
					KRL_GotoRecord (->[Alumnos:2];$recNum;True:C214)
					$ultimaSituacionFinal:=[Alumnos:2]Situacion_final:33
					  //MONO: Esta Observación es editable desde cursos, al recalcular la situación final la perdemos sólo sería cambiarse por las opciones que se ven mas adelante.
					  //[Alumnos]Observaciones_en_Acta:="" 
					[Alumnos:2]Situacion_final:33:=""
					
					
					$mot:=""
					$obs:=""
					$obsAbs:=""
					$obsActa:=""
					If ([xxSTR_Niveles:6]Promoción_auto:18)
						[Alumnos:2]Situacion_final:33:="P"
						If ($asist<[xxSTR_Niveles:6]Minimo_asistencia:24)
							If ([xxSTR_Niveles:6]AutoPromo_inasistencia:32=False:C215)
								$mot:="Reprobado por asistencia insuficiente"
								$obsAbs:="Reprobado por asistencia insuficiente"
								[Alumnos:2]Situacion_final:33:="R"
							Else 
								[Alumnos:2]Situacion_final:33:="P"
								$obsAbs:=Replace string:C233("Asistencia inferior a ^0%";"^0";String:C10([xxSTR_Niveles:6]Minimo_asistencia:24))
								$obsActa:=vs_PromoAbs
								$autoAbs:=True:C214
								$mot:=""
							End if 
						End if 
					Else 
						If ($asist<[xxSTR_Niveles:6]Minimo_asistencia:24)
							Case of 
									  //: ($ultimaSituacionFinal="P")
									  //$obsAbs:=Replace string(RP_GetIdxString (21121;14);"^0";String([xxSTR_Niveles]Minimo_asistencia))
									  //$obsActa:=vs_PromoAbs
									  //$autoAbs:=True
									  //$mot:=""
									  //[Alumnos]Situacion_final:="P"
									
								: ([xxSTR_Niveles:6]AutoPromo_inasistencia:32=False:C215)
									$mot:="Reprobado por asistencia insuficiente"
									$obsAbs:="Reprobado por asistencia insuficiente"
									
								Else 
									$obsAbs:=Replace string:C233("Asistencia inferior a ^0%";"^0";String:C10([xxSTR_Niveles:6]Minimo_asistencia:24))
									$obsActa:=vs_PromoAbs
									$autoAbs:=True:C214
									$mot:=""
							End case 
						End if 
						
						$numFinalAverage:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26
						  //If ([Alumnos]Promedio_General_Oficial="")
						If (([Alumnos:2]Promedio_General_Oficial:32="") & ($mot=""))  //20180705 ASM Ticket 211189 No reprobaba por inasistencia ni por calificaciones cuando no encontraba promedio general
							$mot:=""
							$obs:=""
						Else 
							Case of 
								: ($insuf>=3)
									If ($minimum3>0)
										If ($numFinalAverage>=$minimum3)
										Else 
											$mot:="Reprobado por rendimiento"
											$obs:="^0 asignaturas reprobadas y promedio general inferior a ^1"
											$obs:=Replace string:C233($obs;"^0";String:C10($insuf))
											$obs:=Replace string:C233($obs;"^1";String:C10($minimum3))
										End if 
									Else 
										$mot:="Reprobado por rendimiento"
										$obs:="^0 asignaturas reprobadas"
										$obs:=Replace string:C233($obs;"^0";String:C10($insuf))
										$obs:=Replace string:C233($obs;"^1";String:C10($minimum3))
									End if 
								: ($insuf=2)
									If ($minimum2>0)
										If ($adjustGrade11)
											$minimum2:=5.5
										End if 
										If ($numFinalAverage>=$minimum2)
										Else 
											If ($adjustGrade11)
												$obs:="^0 asignaturas reprobadas y promedio general inferior a ^1"
												$obs:=Replace string:C233($obs;"^0";String:C10($insuf))
												$obs:=Replace string:C233($obs;"^1";String:C10($minimum2))
												$mot:="Reprobado por rendimiento"
											Else 
												$obs:="^0 asignaturas reprobadas y promedio general inferior a ^1"
												$obs:=Replace string:C233($obs;"^0";String:C10($insuf))
												$obs:=Replace string:C233($obs;"^1";String:C10($minimum2))
												$mot:="Reprobado por rendimiento"
											End if 
										End if 
									Else 
										$mot:="Reprobado por rendimiento"
										$obs:="^0 asignaturas reprobadas"
										$obs:=Replace string:C233($obs;"^0";String:C10($insuf))
									End if 
								: ($insuf=1)
									If ($minimum1>0)
										If ($numFinalAverage>=$minimum1)
										Else 
											$mot:="Reprobado por rendimiento"
											$obs:="Una asignatura reprobada y promedio general inferior a ^1"
											$obs:=Replace string:C233($obs;"^0";String:C10($insuf))
											$obs:=Replace string:C233($obs;"^1";String:C10($minimum1))
										End if 
									Else 
										$mot:="Reprobado por rendimiento"
										$obs:="Una asignatura reprobada"
									End if 
								: ($insuf=0)
									If ($numFinalAverage>=$minimum0)
										
									Else 
										$mot:="Reprobado por rendimiento"
										$obs:="Promedio general inferior a ^1"
										$obs:=Replace string:C233($obs;"^1";String:C10($minimum0))
									End if 
							End case 
						End if 
					End if 
					
					
					$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
					$d2:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
					Case of 
						: ([Alumnos:2]Status:50="Oyente")
							[Alumnos:2]Observaciones_en_Acta:58:="Oyente. No figura en actas"
							[Alumnos:2]Situacion_final:33:="X"
						: ([Alumnos:2]Status:50="En Trámite")
							[Alumnos:2]Observaciones_en_Acta:58:="Situación en trámite. No figura en actas"
							[Alumnos:2]Situacion_final:33:="X"
						: ([Alumnos:2]Status:50="Promovido anticipadamente")
							[Alumnos:2]Observaciones_en_Acta:58:=vs_PromoAnticipada
							If ($asist<[xxSTR_Niveles:6]Minimo_asistencia:24)
								[Alumnos:2]Observaciones_en_Acta:58:=[Alumnos:2]Observaciones_en_Acta:58+"; "+vs_PromoAbs
							End if 
							[Alumnos:2]Situacion_final:33:="P"
							
							  //: (([Alumnos]Status="Retirado@") & ([Alumnos]Fecha_de_retiro>$d1) & ([Alumnos]Fecha_de_retiro<=$d2))
						: ([Alumnos:2]Status:50="Retirado@")
							[Alumnos:2]Observaciones_en_Acta:58:="Retirado el: "+String:C10([Alumnos:2]Fecha_de_retiro:42;"!00/00/00!")
							[Alumnos:2]Situacion_final:33:="Y"
							
						: ([xxSTR_Niveles:6]Promoción_auto:18)
							If ([Alumnos:2]Situacion_final:33="")
								[Alumnos:2]Situacion_final:33:="P"
							End if 
							If ($obsActa#"")
								[Alumnos:2]Observaciones_en_Acta:58:=$obsActa
							End if 
							If ($obsAbs#"")
								[Alumnos:2]Comentario_Situacion_Final:31:=$obsAbs
							End if 
							
						: ($strPendiente#"")
							[Alumnos:2]Situacion_final:33:="??"
							[Alumnos:2]Comentario_Situacion_Final:31:="***PENDIENTE***"
							[Alumnos:2]Observaciones_en_Acta:58:=[Alumnos:2]Comentario_Situacion_Final:31
						Else 
							If ($numFinalAverage=0)
								[Alumnos:2]Situacion_final:33:=""
								[Alumnos:2]Observaciones_en_Acta:58:=""
							Else 
								Case of 
									: (([Alumnos:2]Fecha_de_retiro:42>$d2) & ($mot=""))
										[Alumnos:2]Comentario_Situacion_Final:31:="Retirado el: "+String:C10([Alumnos:2]Fecha_de_retiro:42;"!00/00/00!")
										[Alumnos:2]Situacion_final:33:="P"
									: (([Alumnos:2]Situacion_final:33="P") & ($asist<[xxSTR_Niveles:6]Minimo_asistencia:24) & ($mot=""))
										[Alumnos:2]Observaciones_en_Acta:58:=vs_PromoAbs
									: (($mot="") & ($autoabs))
										[Alumnos:2]Situacion_final:33:="P"
										[Alumnos:2]Observaciones_en_Acta:58:=vs_PromoAbs
									: ($mot#"")
										[Alumnos:2]Situacion_final:33:="R"
										[Alumnos:2]Comentario_Situacion_Final:31:=$mot+"\r"+$obs
									Else 
										[Alumnos:2]Situacion_final:33:="P"
										[Alumnos:2]Comentario_Situacion_Final:31:=""
								End case 
							End if 
							
					End case 
					
					  //TICKET 196807 
					  //si no se limpia el campo se concatena la observacion cada vez que se evalua situacion final
					  //[Alumnos]Observaciones_en_Acta:="" ASM Ticket 216082
					If ($strExim#"")
						If ([Alumnos:2]Observaciones_en_Acta:58="")
							[Alumnos:2]Observaciones_en_Acta:58:=$strExim
						Else 
							[Alumnos:2]Observaciones_en_Acta:58:=[Alumnos:2]Observaciones_en_Acta:58+"; "+$strExim
						End if 
					End if 
					
					If ($customComments#"")
						If ([Alumnos:2]Observaciones_en_Acta:58#"")
							[Alumnos:2]Observaciones_en_Acta:58:=[Alumnos:2]Observaciones_en_Acta:58+"; "+$customComments
						Else 
							[Alumnos:2]Observaciones_en_Acta:58:=$customComments
						End if 
					End if 
					
					Case of 
						: ((([Alumnos:2]RUT:5="") | ([Alumnos:2]RUT:5="S/N") | ([Alumnos:2]RUT:5="E/T")) & ([Alumnos:2]Nacionalidad:8#"Chilena"))
							If (Position:C15("En Trámite";[Alumnos:2]Observaciones_en_Acta:58)=0)
								If ([Alumnos:2]Observaciones_en_Acta:58#"")
									[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero; "+[Alumnos:2]Observaciones_en_Acta:58
								Else 
									[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero"
								End if 
							End if 
						: (([Alumnos:2]RUT:5="S/N@") & ([Alumnos:2]Nacionalidad:8#"Chilena"))
							If (Position:C15("Alumno Extranjero";[Alumnos:2]Observaciones_en_Acta:58)=0)
								If ([Alumnos:2]Observaciones_en_Acta:58#"")
									[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero; "+[Alumnos:2]Observaciones_en_Acta:58
								Else 
									[Alumnos:2]Observaciones_en_Acta:58:="Alumno Extranjero"
								End if 
							End if 
					End case 
				Else 
					
					Case of 
						: ([Alumnos:2]Status:50="Oyente")
							[Alumnos:2]Observaciones_en_Acta:58:="Oyente. No figura en actas"
							[Alumnos:2]Situacion_final:33:="X"
						: ([Alumnos:2]Status:50="En Trámite")
							[Alumnos:2]Observaciones_en_Acta:58:="Situación en trámite. No figura en actas"
							[Alumnos:2]Situacion_final:33:="X"
						: ([Alumnos:2]Status:50="Retirado@")
							$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
							$d2:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
							If (([Alumnos:2]Fecha_de_retiro:42>$d1) & ([Alumnos:2]Fecha_de_retiro:42<$d2))
								[Alumnos:2]Observaciones_en_Acta:58:="Retirado el: "+String:C10([Alumnos:2]Fecha_de_retiro:42;"!00/00/00!")
								[Alumnos:2]Situacion_final:33:="Y"
							Else 
								[Alumnos:2]Comentario_Situacion_Final:31:="Retirado el "+String:C10([Alumnos:2]Fecha_de_retiro:42)+". No figura en actas"
								[Alumnos:2]Situacion_final:33:="X"
							End if 
						Else 
							If ($autopromote)
								[Alumnos:2]Situacion_final:33:="P"
								
							End if 
					End case 
				End if 
				[Alumnos_SintesisAnual:210]Promovido:91:=([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
				SAVE RECORD:C53([Alumnos:2])
				
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
				AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62;->[Alumnos:2]Comentario_Situacion_Final:31;False:C215)
				AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9;->[Alumnos:2]Observaciones_en_Acta:58;False:C215)
				AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]SituacionFinal:8;->[Alumnos:2]Situacion_final:33;True:C214)
				
				If ([Alumnos:2]nivel_numero:29=12)
					[Alumnos:2]Chile_PromedioEMedia:73:=AL_PromedioUChile_cl 
					SAVE RECORD:C53([Alumnos:2])
				End if 
				
				KRL_ResetPreviousRWMode (->[Alumnos:2];$wasReadOnly)
				
			End if 
			
		End if 
	End if 
End if 
$0:=$succes






