//%attributes = {}
  // SR_CertificadoEstudios_cl()
  // Por: Alberto Bachler: 17/04/13, 16:07:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_continuar;$b_optativas)
C_LONGINT:C283($i_filas;$l_año;$l_asignaturasSinEvaluacion;$l_error;$l_ignorado;$l_largoRUN;$l_nivel;$l_opcionUsuario;$l_recNumAlumno;$l_recNumCurso)
C_TEXT:C284($t_curso;$t_decretoEvaluacion;$t_decretoPlanEstudio;$t_digitoVerificador;$t_llaveRegistro;$t_RUN;$t_rut;$t_ultimoSector)

C_LONGINT:C283(vi_Agno)


  //MONO 03-04-2018: Comento debido a que no se está limpiando ni tampoco se explica el motivo de este semaforo.
  //While (Semaphore("ImprimiendoCertificado"))
  //DELAY PROCESS(Current process;30)
  //End while 


If (vi_Agno=0)
	$l_año:=Num:C11(CD_Request ("Para que año desea imprimir certificados: ";"Aceptar";"Cancelar";"";String:C10(<>gYear)))
	vi_Agno:=$l_año
Else 
	$l_año:=vi_Agno
End if 


$b_continuar:=True:C214
READ ONLY:C145([Alumnos_SintesisAnual:210])
If ($l_año<<>gYear)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=-[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=$l_año)
	$l_nivel:=[Alumnos_SintesisAnual:210]NumeroNivel:6
	$t_curso:=[Alumnos_SintesisAnual:210]Curso:7
	If (Records in selection:C76([Alumnos_SintesisAnual:210])=0)
		$b_continuar:=False:C215
	End if 
End if 

