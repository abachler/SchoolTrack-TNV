//%attributes = {}
  // AL_Concent1()
  // Por: Alberto Bachler K.: 28-02-14, 14:06:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_asignatura;$l_AsignaturasPlanComun;$l_IdxPlan;$l_numeroElectivas)
C_POINTER:C301($y_nota)
C_TEXT:C284($t_llaveRegistro;$t_nota)

ARRAY BOOLEAN:C223($ab_esElectiva;0)
ARRAY BOOLEAN:C223($ab_esOptativa;0)
ARRAY BOOLEAN:C223($ab_incluidaEnActas;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_notaLiteral;0)



Case of 
	: ([Alumnos:2]nivel_numero:29<9)
		iYear1:=0
	: ([Alumnos:2]nivel_numero:29=9)
		iYear1:=<>gYear
		  //ACTAS_LeeConfiguracion ([Alumnos]Nivel_Número;[Alumnos]Curso;iYear1)
		
	Else 
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]NumeroNivel:6=9;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		iYear1:=[Alumnos_SintesisAnual:210]Año:2
		
		  //ACTAS_LeeConfiguracion ([Alumnos_SintesisAnual]NumeroNivel;[Alumnos_SintesisAnual]Curso;[Alumnos_SintesisAnual]Año)
End case 

$l_AsignaturasPlanComun:=20
Case of 
	: (tipoDocumento="Carta")
		$l_numeroElectivas:=12
	: (tipoDocumento="Oficio")
		$l_numeroElectivas:=24
End case 


