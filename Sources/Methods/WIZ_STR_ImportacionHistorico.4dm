//%attributes = {}
  //WIZ_STR_ImportacionHistorico


If (USR_IsGroupMember_by_GrpID (-15001))
	ARRAY TEXT:C222($aProblemas;0)
	ARRAY TEXT:C222(aIdentificadores;0)
	ARRAY POINTER:C280(aIDFieldPointers;4)
	COPY ARRAY:C226(<>at_IDNacional_Names;aIdentificadores)
	ARRAY TEXT:C222(aIdentificadores;4)
	aIdentificadores{4}:="Código interno"
	aIDFieldPointers{1}:=->[Alumnos:2]RUT:5
	aIDFieldPointers{2}:=->[Alumnos:2]IDNacional_2:71
	aIDFieldPointers{3}:=->[Alumnos:2]IDNacional_3:70
	aIDFieldPointers{4}:=->[Alumnos:2]Codigo_interno:6
	Case of 
		: (<>vtXS_CountryCode="cl")
			aIdentificadores:=1
		: (<>vtXS_CountryCode="co")
			aIdentificadores:=4
	End case 
	
	Case of 
		: (SYS_IsWindows )
			USE CHARACTER SET:C205("windows-1252";1)
			USE CHARACTER SET:C205("windows-1252";0)
		: (SYS_IsMacintosh )
			USE CHARACTER SET:C205("MacRoman";1)
			USE CHARACTER SET:C205("MacRoman";0)
	End case 
	
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_ImportHistorico";-1;4;__ ("Asistentes"))
	DIALOG:C40([xxSTR_Constants:1];"STR_ImportHistorico")
	CLOSE WINDOW:C154
	
	$keyFieldPointer:=aIDFieldPointers{aIdentificadores}
	$nivel:=0
	If (ok=1)
		If (r1=1)
			$filePlatForm:="Mac"
		Else 
			$filePlatForm:="Win"
		End if 
		
		If ($filePlatForm#"")
			If ($filePlatForm="Win")
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
		Else 
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
		End if 
		
		READ WRITE:C146(*)
		$ref:=Append document:C265(vt_g1)
		SEND PACKET:C103($ref;"\r")
		CLOSE DOCUMENT:C267($ref)
		$size:=SYS_GetFileSize (document)
		
		$ref:=Open document:C264(vt_g1;Read mode:K24:5)
		
		$curso:=""
		$nivel:=0
		
		If (OK=1)
			$prevRUT:=""
			$prevYear:=0
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando notas de años anteriores... "))
			RECEIVE PACKET:C104($ref;$data;"\r")
			$length:=0
			While (OK=1)
				
				
				If (OK=1)  //solo para poder contraer y facilitar la lectura de bloques
					  //If ($filePlatForm="Win")
					  //$data:=Win to Mac($data)
					  //End if  ahora es con use char set
					$length:=$length+Length:C16($data)+1
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;__ ("Importando notas de años anteriores... "))
					ARRAY TEXT:C222(aText;0)
					AT_Text2Array (->aText;$data+"\t";"\t")
					ARRAY TEXT:C222(aText;31)
					
					aText{1}:=ST_GetCleanString (aText{1})
					If (Num:C11(aText{1})#0)
						$year:=Num:C11(ST_GetCleanString (aText{1}))
					End if 
					aText{2}:=ST_GetCleanString (aText{2})
					If (aText{2}#"")
						$curso:=ST_GetCleanString (aText{2})
					End if 
					
					$nivel:=Num:C11(aText{3})
					
					aText{4}:=ST_GetCleanString (Replace string:C233(Replace string:C233(aText{4};".";"");"-";""))
					If (aText{4}#"")
						$rut:=Replace string:C233(Replace string:C233(aText{4};".";"");"-";"")
					End if 
					$Name:=ST_GetCleanString (aText{5})
					$asig:=ST_GetCleanString (aText{6})
					$nota:=""
					aText{7}:=ST_GetCleanString (aText{7})
					$nota:=aText{7}
					$nota:=Replace string:C233($nota;".";<>tXS_RS_DecimalSeparator)
					$nota:=Replace string:C233($nota;",";<>tXS_RS_DecimalSeparator)
					
					$sitFinal:=""
					$prevSchool:=""
					$asist:=0
					aText{8}:=ST_GetCleanString (aText{8})
					If (Num:C11(aText{8})>0)
						$asist:=Num:C11(aText{8})
					End if 
					aText{9}:=ST_GetCleanString (aText{9})
					If (aText{9}#"")
						$sitfinal:=aText{9}
					End if 
					aText{10}:=ST_GetCleanString (aText{10})
					If (aText{10}#"")
						$prevSchool:=aText{10}
					Else 
						If (<>vtXS_CountryCode="ar")
							$prevSchool:="EN ESTE ESTABLECIMIENTO"
						End if 
					End if 
					aText{11}:=ST_GetCleanString (aText{11})
					If (aText{11}#"")
						$prevSchool_City:=aText{11}
					End if 
					aText{12}:=ST_GetCleanString (aText{12})
					If (aText{12}#"")
						$prevSchool_PlanEstudio:=aText{12}
					End if 
					aText{13}:=ST_GetCleanString (aText{13})
					If (aText{13}#"")
						$prevSchool_EvalPromo:=aText{13}
					End if 
					aText{14}:=ST_GetCleanString (aText{14})
					If (aText{14}#"")
						$sector:=aText{14}
					Else 
						$sector:=""
					End if 
					aText{15}:=ST_GetCleanString (aText{15})
					If (aText{15}#"")
						$grupoEstadistico:=aText{15}
					Else 
						$grupoEstadistico:=""
					End if 
					aText{16}:=ST_GetCleanString (aText{16})
					If (aText{16}#"")
						$horasSemanales:=Num:C11(aText{16})
					Else 
						$horasSemanales:=0
					End if 
					
					aText{17}:=ST_GetCleanString (aText{17})
					If (aText{17}#"")
						$horasAnuales:=Num:C11(aText{17})
					Else 
						$horasAnuales:=0
					End if 
					
					aText{18}:=ST_GetCleanString (aText{18})
					If (aText{18}#"")  //formato dd-mm-aaaa
						$fechaAprobacion:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(aText{18};1;2));Num:C11(Substring:C12(aText{18};4;2));Num:C11(Substring:C12(aText{18};7;4)))
					Else 
						$fechaAprobacion:=!00-00-00!
					End if 
					
					aText{19}:=ST_GetCleanString (aText{19})
					If (aText{19}#"")
						$condicionAprob:=ST_Uppercase (aText{19})
					Else 
						If (<>vtXS_CountryCode="ar")
							$condicionAprob:="REGULAR"
						Else 
							$condicionAprob:=""
						End if 
					End if 
					
					Case of 
						: (aText{20}="")
							$aprobada:=True:C214
						: (aText{20}="1")
							$aprobada:=True:C214
						: (aText{20}="0")
							$aprobada:=False:C215
					End case 
					
					If (aText{21}#"")
						$recuperacion1:=aText{21}
					Else 
						$recuperacion1:=""
					End if 
					
					If (aText{22}#"")
						$recuperacion2:=aText{22}
					Else 
						$recuperacion2:=""
					End if 
					
					If (aText{23}#"")
						$recuperacion3:=aText{23}
					Else 
						$recuperacion3:=""
					End if 
					
					If (aText{24}#"")
						$idEstiloOrigen:=Num:C11(aText{24})
					Else 
						Case of 
							: (<>vtXS_CountryCode="cl")
								Case of 
									: (($nota="I") | ($nota="S") | ($nota="B") | ($nota="MB"))
										$idEstiloOrigen:=-5
									: (Num:C11($nota)>10)
										$idEstiloOrigen:=-4
									Else 
										$idEstiloOrigen:=-5
								End case 
							Else 
								$idEstiloOrigen:=0
						End case 
					End if 
					
					If (aText{25}#"")
						$idEstiloAlmacenamiento:=Num:C11(aText{25})
					Else 
						Case of 
							: (<>vtXS_CountryCode="cl")
								$idEstiloAlmacenamiento:=-5
							Else 
								$idEstiloAlmacenamiento:=0
						End case 
					End if 
					
					If (aText{26}#"")
						Case of 
							: (aText{26}="N")
								$modoLiteral:=Notas
							: (aText{26}="P")
								$modoLiteral:=Puntos
							: (aText{26}="%")
								$modoLiteral:=Porcentaje
							: (aText{26}="S")
								$modoLiteral:=Simbolos
						End case 
					Else 
						Case of 
							: (<>vtXS_CountryCode="cl")
								Case of 
									: ($asig="Religion@")
										$modoLiteral:=Simbolos
									: ((Num:C11($nota)=0) & ($nota#""))
										$modoLiteral:=Simbolos
									Else 
										$modoLiteral:=Notas
								End case 
						End case 
					End if 
					
					Case of 
						: (aText{27}="")
							$asignaturaOficial:=True:C214
						: (aText{27}="1")
							$asignaturaOficial:=True:C214
						: (aText{27}="0")
							$asignaturaOficial:=False:C215
					End case 
					
					Case of 
						: (aText{28}="")
							If ((<>vtXS_CountryCode="cl") & ($asig#"Religion@"))
								$asignaturaPromediable:=True:C214
							Else 
								$asignaturaPromediable:=False:C215
							End if 
						: (aText{28}="1")
							$asignaturaPromediable:=True:C214
						: (aText{28}="0")
							$asignaturaPromediable:=False:C215
					End case 
					
					Case of 
						: (aText{29}="")
							$asignaturaElectiva:=False:C215
						: (aText{29}="1")
							$asignaturaElectiva:=True:C214
						: (aText{29}="0")
							$asignaturaElectiva:=False:C215
					End case 
					
					Case of 
						: (aText{30}="")
							If ((<>vtXS_CountryCode="cl") & ($asig="Religion@"))
								$asignaturaOptativa:=True:C214
							Else 
								$asignaturaOptativa:=False:C215
							End if 
						: (aText{30}="1")
							$asignaturaOptativa:=True:C214
						: (aText{30}="0")
							$asignaturaOptativa:=False:C215
					End case 
					
					If (aText{31}#"")
						$profesor:=aText{31}
					Else 
						$profesor:=""
					End if 
					
					If ((<>vtXS_CountryCode="cl") & ($nota="EX") & (($asig#"Religión@") | ($asignaturaOptativa)))
						$nota:="X"
					End if 
					
				End if 
				
				
				
				
				$idEstiloOrigen:=KRL_GetNumericFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$idEstiloOrigen;->[xxSTR_EstilosEvaluacion:44]ID:1)
				$idEstiloAlmacenamiento:=KRL_GetNumericFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$idEstiloAlmacenamiento;->[xxSTR_EstilosEvaluacion:44]ID:1)
				
				
				$go:=True:C214
				If ($idEstiloOrigen=0)
					APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+aText{5}+": Estilo de evaluación de origen no definido.")
					$go:=False:C215
				End if 
				
				If ($idEstiloAlmacenamiento=0)
					APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+aText{5}+": Estilo de evaluación de almacenamiento no definido.")
					$go:=False:C215
				End if 
				
				
				If ($go)
					If ((($rut#$prevRUT) & ($rut#"")) | (($prevYear#$year) & ($year>0)))
						$order:=0
						$go:=False:C215
						$prevRut:=$rut
						$prevYear:=$year
						
						Case of 
							: (($curso="") & ($nivel#0))
								$curso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Abreviatura:19)
								
							: (($curso#"") & ($nivel=0))
								$abrev:=Substring:C12($curso;1;Position:C15("-";$curso)-1)
								$nivel:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Abreviatura:19;->$abrev;->[xxSTR_Niveles:6]NoNivel:5)
								
						End case 
						
						If (($curso#"") | ($nivel#0))
							
							READ WRITE:C146([xxSTR_DatosDeCierre:24])
							QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=$year)
							If (Records in selection:C76([xxSTR_DatosDeCierre:24])=0)
								If (($year>1950) & ($year<=Year of:C25(Current date:C33(*))))  //RCH cuando hay errores de importación se pueden crear, por ejemplo, años con los rut de los alumnos... Esto es para intentar minimizar la posibilidad de creación de registros erróneos...
									CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
									[xxSTR_DatosDeCierre:24]Year:1:=$year
								End if 
							End if 
							If ([xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5="")
								[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=String:C10($year)
							End if 
							SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
							KRL_ReloadAsReadOnly (->[xxSTR_DatosDeCierre:24])
							
							QUERY:C277([Alumnos:2];$keyFieldPointer->=$rut)
							If (Records in selection:C76([Alumnos:2])=1)
								
								Case of 
									: (($nivel<=Nivel_AdmisionDirecta) | ($nivel>=Nivel_Egresados))
										APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+String:C10($nivel)+"\t"+"(nivel académido incorrecto)")
										$rut:=""
										
									: (($sitFinal#"P") & ($sitFinal#"R"))  //situación final incorrecta  
										$rut:=""
										APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+$sitFinal+"\t"+"(situación final incorrecta o indefinida)")
										
									: ($nota="")  //nota final incorrecta 
										$rut:=""
										APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+aText{5}+"\t"+$nota+"\t"+"(promedio final incorrecto o indefinido)")
										
									: ($asist=0)  //porcentaje de asistencia incorrecto
										$rut:=""
										APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+aText{5}+"\t"+"(porcentaje de asistencia no definido)")
										
									Else 
										$idStudent:=[Alumnos:2]numero:1
										QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=$idStudent;*)
										QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=$year;*)
										QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Curso:3=$curso;*)
										QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Nivel:11=$nivel)
										If (Records in selection:C76([Alumnos_Historico:25])=0)
											CREATE RECORD:C68([Alumnos_Historico:25])
											[Alumnos_Historico:25]Alumno_Numero:1:=$idStudent
											[Alumnos_Historico:25]Año:2:=$year
										End if 
										[Alumnos_Historico:25]Curso:3:=$curso
										[Alumnos_Historico:25]Nivel:11:=$nivel
										[Alumnos_Historico:25]Situacion_final:19:=$sitFinal
										If ($prevSchool="")
											[Alumnos_Historico:25]Colegio_anterior:20:=<>gCustom
										Else 
											[Alumnos_Historico:25]Colegio_anterior:20:=$prevSchool
											[Alumnos_Historico:25]Ciudad_ColegioAnterior:25:=$prevSchool_City
											[Alumnos_Historico:25]DPE_ColegioAnterior:26:=$prevSchool_PlanEstudio
											[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=$prevSchool_EvalPromo
										End if 
										SAVE RECORD:C53([Alumnos_Historico:25])
										
										
										$key:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Historico:25]Año:2)+"."+String:C10([Alumnos_Historico:25]Nivel:11)+"."+String:C10([Alumnos_Historico:25]Alumno_Numero:1)
										AL_CreaRegistrosSintesis ([Alumnos_Historico:25]Alumno_Numero:1;[Alumnos_Historico:25]Año:2;[Alumnos_Historico:25]Nivel:11;<>ginstitucion)
										$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
										
										[Alumnos_SintesisAnual:210]SituacionFinal:8:=$sitFinal
										[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=$asist
										
										If ($sitFinal="P")
											[Alumnos_SintesisAnual:210]Promovido:91:=True:C214
										Else 
											If ($sitFinal#"R")
												[Alumnos_SintesisAnual:210]Promovido:91:=False:C215
											End if 
										End if 
										
										EVS_ReadStyleData ($idEstiloOrigen)
										$real:=NTA_StringValue2Percent ($nota;$idEstiloOrigen;$modoLiteral)
										
										[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20:=$real
										[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=EV2_Real_a_Literal ($real;$modoLiteral;vlNTA_DecimalesNF)
										[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21:=EV2_Real_a_Nota ($real;0;iGradesDecNF)
										[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22:=EV2_Real_a_Puntos ($real;0;iPointsDecNF)
										[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23:=EV2_Real_a_Simbolo ($real)
										[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21
										[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22
										[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23
										[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
										[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20
										EVS_ReadStyleData ($idEstiloOrigen)
										
										Case of 
											: (<>vs_AppDecimalSeparator=",")
												[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;".";<>vs_AppDecimalSeparator)
											: (<>vs_AppDecimalSeparator=".")
												[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;",";<>vs_AppDecimalSeparator)
										End case 
										Case of 
											: (<>vs_AppDecimalSeparator=",")
												[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;".";<>vs_AppDecimalSeparator)
											: (<>vs_AppDecimalSeparator=".")
												[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;",";<>vs_AppDecimalSeparator)
										End case 
										
										SAVE RECORD:C53([Alumnos_SintesisAnual:210])
										
										$go:=True:C214
								End case 
							Else 
								$prevRut:=""
								$rut:=""
								$go:=False:C215
								APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+aText{5}+":  El registro no existe en la base de datos")
							End if 
						Else 
							$rut:=""
							APPEND TO ARRAY:C911($aProblemas;aText{4}+"\t"+aText{5}+"\t"+"(no se indicó ni curso ni nivel)")
						End if 
					End if 
					
					If (($asig#"") & ($rut#""))
						QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Asignatura:2=$asig;*)
						QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5=$year;*)
						QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Curso:14=[Alumnos_Historico:25]Curso:3;*)
						QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Nivel:4=[Alumnos_Historico:25]Nivel:11)
						
						  //si la asignatura histórica no existe la creamos
						If (Records in selection:C76([Asignaturas_Historico:84])=0)
							CREATE RECORD:C68([Asignaturas_Historico:84])
							QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=$asig)
							[Asignaturas_Historico:84]Order:11:=[xxSTR_Materias:20]Orden interno:9
							[Asignaturas_Historico:84]Materia_UUID:45:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
							[Asignaturas_Historico:84]ID_RegistroHistorico:1:=SQ_SeqNumber (->[Asignaturas_Historico:84]ID_RegistroHistorico:1)
							[Asignaturas_Historico:84]Asignatura:2:=$asig
							[Asignaturas_Historico:84]Nombre_interno:3:=$asig
							[Asignaturas_Historico:84]Curso:14:=[Alumnos_Historico:25]Curso:3
							[Asignaturas_Historico:84]Nivel:4:=[Alumnos_Historico:25]Nivel:11
							[Asignaturas_Historico:84]Nivel_Nombre:41:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas_Historico:84]Nivel:4;->[xxSTR_Niveles:6]Nivel:1)
							[Asignaturas_Historico:84]Año:5:=[Alumnos_Historico:25]Año:2
							[Asignaturas_Historico:84]Promediable:6:=$asignaturaPromediable
							[Asignaturas_Historico:84]Optativa:24:=$asignaturaOptativa
							[Asignaturas_Historico:84]Incluida_En_Actas:7:=$asignaturaOficial
							[Asignaturas_Historico:84]Electiva:10:=$asignaturaElectiva
							[Asignaturas_Historico:84]Profesor_Nombre:13:=$profesor
							[Asignaturas_Historico:84]Profesor_Numero:12:=-1
						End if 
						[Asignaturas_Historico:84]Order:11:=0
						[Asignaturas_Historico:84]OrdenGeneral:42:=""
						[Asignaturas_Historico:84]Sector:38:=$sector
						[Asignaturas_Historico:84]Grupo_Estadistico:37:=$grupoEstadistico
						[Asignaturas_Historico:84]Horas_Semanales:35:=$horasSemanales
						[Asignaturas_Historico:84]Horas_Efectivas:36:=$horasAnuales
						SAVE RECORD:C53([Asignaturas_Historico:84])
						
						$llaveHistoricoCalificaciones:=KRL_MakeStringAccesKey (-><>gInstitucion;->$year;->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$idStudent)
						$recNumCalificaciones:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504;->$llaveHistoricoCalificaciones;True:C214)
						
						If ($recNumCalificaciones<0)
							CREATE RECORD:C68([Alumnos_Calificaciones:208])
							[Alumnos_Calificaciones:208]ID_institucion:2:=<>gInstitucion
							[Alumnos_Calificaciones:208]Año:3:=$year
							[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493:=[Asignaturas_Historico:84]ID_RegistroHistorico:1
							[Alumnos_Calificaciones:208]ID_Alumno:6:=$idStudent
							[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas_Historico:84]Asignatura:2
							[Alumnos_Calificaciones:208]NIvel_Numero:4:=[Asignaturas_Historico:84]Nivel:4
							  // Modificado por: Saúl Ponce (02-02-2017) - Ticket 171003, Para que al buscar registros de [Alumnos_Calificaciones] se puedan encontrar los registros con el ID_RegistroHistorico
							[Alumnos_Calificaciones:208]ID_Asignatura:5:=-Abs:C99([Asignaturas_Historico:84]ID_RegistroHistorico:1)
							SAVE RECORD:C53([Alumnos_Calificaciones:208])
						End if 
						
						$recNumComplemento:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
						If ($recNumComplemento<0)
							CREATE RECORD:C68([Alumnos_ComplementoEvaluacion:209])
							[Alumnos_ComplementoEvaluacion:209]ID_Institucion:2:=<>gInstitucion
							[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=[Asignaturas_Historico:84]ID_RegistroHistorico:1
							[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=$idStudent
							[Alumnos_ComplementoEvaluacion:209]Año:3:=$year
							[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4:=[Asignaturas_Historico:84]Nivel:4
						End if 
						[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50:=$prevSchool
						[Alumnos_ComplementoEvaluacion:209]Historico_FechaAprobacionDif:49:=$fechaAprobacion
						[Alumnos_ComplementoEvaluacion:209]Historico_CondicionAprobacion:51:=$condicionAprob
						[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52:=$recuperacion1
						[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53:=$recuperación2
						[Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54:=$recuperacion3
						
						  // Modificado por: Saúl Ponce (02-02-2017) - Ticket 171003, Para guardar los valores asignados en alumnos complemento evaluación
						SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						
						EVS_ReadStyleData ($idEstiloOrigen)
						If ($asig="Religion@") & ($nota="N/O")
							[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
							[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="N/O"
						Else 
							[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=NTA_StringValue2Percent ($nota;$idEstiloOrigen;$modoLiteral)
							[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$modoLiteral;vlNTA_DecimalesNO)
						End if 
						  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Real:=NTA_StringValue2Percent ($nota;$idEstiloOrigen;$modoLiteral)
						  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Literal:=EV2_Real_a_Literal ([Alumnos_Calificaciones]EvaluacionFinalOficial_Real;$modoLiteral;vlNTA_DecimalesNO)
						If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="X")
							[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="EX"
						End if 
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;0;iGradesDecNO)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;0;iPointsDecNO)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
						
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
						[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
						[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33
						[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34
						[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
						
						[Alumnos_Calificaciones:208]Reprobada:9:=Not:C34($aprobada)  //MONO 220618 Ticket 207652
						  //Case of 
						  //: (<>vs_AppDecimalSeparator=",")
						  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=Replace string([Alumnos_Calificaciones]EvaluacionFinal_Literal;".";<>vs_AppDecimalSeparator)
						  //: (<>vs_AppDecimalSeparator=".")
						  //[Alumnos_Calificaciones]EvaluacionFinal_Literal:=Replace string([Alumnos_Calificaciones]EvaluacionFinal_Literal;",";<>vs_AppDecimalSeparator)
						  //End case 
						  //Case of 
						  //: (<>vs_AppDecimalSeparator=",")
						  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Literal:=Replace string([Alumnos_Calificaciones]EvaluacionFinalOficial_Literal;".";<>vs_AppDecimalSeparator)
						  //: (<>vs_AppDecimalSeparator=".")
						  //[Alumnos_Calificaciones]EvaluacionFinalOficial_Literal:=Replace string([Alumnos_Calificaciones]EvaluacionFinalOficial_Literal;",";<>vs_AppDecimalSeparator)
						  //End case 
						
						SAVE RECORD:C53([Alumnos_Calificaciones:208])
						
					End if 
				End if 
				
				RECEIVE PACKET:C104($ref;$data;"\r")
				
				
			End while 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			CLOSE DOCUMENT:C267($ref)
			
			dbu_OrdenAsignaturasHistoricas 
			
			
			If (<>vtXS_CountryCode="cl")
				$pId:=IT_UThermometer (1;0;__ ("Actualizando promedios para postulación a universidades..."))
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=12)
				SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
				For ($i;1;Size of array:C274($aRecNums))
					READ WRITE:C146([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
					[Alumnos:2]Chile_PromedioEMedia:73:=AL_PromedioUChile_cl 
					SAVE RECORD:C53([Alumnos:2])
				End for 
				$pId:=IT_UThermometer (-2;$pId)
			End if 
			
			If (Size of array:C274($aProblemas)>0)
				CD_Dlog (0;__ ("Se detectaron problemas durante la importación.\rConsulte el documento Import_log.txt"))
				$ref:=Create document:C266("Import_log";"TEXT")
				If ($ref#?00:00:00?)
					$document:=document
					For ($i;1;Size of array:C274($aProblemas))
						IO_SendPacket ($ref;$aProblemas{$i}+"\r")
					End for 
					CLOSE DOCUMENT:C267($ref)
					
				End if 
			End if 
		End if 
		USE CHARACTER SET:C205(*;1)
	End if 
Else 
	CD_Dlog (0;__ ("Sólo los miembros del grupo Administración están autorizados a ejecutar esta acción."))
End if 



USE CHARACTER SET:C205(*;1)
USE CHARACTER SET:C205(*;0)


  // "20/04/2001 AS" se crea historico de niveles cuando no existen.

ARRAY LONGINT:C221($al_Nonivel;0)
ARRAY LONGINT:C221($al_año;0)
C_LONGINT:C283($i;$j)

KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
KRL_UnloadReadOnly (->[Alumnos_Historico:25])
KRL_UnloadReadOnly (->[xxSTR_Niveles:6])

ALL RECORDS:C47([Alumnos_Historico:25])

AT_DistinctsFieldValues (->[Alumnos_Historico:25]Año:2;->$al_año)
AT_DistinctsFieldValues (->[Alumnos_Historico:25]Nivel:11;->$al_Nonivel)
For ($i;1;Size of array:C274($al_Nonivel))
	
	For ($j;1;Size of array:C274($al_año))
		
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2=$al_año{$j};*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]NumeroNivel:3=$al_Nonivel{$i})
		If (($al_año{$j}>1950) & ($al_año{$j}<=Year of:C25(Current date:C33(*))))  //20120516 ASM Para evitar que se creen historicos de niveles con años mal ingresados.
			If (Records in selection:C76([xxSTR_HistoricoNiveles:191])=0)
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$al_Nonivel{$i})
				CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
				[xxSTR_HistoricoNiveles:191]Año:2:=$al_año{$j}
				[xxSTR_HistoricoNiveles:191]NumeroNivel:3:=[xxSTR_Niveles:6]NoNivel:5
				[xxSTR_HistoricoNiveles:191]NombreDeCiclo:14:=[xxSTR_Niveles:6]Sección:9
				[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Interna:12:=[xxSTR_Niveles:6]Abreviatura:19
				[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13:=[xxSTR_Niveles:6]Abreviatura_Oficial:35
				[xxSTR_HistoricoNiveles:191]DirectorResponsable:15:=[xxSTR_Niveles:6]Director:13
				[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=[xxSTR_Niveles:6]EvStyle_oficial:23
				[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=[xxSTR_Niveles:6]EvStyle_oficial:23
				[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
				[xxSTR_HistoricoNiveles:191]NombreInterno:5:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
				[xxSTR_HistoricoNiveles:191]NombreOficial:6:=[xxSTR_Niveles:6]Nivel:1
				[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=2
				  //20121031 ASM se agrega nuevo campo
				[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=[xxSTR_Niveles:6]AttendanceMode:3
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			End if 
		End if 
	End for 
End for 



KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
KRL_UnloadReadOnly (->[Alumnos_Historico:25])
KRL_UnloadReadOnly (->[Asignaturas_Historico:84])
KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
KRL_UnloadReadOnly (->[Alumnos_Historico:25])
KRL_UnloadReadOnly (->[xxSTR_Niveles:6])