If ($b_continuar)
	vb_usarSignosSeparadores:=False:C215
	
	If (Macintosh option down:C545 | Windows Alt down:C563)
		$l_opcionUsuario:=CD_Dlog (0;"En el certificado además de la nota numérica se imprime su conversión en letras\rP"+"uede usar la palabra \"coma\" o el signo de puntuación\",\".\r\r¿Qué forma desea imprim"+"ir?";"";"Usar \"coma\"";"Usar \",\"")
		If ($l_opcionUsuario=1)
			vb_usarSignosSeparadores:=False:C215
		Else 
			vb_usarSignosSeparadores:=True:C214
		End if 
	End if 
	
	
	QR_InitGenericObjects 
	
	  //vl_MainTable:=Table(->[xxTMP_Lineas_Certificados])
	  //If (Application version>="15@")
	  //SRP_FijaTabla (SRArea;vl_MainTable)
	  //  //SR_SetLongProperty (SRArea;1;SRP_DataSource_TableID;vl_MainTable)
	  //Else 
	  //$l_error:=SR Main Table2 (SRArea;1;vl_MainTable;"")
	  //$l_error:=SR Main Table2 (SRArea;0;vl_MainTable;"")
	  //End if 
	
	$l_recNumAlumno:=Record number:C243([Alumnos:2])
	vQR_Long10:=$l_año
	
	If ($l_año=<>gYear)
		$l_nivel:=[Alumnos:2]nivel_numero:29
		$t_curso:=[Alumnos:2]curso:20
		ACTAS_LeeConfiguracion ([Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20)
		
		
	Else 
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=$l_año)
		$l_nivel:=[Alumnos_Historico:25]Nivel:11
		$t_curso:=[Alumnos_Historico:25]Curso:3
		
		ACTAS_LeeConfiguracion ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7;[Alumnos_SintesisAnual:210]Año:2)
	End if 
	
	
	
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;$l_nivel;$l_año)
	$l_recNumCurso:=Record number:C243([Cursos:3])
	
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	If ($l_año=<>gYear)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
	Else 
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214)
	End if 
	CREATE SET:C116([Alumnos_Calificaciones:208];"enactas")
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
	
	AT_DimArrays (Size of array:C274(atActas_SubsectoresCertif);->aQR_Longint1;->aQR_Longint2;->aQR_Text1;->aQR_Text2;->aQR_Text3;->aQR_text4;->aQR_Boolean1;->aQR_Boolean2;->aQR_Boolean3)
	
	
	$b_optativas:=False:C215
	$t_ultimoSector:=""
	For ($i_filas;1;Size of array:C274(atActas_SubsectoresCertif))
		
		KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
		
		
		aQR_Longint1{$i_filas}:=[Alumnos:2]numero:1
		aQR_Longint2{$i_filas}:=$i_filas
		aQR_Text2{$i_filas}:=atActas_SubsectoresCertif{$i_filas}
		
		
		Case of 
			: ((atActas_SubsectoresCertif{$i_filas}="Promedio General") | (atActas_SubsectoresCertif{$i_filas}="Promedio Final"))
				$t_llaveRegistro:=String:C10(<>gInstitucion)+"."+String:C10($l_año)+"."+String:C10($l_nivel)+"."+String:C10([Alumnos:2]numero:1)
				$l_ignorado:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
				aQR_Text1{$i_filas}:=""
				aQR_Text3{$i_filas}:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
				aQR_text4{$i_filas}:=ST_Num2Text (Num:C11([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29);True:C214;vb_usarSignosSeparadores)
				
				$b_optativas:=True:C214
				aQR_Boolean1{$i_filas}:=True:C214
				
			: ((atActas_SubsectoresCertif{$i_filas}="Porcentaje de asistencia") | (atActas_SubsectoresCertif{$i_filas}="% de asistencia"))
				$t_llaveRegistro:=String:C10(<>gInstitucion)+"."+String:C10($l_año)+"."+String:C10($l_nivel)+"."+String:C10([Alumnos:2]numero:1)
				$l_ignorado:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
				aQR_Text1{$i_filas}:=""
				aQR_Text3{$i_filas}:=String:C10(Round:C94([Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;0);"##0")
				aQR_Text4{$i_filas}:=ST_Num2Text2 (Num:C11(aQR_Text3{$i_filas});"es")
				aQR_Boolean1{$i_filas}:=True:C214
				
				
			Else 
				If ($l_año=<>gYear)
					USE SET:C118("enactas")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Asignatura:3=atActas_SubsectoresCertif{$i_filas})
					RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
					If (Records in selection:C76([Alumnos_Calificaciones:208])=1)
						If ([Asignaturas:18]Sector:9#$t_ultimoSector)
							aQR_Text1{$i_filas}:=[Asignaturas:18]Sector:9
						Else 
							aQR_Text1{$i_filas}:=""
						End if 
						$t_ultimoSector:=[Asignaturas:18]Sector:9
						aQR_Text2{$i_filas}:=[Asignaturas:18]Asignatura:3
						If ([Asignaturas:18]Electiva:11)
							aQR_Boolean2{$i_filas}:=True:C214
						End if 
						If ([Asignaturas:18]Es_Optativa:70)
							aQR_Boolean1{$i_filas}:=True:C214
							aQR_Boolean3{$i_filas}:=True:C214
						End if 
						
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"")
							If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="x")
								aQR_Text3{$i_filas}:="EX"
								aQR_text4{$i_filas}:="Eximido"
							Else 
								aQR_Text3{$i_filas}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
								If (vb_usarSignosSeparadores=False:C215)
									aQR_text4{$i_filas}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492
								Else 
									aQR_text4{$i_filas}:=ST_Num2Text (Num:C11([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36);True:C214;vb_usarSignosSeparadores)
								End if 
							End if 
							
							
						Else 
							If ($b_optativas)
								aQR_Boolean1{$i_filas}:=True:C214
								aQR_Text3{$i_filas}:=vs_AbrNoReligion
								aQR_text4{$i_filas}:=vs_NoReligion
							Else 
								aQR_Text3{$i_filas}:="-"
								aQR_text4{$i_filas}:="---"
							End if 
						End if 
					Else 
						If ($b_optativas)
							aQR_Boolean1{$i_filas}:=True:C214
							aQR_Text3{$i_filas}:=vs_AbrNoReligion
							aQR_text4{$i_filas}:=vs_NoReligion
						Else 
							aQR_Text3{$i_filas}:="-"
							aQR_text4{$i_filas}:="---"
						End if 
					End if 
					
				Else 
					
					USE SET:C118("enactas")
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;Automatic:K51:4;Do not modify:K51:1)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Asignatura:2=atActas_SubsectoresCertif{$i_filas})
					RELATE ONE:C42([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
					If (Records in selection:C76([Alumnos_Calificaciones:208])=1)
						If ([Asignaturas_Historico:84]Sector:38#$t_ultimoSector)
							aQR_Text1{$i_filas}:=[Asignaturas_Historico:84]Sector:38
						Else 
							aQR_Text1{$i_filas}:=""
						End if 
						$t_ultimoSector:=[Asignaturas_Historico:84]Sector:38
						aQR_Text2{$i_filas}:=[Asignaturas_Historico:84]Asignatura:2
						If ([Asignaturas_Historico:84]Electiva:10)
							aQR_Boolean2{$i_filas}:=True:C214
						End if 
						If ([Asignaturas_Historico:84]Optativa:24)
							aQR_Boolean1{$i_filas}:=True:C214
							aQR_Boolean3{$i_filas}:=True:C214
						End if 
						
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"")
							
							If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="x")
								aQR_Text3{$i_filas}:="EX"
								aQR_text4{$i_filas}:="Eximido"
							Else 
								aQR_Text3{$i_filas}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
								If (vb_usarSignosSeparadores=False:C215)
									aQR_text4{$i_filas}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492
								Else 
									aQR_text4{$i_filas}:=ST_Num2Text (Num:C11([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36);True:C214;vb_usarSignosSeparadores)
								End if 
							End if 
						Else 
							If ($b_optativas)
								aQR_Boolean1{$i_filas}:=True:C214
								aQR_Text3{$i_filas}:=vs_AbrNoReligion
								aQR_text4{$i_filas}:=vs_NoReligion
							Else 
								aQR_Text3{$i_filas}:="-"
								aQR_text4{$i_filas}:="---"
							End if 
						End if 
					Else 
						If ($b_optativas)
							aQR_Boolean1{$i_filas}:=True:C214
							aQR_Text3{$i_filas}:=vs_AbrNoReligion
							aQR_text4{$i_filas}:=vs_NoReligion
						Else 
							aQR_Text3{$i_filas}:="-"
							aQR_text4{$i_filas}:="---"
						End if 
					End if 
				End if 
				
				KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
		End case 
	End for 
	
	
	
	  // elimininación del excedente de registros de lineas de certificados en la tabla [xxTMP_Lineas_Certificados]
	ALL RECORDS:C47([xxTMP_Lineas_Certificados:195])
	CREATE SET:C116([xxTMP_Lineas_Certificados:195];"$todos")
	
	REDUCE SELECTION:C351([xxTMP_Lineas_Certificados:195];Size of array:C274(aQR_Longint1))
	CREATE SET:C116([xxTMP_Lineas_Certificados:195];"$lineasNecesarias")
	
	
	DIFFERENCE:C122("$todos";"$lineasNecesarias";"$aEliminar")
	USE SET:C118("$aEliminar")
	KRL_DeleteSelection (->[xxTMP_Lineas_Certificados:195])
	
	USE SET:C118("$lineasNecesarias")
	READ WRITE:C146([xxTMP_Lineas_Certificados:195])
	ARRAY TO SELECTION:C261(aQR_Longint1;[xxTMP_Lineas_Certificados:195]ID_Alumno:6;aQR_Longint2;[xxTMP_Lineas_Certificados:195]Orden:1;aQR_Text1;[xxTMP_Lineas_Certificados:195]Sector:2;aQR_Text2;[xxTMP_Lineas_Certificados:195]Subsector:3;aQR_Text3;[xxTMP_Lineas_Certificados:195]Calificacion:4;aQR_text4;[xxTMP_Lineas_Certificados:195]Calificacion_Palabras:5;aQR_Boolean1;[xxTMP_Lineas_Certificados:195]EnPIe:9;aQR_Boolean2;[xxTMP_Lineas_Certificados:195]Electiva:7;aQR_Boolean3;[xxTMP_Lineas_Certificados:195]Optativa:8)
	SELECTION TO ARRAY:C260([xxTMP_Lineas_Certificados:195];aQR_longint100)
	CREATE SET:C116([xxTMP_Lineas_Certificados:195];"$lineasNecesarias")
	
	USE SET:C118("$lineasNecesarias")
	QUERY SELECTION:C341([xxTMP_Lineas_Certificados:195];[xxTMP_Lineas_Certificados:195]EnPIe:9=True:C214)
	ORDER BY:C49([xxTMP_Lineas_Certificados:195];[xxTMP_Lineas_Certificados:195]Orden:1;>)
	SELECTION TO ARRAY:C260([xxTMP_Lineas_Certificados:195]Subsector:3;aQR_Text11;[xxTMP_Lineas_Certificados:195]Calificacion:4;aQR_Text12;[xxTMP_Lineas_Certificados:195]Calificacion_Palabras:5;aQR_Text13)
	
	
	  // MOD Ticket N° 183864: Patricio Aliaga. Se ajusta opcion no imprimir subsectores no evaluados, basado en preferencia de usuario por configuracion ""
	  //$l_asignaturasSinEvaluacion:=Count in array(aQR_text4;"-@")
	  //If (($l_asignaturasSinEvaluacion>0) & (<>gyear>vQR_Long10))
	  //$l_opcionUsuario:=CD_Dlog (0;"El modelo de certificado de "+GetGrado ($l_nivel)+" para el año "+String(vQR_Long10)+" contiene asignaturas del nivel que no fueron evaluadas para "+[Alumnos]Apellidos_y_Nombres+", ¿Desea mostrar solo en las que fue evaluado?";"";"Si";"No")
	If (vi_PrintEvaluadas=1)
		For (vQR_integer1;1;Size of array:C274(aQR_longint100))
			GOTO RECORD:C242([xxTMP_Lineas_Certificados:195];aQR_longint100{vQR_integer1})
			If ([xxTMP_Lineas_Certificados:195]Calificacion:4="-@")
				REMOVE FROM SET:C561([xxTMP_Lineas_Certificados:195];"$lineasNecesarias")
			End if 
		End for 
	End if 
	  //End if 
	
	USE SET:C118("$lineasNecesarias")
	QUERY SELECTION:C341([xxTMP_Lineas_Certificados:195];[xxTMP_Lineas_Certificados:195]EnPIe:9=False:C215)
	ORDER BY:C49([xxTMP_Lineas_Certificados:195];[xxTMP_Lineas_Certificados:195]Orden:1;>)
	SELECTION TO ARRAY:C260([xxTMP_Lineas_Certificados:195]ID_Alumno:6;aQR_Longint1;[xxTMP_Lineas_Certificados:195]Orden:1;aQR_Longint2;[xxTMP_Lineas_Certificados:195]Sector:2;aQR_Text1;[xxTMP_Lineas_Certificados:195]Subsector:3;aQR_Text2;[xxTMP_Lineas_Certificados:195]Calificacion:4;aQR_Text3;[xxTMP_Lineas_Certificados:195]Calificacion_Palabras:5;aQR_text4;[xxTMP_Lineas_Certificados:195]EnPIe:9;aQR_Boolean1;[xxTMP_Lineas_Certificados:195]Electiva:7;aQR_Boolean2;[xxTMP_Lineas_Certificados:195]Optativa:8;aQR_Boolean3)
	
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
	If ([Alumnos:2]numero:1=0)
		$t_rut:="RUN Nº                       "
	Else 
		If (Num:C11(Substring:C12([Alumnos:2]RUT:5;1;1))>0)
			$t_digitoVerificador:=[Alumnos:2]RUT:5[[Length:C16([Alumnos:2]RUT:5)]]
			$t_RUN:=Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1)
			$l_largoRUN:=Length:C16($t_RUN)
			Case of 
				: ($l_largoRUN=7)
					$t_RUN:=Substring:C12($t_RUN;1;1)+"."+Substring:C12($t_RUN;2;3)+"."+Substring:C12($t_RUN;5;3)
				: ($l_largoRUN=8)
					$t_RUN:=Substring:C12($t_RUN;1;2)+"."+Substring:C12($t_RUN;3;3)+"."+Substring:C12($t_RUN;6;3)
				: ($l_largoRUN=9)
					$t_RUN:=Substring:C12($t_RUN;1;3)+"."+Substring:C12($t_RUN;4;3)+"."+Substring:C12($t_RUN;7;3)
			End case 
			$t_rut:="RUN: "+$t_RUN+"-"+$t_digitoVerificador
		Else 
			If ([Alumnos:2]Nacionalidad:8#"Chilen@")
				$t_rut:="RUN en trámite (extranjero)"
			Else 
				$t_rut:=""
			End if 
		End if 
	End if 
	
	
	Case of 
		: ([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
			If (vtSTR_TextoPromocion="")
				If ($l_nivel=12)
					sFinalSit:="obtiene Licencia de Educación Media."
				Else 
					If ([Alumnos:2]Sexo:49="F")
						sFinalSit:="es promovida a "+GetGrado ($l_nivel+1)+"."
					Else 
						sFinalSit:="es promovido a "+GetGrado ($l_nivel+1)+"."
					End if 
				End if 
				sFinalSit:="En consecuencia: "+sFinalSit
			Else 
				sFinalSit:=vtSTR_TextoPromocion
			End if 
		: ([Alumnos_SintesisAnual:210]SituacionFinal:8="R")
			If (vtSTR_TextoRepitencia="")
				sFinalSit:="En consecuencia: debe repetir curso."
			Else 
				sFinalSit:=vtSTR_TextoRepitencia
			End if 
		Else 
			sFinalSit:=""
	End case 
	
	
	If (($l_año=<>gYear) & ($l_recNumCurso#-1))
		GOTO RECORD:C242([Cursos:3];$l_recNumCurso)
		Case of 
			: ($l_año>=2002)
				sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
				vcert5:=sclass+vCert5
			: ((($l_nivel<=7) | ($l_nivel=9) | ($l_nivel=10) | ($l_nivel=11)) & ($l_año>=2001))
				sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
				vcert5:=sclass+vCert5
			: ((($l_nivel<=6) | ($l_nivel=10) | ($l_nivel=11)) & ($l_año>=2000))
				sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
				vcert5:=sclass+vCert5
			: ((($l_nivel<=5) | ($l_nivel=9)) & ($l_año>=1999))
				sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
				vcert5:=sclass+vCert5
			Else 
				sClass:=GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
		End case 
		
		If (vi_PrintHeadName=1)
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
			vQR_Text12:=[Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+"\r"+"\t"+"Profesor Jefe"
		Else 
			vQR_Text12:="Profesor Jefe"
		End if 
		
		$t_decretoPlanEstudio:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39))
		$t_decretoEvaluacion:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38))
		
		vcert5:=Replace string:C233(vcert5;"^0";$t_decretoPlanEstudio)
		vcert5:=Replace string:C233(vcert5;"^1";$t_decretoEvaluacion)
		
	Else 
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=$l_año)
		Case of 
			: ($l_año>=2002)
				sClass:=$t_rut+" de "+GetGrado ([Alumnos_Historico:25]Nivel:11;[Alumnos_Historico:25]Curso:3)+", "
				vcert5:=sclass+vCert5
			: ((([Alumnos_Historico:25]Nivel:11<=7) | ([Alumnos_Historico:25]Nivel:11=9) | ([Alumnos_Historico:25]Nivel:11=10) | ([Alumnos_Historico:25]Nivel:11=11)) & ($l_año>=2001))
				sClass:=$t_rut+" de "+GetGrado ([Alumnos_Historico:25]Nivel:11;[Alumnos_Historico:25]Curso:3)+", "
				vcert5:=sclass+vCert5
			: ((([Alumnos_Historico:25]Nivel:11<=6) | ([Alumnos_Historico:25]Nivel:11=9) | ([Alumnos_Historico:25]Nivel:11=10)) & ($l_año>=2000))
				sClass:=$t_rut+" de "+GetGrado ([Alumnos_Historico:25]Nivel:11;[Alumnos_Historico:25]Curso:3)+", "
				vcert5:=sclass+vCert5
			: ((([Alumnos_Historico:25]Nivel:11<=5) | ([Alumnos_Historico:25]Nivel:11=9)) & (<>icrtfYear>=1999))
				sClass:=$t_rut+" de "+GetGrado ([Alumnos_Historico:25]Nivel:11;[Alumnos_Historico:25]Curso:3)+", "
				vcert5:=sclass+vCert5
			Else 
				sClass:=GetGrado ([Alumnos_Historico:25]Nivel:11;[Alumnos_Historico:25]Curso:3)+", "
		End case 
		
		If (vi_PrintHeadName=1)
			vQR_Text12:=[Alumnos_Historico:25]ProfesorJefe:33+"\r"+"\t"+"Profesor Jefe"
		Else 
			vQR_Text12:="Profesor Jefe"
		End if 
		
		
	End if 
	
	vQR_Text1:=""
	vQR_Text14:=<>gComuna+", "+String:C10(Current date:C33(*);3)
	  //ABC 186576 
	  //agrego validación para el texto vcert4, ya que  siempre se estaba escribiendo en este método
	  //, este se llena desde la configuración, es muy extraño que venga vacío
	If (vCert4="")
		vCert4:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, otorga el presente certificado de calificaciones anuales y situación final a:")
		vCert4:=Replace string:C233(vCert4;"^0";<>gDecCoop)
		vCert4:=Replace string:C233(vCert4;"^1";<>gRolBD)
	End if 
	
Else 
	QR_InitGenericObjects 
	REDUCE SELECTION:C351([xxTMP_Lineas_Certificados:195];0)
	vcert5:="RUN: "+SR_FormatoRUT2 ([Alumnos:2]RUT:5)
End if 