If (iYear1>0)
	  //TICKET 185219
	  //se pierde el alumno seleccionado cuando lee config de ACTA
	  //agrego KRL_GOTORECORD
	
	C_LONGINT:C283($l_recnum)
	$l_recnum:=Record number:C243([Alumnos:2])
	
	$t_llaveRegistro:=String:C10(<>ginstitucion)+"."+String:C10(iYear1)+".9."+String:C10([Alumnos:2]numero:1)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro)
	  // 20170925 MOD Ticket N° 188657. Patricio Aliaga
	vAsist1:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
	vFinal1:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
	ACTAS_LeeConfiguracion ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7;[Alumnos_SintesisAnual:210]Año:2)
	
	
	KRL_GotoRecord (->[Alumnos:2];$l_recnum)
	
	Case of 
		: (vi_DecAsistencia=0)
			vAsist1:=Round:C94(vAsist1;0)
		: (vi_DecAsistencia=1)
			vAsist1:=Round:C94(vAsist1;1)
		: (vi_DecAsistencia=2)
			vAsist1:=Round:C94(vAsist1;2)
	End case 
	
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos_SintesisAnual:210]NumeroNivel:6;iYear1)
	
	If ([Alumnos_Historico:25]Colegio_anterior:20#"")
		sSchool1:=[Alumnos_Historico:25]Colegio_anterior:20
	Else 
		sSchool1:=sAltSchool1
	End if 
	
	If ([Alumnos_Historico:25]Ciudad_ColegioAnterior:25#"")
		sCity1:=[Alumnos_Historico:25]Ciudad_ColegioAnterior:25
	Else 
		sCity1:=sAltCity1
	End if 
	
	If ([Alumnos_Historico:25]DPE_ColegioAnterior:26#"")
		sCoop1:=[Alumnos_Historico:25]DPE_ColegioAnterior:26
	Else 
		sCoop1:=sAltCoop1
	End if 
	
	If ([Alumnos_Historico:25]DEyP_ColegioAnterior:27#"")
		sPLan1:=[Alumnos_Historico:25]DEyP_ColegioAnterior:27
	Else 
		sPLan1:=sAltPlan1
	End if 
	
	
	If (iYear1<<>gYear)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_notaLiteral;[Asignaturas_Historico:84]Asignatura:2;$at_asignaturas;[Asignaturas_Historico:84]Electiva:10;$ab_esElectiva;[Asignaturas_Historico:84]Incluida_En_Actas:7;$ab_incluidaEnActas;[Asignaturas_Historico:84]Optativa:24;$ab_esOptativa)
		
	Else 
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_notaLiteral;[Asignaturas:18]Asignatura:3;$at_asignaturas;[Asignaturas:18]Electiva:11;$ab_esElectiva;[Asignaturas:18]Incluida_en_Actas:44;$ab_incluidaEnActas;[Asignaturas:18]Es_Optativa:70;$ab_esOptativa)
		
	End if 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	SORT ARRAY:C229($at_asignaturas;$ab_esElectiva;$at_notaLiteral;$ab_incluidaEnActas;$ab_esOptativa;>)
	
	
	For ($i_asignatura;1;Size of array:C274($at_asignaturas))
		If ($ab_incluidaEnActas{$i_asignatura})
			$at_notaLiteral{$i_asignatura}:=Replace string:C233($at_notaLiteral{$i_asignatura};".";<>tXS_RS_DecimalSeparator)
			$at_notaLiteral{$i_asignatura}:=Replace string:C233($at_notaLiteral{$i_asignatura};",";<>tXS_RS_DecimalSeparator)
			
			Case of 
				: ($at_asignaturas{$i_asignatura}="Religión@")
					If (Num:C11($at_notaLiteral{$i_asignatura})>0)
						$t_nota:=NTA_Nota_a_Concepto (Num:C11($at_notaLiteral{$i_asignatura}))
					Else 
						$t_nota:=$at_notaLiteral{$i_asignatura}
					End if 
				: (Num:C11($at_notaLiteral{$i_asignatura})>10)
					$t_nota:=Replace string:C233($at_notaLiteral{$i_asignatura}[[1]]+<>tXS_RS_DecimalSeparator+$at_notaLiteral{$i_asignatura}[[2]];<>tXS_RS_DecimalSeparator+<>tXS_RS_DecimalSeparator;<>tXS_RS_DecimalSeparator)
				: (Num:C11($at_notaLiteral{$i_asignatura})>0)
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
						vOpt1:=$t_nota
					: (($at_asignaturas{$i_asignatura}="Religión@") | ($ab_esOptativa{$i_asignatura}))
						vRel1:=$t_nota
						If (($at_asignaturas{$i_asignatura}#"Religión@") & (Position:C15($at_asignaturas{$i_asignatura};vt_NombreOptativa)=0))
							vt_NombreOptativa:=vt_NombreOptativa+" o "+$at_asignaturas{$i_asignatura}
						End if 
					Else 
						If ($ab_esElectiva{$i_asignatura})
							$l_IdxPlan:=Find in array:C230(aPEAsgName;$at_asignaturas{$i_asignatura})
							If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_numeroElectivas))
								$y_nota:=Get pointer:C304("vCalPE1_"+String:C10($l_IdxPlan))
								$y_nota->:=$t_nota
							Else 
								$l_IdxPlan:=Find in array:C230(aPCAsgName;$at_asignaturas{$i_asignatura})
								If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
									$y_nota:=Get pointer:C304("vCalPC1_"+String:C10($l_IdxPlan))
									$y_nota->:=$t_nota
								Else 
									vErrors:=vErrors+$at_asignaturas{$i_asignatura}+", "
								End if 
							End if 
						Else 
							$l_IdxPlan:=Find in array:C230(aPCAsgName;$at_asignaturas{$i_asignatura})
							If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_AsignaturasPlanComun))
								$y_nota:=Get pointer:C304("vCalPC1_"+String:C10($l_IdxPlan))
								$y_nota->:=$t_nota
							Else 
								$l_IdxPlan:=Find in array:C230(aPEAsgName;$at_asignaturas{$i_asignatura})
								If (($l_IdxPlan>0) & ($l_IdxPlan<=$l_numeroElectivas))
									$y_nota:=Get pointer:C304("vCalPE1_"+String:C10($l_IdxPlan))
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
Else 
	vRel1:=""
End if 