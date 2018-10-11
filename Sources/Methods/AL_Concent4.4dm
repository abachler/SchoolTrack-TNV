//%attributes = {}
  // AL_Concent4()
  // Por: Alberto Bachler K.: 28-02-14, 16:27:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_asignatura;$i_asignaturad;$l_AsignaturasPlanComun;$l_IdxPlan;$l_numeroElectivas)
C_POINTER:C301($y_nota)
C_TEXT:C284($t_llaveRegistro;$t_nota)

ARRAY BOOLEAN:C223($ab_esElectiva;0)
ARRAY BOOLEAN:C223($ab_esOptativa;0)
ARRAY BOOLEAN:C223($ab_incluidaEnActas;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_notaLiteral;0)

$l_AsignaturasPlanComun:=20
Case of 
	: (tipoDocumento="Carta")
		$l_numeroElectivas:=12
	: (tipoDocumento="Oficio")
		$l_numeroElectivas:=24
End case 

Case of 
	: ([Alumnos:2]nivel_numero:29<12)
	: ([Alumnos:2]nivel_numero:29=12)
		
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
		If ([Cursos:3]cl_SectorEconomicoTP:27#"")
			vt_Especialidad:="Sector Económico: "+[Cursos:3]cl_SectorEconomicoTP:27
		End if 
		If (([Cursos:3]cl_EspecialidadTP:28#"") & ([Cursos:3]cl_SectorEconomicoTP:27#""))
			vt_Especialidad:=vt_Especialidad+" - Especialidad: "+[Cursos:3]cl_EspecialidadTP:28
		End if 
		
		
		
		  // ABC 20170807 TICKET 185219
		  //se pierde el alumno seleccionado cuando lee config de ACTA
		  //agrego KRL_GOTORECORD
		
		C_LONGINT:C283($l_recnum)
		$l_recnum:=Record number:C243([Alumnos:2])
		
		$t_llaveRegistro:=String:C10(<>ginstitucion)+"."+String:C10(<>gYear)+".12."+String:C10([Alumnos:2]numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
		vAsist4:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
		vFinal4:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
		
		
		EVS_ReadStyleData (-1)
		
		If (<>gCustom#"")
			sSchool4:=<>gCustom
		Else 
			sSchool4:=sAltSchool4
		End if 
		
		If (<>gCiudad#"")
			sCity4:=<>gCiudad
		Else 
			sCity4:=sAltCity4
		End if 
		
		
		sCoop4:=sAltCoop4
		sPLan4:=sAltPlan4
		
		
		vFinal4:=""
		vAsist4:=100
		iYear4:=<>gYear
		
		If (iYear4<1)
			vRel4:=""
		End if 
		
		ACTAS_LeeConfiguracion ([Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20)
		KRL_GotoRecord (->[Alumnos:2];$l_recnum)
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_notaLiteral;[Asignaturas:18]Asignatura:3;$at_asignaturas;[Asignaturas:18]Electiva:11;$ab_esElectiva;[Asignaturas:18]Incluida_en_Actas:44;$ab_incluidaEnActas;[Asignaturas:18]Es_Optativa:70;$ab_esOptativa)
		
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SORT ARRAY:C229($at_asignaturas;$ab_esElectiva;$at_notaLiteral;$ab_incluidaEnActas;$ab_esOptativa;>)
		
		For ($i_asignatura;1;Size of array:C274($at_asignaturas))
			If ($ab_incluidaEnActas{$i_asignatura})
				$at_notaLiteral{$i_asignatura}:=Replace string:C233($at_notaLiteral{$i_asignatura};".";<>tXS_RS_DecimalSeparator)
				$at_notaLiteral{$i_asignatura}:=Replace string:C233($at_notaLiteral{$i_asignatura};",";<>tXS_RS_DecimalSeparator)
				$t_nota:=$at_notaLiteral{$i_asignatura}
				If ($t_nota="X")
					$t_nota:="EX"
				End if 
				
				If ($t_nota#"")
					Case of 
						: ((Position:C15($at_asignaturas{$i_asignatura};vt_nombreOptativa2)>0) & ($ab_esOptativa{$i_asignatura}))  // especial Grange
							  // MOD ticket N° 190990 PA 20171110
							  //vOpt2:=$t_nota
							vOpt4:=$t_nota
						: (($at_asignaturas{$i_asignatura}="Religión@") | ($ab_esOptativa{$i_asignatura}))
							  // MOD ticket N° 190990 PA 20171110
							  //vRel2:=$t_nota
							vRel4:=$t_nota
							If (($at_asignaturas{$i_asignatura}#"Religión@") & (Position:C15($at_asignaturas{$i_asignatura};vt_NombreOptativa)=0))
								vt_NombreOptativa:=vt_NombreOptativa+" o "+$at_asignaturas{$i_asignatura}
							End if 
						Else 
							If ($ab_esElectiva{$i_asignatura})
								$l_IdxPlan:=Find in array:C230(aPEAsgName;$at_asignaturas{$i_asignatura})
								If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_numeroElectivas))
									$y_nota:=Get pointer:C304("vCalPE4_"+String:C10($l_IdxPlan))
									$y_nota->:=$t_nota
								Else 
									$l_IdxPlan:=Find in array:C230(aPCAsgName;$at_asignaturas{$i_asignatura})
									If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
										$y_nota:=Get pointer:C304("vCalPC4_"+String:C10($l_IdxPlan))
										$y_nota->:=$t_nota
									Else 
										vErrors:=vErrors+$at_asignaturas{$i_asignatura}+", "
									End if 
								End if 
							Else 
								$l_IdxPlan:=Find in array:C230(aPCAsgName;$at_asignaturas{$i_asignatura})
								If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
									$y_nota:=Get pointer:C304("vCalPC4_"+String:C10($l_IdxPlan))
									$y_nota->:=$t_nota
								Else 
									$l_IdxPlan:=Find in array:C230(aPEAsgName;$at_asignaturas{$i_asignatura})
									If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_numeroElectivas))
										$y_nota:=Get pointer:C304("vCalPE4_"+String:C10($l_IdxPlan))
										$y_nota->:=$t_nota
									Else 
										vErrors:=vErrors+$at_asignaturas{$i_asignatura}+", "
									End if 
								End if 
							End if 
					End case 
				Else 
					If ($at_asignaturas{$i_asignatura}="Religión@")
						$t_nota:=vs_AbrNoreligion
					End if 
				End if 
			End if 
		End for 
		
		$t_llaveRegistro:=String:C10(<>ginstitucion)+"."+String:C10(<>gYear)+".12."+String:C10([Alumnos:2]numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
		vFinal4:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
		vAsist4:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
		vAsist4:=Round:C94(vAsist4;0)
		
	: ([Alumnos:2]nivel_numero:29>12)
		
		$i_asignaturad:=-[Alumnos:2]numero:1
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=$i_asignaturad;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]SituacionFinal:8="P";*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]NumeroNivel:6=12)
		
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Nivel:11=12;*)
		QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=[Alumnos_SintesisAnual:210]Año:2)
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos_Historico:25]Curso:3)
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Alumnos_Historico:25]Curso:3;*)
		QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=[Alumnos_Historico:25]Año:2)
		
		If ([Alumnos:2]nivel_numero:29=1000)  //alumnos egresados
			If ([Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56#"")
				vt_Especialidad:="Sector Económico: "+[Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56
			End if 
			If (([Cursos_SintesisAnual:63]cl_EspecialidadTP:55#"") & ([Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56#""))
				vt_Especialidad:=vt_Especialidad+" - Especialidad: "+[Cursos_SintesisAnual:63]cl_EspecialidadTP:55
			End if 
		Else 
			vt_Especialidad:=[Cursos:3]cl_EspecialidadTP:28
		End if 
		
		iYear4:=[Alumnos_SintesisAnual:210]Año:2
		
		If (iYear4<1)
			vRel4:=""
		End if 
		
		  //TICKET 185219
		  //se pierde el alumno seleccionado cuando lee config de ACTA
		  //agrego KRL_GOTORECORD
		
		C_LONGINT:C283($l_recnum)
		$l_recnum:=Record number:C243([Alumnos:2])
		
		$t_llaveRegistro:=String:C10(<>ginstitucion)+"."+String:C10([Alumnos_Historico:25]Año:2)+".12."+String:C10([Alumnos:2]numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
		vAsist4:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
		vFinal4:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
		vAsist4:=Round:C94(vAsist4;0)
		KRL_GotoRecord (->[Alumnos:2];$l_recnum)
		
		ACTAS_LeeConfiguracion ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7;[Alumnos_SintesisAnual:210]Año:2)
		
		
		If ([Alumnos_Historico:25]Colegio_anterior:20#"")
			sSchool4:=[Alumnos_Historico:25]Colegio_anterior:20
		Else 
			sSchool4:=sAltSchool4
		End if 
		
		If ([Alumnos_Historico:25]Ciudad_ColegioAnterior:25#"")
			sCity4:=[Alumnos_Historico:25]Ciudad_ColegioAnterior:25
		Else 
			sCity4:=sAltCity4
		End if 
		
		If ([Alumnos_Historico:25]DPE_ColegioAnterior:26#"")
			sCoop4:=[Alumnos_Historico:25]DPE_ColegioAnterior:26
		Else 
			sCoop4:=sAltCoop4
		End if 
		
		If ([Alumnos_Historico:25]DEyP_ColegioAnterior:27#"")
			sPLan4:=[Alumnos_Historico:25]DEyP_ColegioAnterior:27
		Else 
			sPLan4:=sAltPlan4
		End if 
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos_Historico:25]Nivel:11;iYear4)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_notaLiteral;[Asignaturas_Historico:84]Asignatura:2;$at_asignaturas;[Asignaturas_Historico:84]Electiva:10;$ab_esElectiva;[Asignaturas_Historico:84]Incluida_En_Actas:7;$ab_incluidaEnActas;[Asignaturas_Historico:84]Optativa:24;$ab_esOptativa)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SORT ARRAY:C229($at_asignaturas;$ab_esElectiva;$at_notaLiteral;$ab_incluidaEnActas;$ab_esOptativa;>)
		
		
		For ($i_asignatura;1;Size of array:C274($at_asignaturas))
			If ($ab_incluidaEnActas{$i_asignatura})
				Case of 
					: ($at_asignaturas{$i_asignatura}="Religión@")
						If (Num:C11($at_notaLiteral{$i_asignatura})>0)
							$t_nota:=NTA_Nota_a_Concepto (Num:C11($at_notaLiteral{$i_asignatura}))
						Else 
							$t_nota:=$at_notaLiteral{$i_asignatura}
						End if 
					: (Num:C11($at_notaLiteral{$i_asignatura})>10)
						  //$t_nota:=Replace string($at_notaLiteral{$i_asignatura}[[1]]+","+$at_notaLiteral{$i_asignatura}[[2]];",,";",")
						$t_nota:=Replace string:C233($at_notaLiteral{$i_asignatura}[[1]]+<>tXS_RS_DecimalSeparator+$at_notaLiteral{$i_asignatura}[[2]];<>tXS_RS_DecimalSeparator+<>tXS_RS_DecimalSeparator;<>tXS_RS_DecimalSeparator)
					: (Num:C11($at_notaLiteral{$i_asignatura})>0)
						  //$t_nota:=String(Num($at_notaLiteral{$i_asignatura});"0,0")
						$t_nota:=String:C10(Num:C11($at_notaLiteral{$i_asignatura});"0"+<>tXS_RS_DecimalSeparator+"0")
					: (($at_notaLiteral{$i_asignatura}="X") | ($at_notaLiteral{$i_asignatura}="EX"))
						$t_nota:="EX"
					: ($at_notaLiteral{$i_asignatura}="P")
						$t_nota:="P!!"
					Else 
						$t_nota:=$at_notaLiteral{$i_asignatura}
				End case 
				If ($t_nota#"")
					Case of 
						: ((Position:C15($at_asignaturas{$i_asignatura};vt_nombreOptativa2)>0) & ($ab_esOptativa{$i_asignatura}))  // especial Grange
							vOpt4:=$t_nota
						: (($at_asignaturas{$i_asignatura}="Religión@") | ($ab_esOptativa{$i_asignatura}))
							vRel4:=$t_nota
							If (($at_asignaturas{$i_asignatura}#"Religión@") & (Position:C15($at_asignaturas{$i_asignatura};vt_NombreOptativa)=0))
								vt_NombreOptativa:=vt_NombreOptativa+" o "+$at_asignaturas{$i_asignatura}
							End if 
						Else 
							If ($ab_esElectiva{$i_asignatura})
								$l_IdxPlan:=Find in array:C230(aPEAsgName;$at_asignaturas{$i_asignatura})
								If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_numeroElectivas))
									$y_nota:=Get pointer:C304("vCalPE4_"+String:C10($l_IdxPlan))
									$y_nota->:=$t_nota
								Else 
									$l_IdxPlan:=Find in array:C230(aPCAsgName;$at_asignaturas{$i_asignatura})
									If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
										$y_nota:=Get pointer:C304("vCalPC4_"+String:C10($l_IdxPlan))
										$y_nota->:=$t_nota
									Else 
										vErrors:=vErrors+$at_asignaturas{$i_asignatura}+", "
									End if 
								End if 
							Else 
								$l_IdxPlan:=Find in array:C230(aPCAsgName;$at_asignaturas{$i_asignatura})
								If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
									$y_nota:=Get pointer:C304("vCalPC4_"+String:C10($l_IdxPlan))
									$y_nota->:=$t_nota
								Else 
									$l_IdxPlan:=Find in array:C230(aPEAsgName;$at_asignaturas{$i_asignatura})
									If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
										$y_nota:=Get pointer:C304("vCalPE4_"+String:C10($l_IdxPlan))
										$y_nota->:=$t_nota
									Else 
										vErrors:=vErrors+$at_asignaturas{$i_asignatura}+", "
									End if 
								End if 
							End if 
					End case 
				Else 
					If ($at_asignaturas{$i_asignatura}="Religión@")
						$t_nota:=vs_AbrNoreligion
					End if 
				End if 
			End if 
		End for 
End case 



  //para que muestre los errores de maximo de asignaturas
C_TEXT:C284(maxAsignaturas)
Case of 
	: (tipoDocumento="Carta")
		  //maximo son 20 asignaturas del plan comun y 12 electivas
		If (Size of array:C274(aPCAsgName)>20)
			maxAsignaturas:="El máximo de asignaturas para el plan común son 20."+"\r"
		End if 
		
		If (Size of array:C274(aPEAsgName)>12)
			maxAsignaturas:=maxAsignaturas+"El máximo de asignaturas para el plan electivo son 12."
		End if 
		
	: (tipoDocumento="Oficio")
		  //maximo son 20 asignaturas del plan comun y 24 electivas
		
		If (Size of array:C274(aPCAsgName)>20)
			maxAsignaturas:="El máximo de asignaturas para el plan común son 20."+"\r"
		End if 
		
		If (Size of array:C274(aPEAsgName)>24)
			maxAsignaturas:=maxAsignaturas+"El máximo de asignaturas para el plan electivo son 24."+"\r"
		End if 
End case 

If (maxAsignaturas#"")
	maxAsignaturas:=maxAsignaturas+"Faltan asignaturas por imprimir."
End if 



