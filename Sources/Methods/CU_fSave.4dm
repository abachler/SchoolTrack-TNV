//%attributes = {}
  //CU_fSave

C_LONGINT:C283($0)
C_BOOLEAN:C305(modCdt;CUv_mEvVal;modFirmas;vb_ModDelegados)

$0:=0
RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)

If ([Cursos:3]Numero_del_curso:6>0)
	If (USR_checkRights ("M";->[Cursos:3]))
		If ((KRL_RegistroFueModificado (->[Cursos:3])) | (modCdt) | (CUv_mEvVal) | (modFirmas) | (vb_ModDelegados))
			If (([Cursos:3]Curso:1#"") & ([Cursos:3]Nivel_Numero:7>Nivel_AdmisionDirecta) & ([Cursos:3]Nivel_Numero:7#0) & ([Cursos:3]Letra_del_curso:9#""))
				$isNewRecord:=Is new record:C668([Cursos:3])
				
				If (modCdt)
					CU_fSaveCdta 
				End if 
				If (CUv_mEvVal)
					CU_fSaveEvVal 
				End if 
				If (vb_ModDelegados)
					CU_SaveDelegados 
				End if 
				
				
				Case of 
					: (([Cursos:3]cl_CodigoTipoEnseñanza:21=10) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // parvularia
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21=160) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=163)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // basica comuna adultos o básica escuelas carceles
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21>=211) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=216)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // Deficiencia auditiva, mental, visual, alteraciones del lenguaje
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: (([Cursos:3]cl_CodigoTipoEnseñanza:21=361) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // media HC Adultos Decreto 12
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21=460) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=461)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // TP Comercial adultos y decreto 152
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21=560) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=561)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // TP Industrial adultos y decreto 152
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21=660) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=661)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // TP Técnica adultos y decreto 152
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21=760) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=761)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // TP Agrícola adultos y decreto 152
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					: ((([Cursos:3]cl_CodigoTipoEnseñanza:21=860) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=861)) & ([Cursos:3]cl_CodigoNivelEspecial:36=""))  // TP Marítima adultos y decreto 152
						$ignore:=CD_Dlog (0;__ ("El tipo de enseñanza seleccionado requiere especificar el código de nivel o grado para este curso."))
					Else 
						If ([Cursos:3]cl_CodigoNivelEspecial:36="")
							[Cursos:3]cl_CodigoNivelEspecial:36:=String:C10([Cursos:3]Nivel_Numero:7)
						End if 
				End case 
				SAVE RECORD:C53([Cursos:3])
				CREATE SET:C116([Cursos:3];"class")
				CU_LoadArrays 
				KRL_ExecuteOnConnectedClients ("CU_LoadArrays")
				If ($isNewRecord)
					$p:=New process:C317("NIV_LoadArrays";Pila_256K)
					KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
				End if 
				USE SET:C118("class")
				CLEAR SET:C117("class")
				$0:=1
			Else 
				BEEP:C151
				$0:=-1
			End if 
		End if 
	End if 
End if 