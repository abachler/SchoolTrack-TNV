//%attributes = {}
  //MINEDUC_MatriculaInicial

C_TEXT:C284($folder;$file2Process;$1;$2)
C_BLOB:C604(xBlob)
$file2Process:="All"
Case of 
	: (Count parameters:C259=1)
		$file2Process:=$1
	: (Count parameters:C259=2)
		$file2Process:=$1
		$folder:=$2
End case 
If ($folder="")
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 

$fechaLimite:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
$año:=String:C10(<>gyear)
$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))

Case of 
	: ($file2Process="All")
		MINEDUC_MatriculaInicial ("21";$folder)
		MINEDUC_MatriculaInicial ("22";$folder)
		MINEDUC_MatriculaInicial ("23";$folder)
		MINEDUC_MatriculaInicial ("24";$folder)
		MINEDUC_MatriculaInicial ("25";$folder)
		MINEDUC_MatriculaInicial ("26";$folder)
		
	: ($file2Process="21")  //Datos del establecimiento
		ALL RECORDS:C47([Colegio:31])
		FIRST RECORD:C50([Colegio:31])
		  //preparando datos  
		$establecimiento:=[Colegio:31]Nombre_Colegio:1
		$Dirección:=[Colegio:31]Dirección:3
		$Teléfono:=[Colegio:31]Telefono1:7
		$Celular:=[Colegio:31]Celular:17
		$email:=[Colegio:31]eMail:25
		$Localidad:=[Colegio:31]Comuna:4
		$noResReconocimiento:=[Colegio:31]MINEDUC_NoResolReconocimiento:12
		$fechaReconocimiento:=String:C10([Colegio:31]MINEDUC_FechaReconocimiento:15;7)
		$runDirectorCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233([Colegio:31]Director_RUN:28;".";"");"-";""))
		$runDirector:=Substring:C12($runDirectorCompleto;1;Length:C16($runDirectorCompleto)-1)
		$dvDirector:=Substring:C12($runDirectorCompleto;Length:C16($runDirectorCompleto))
		$aPatDirector:=[Colegio:31]Director_ApellidoPaterno:18
		$aMatDirector:=[Colegio:31]Director_ApellidoMaterno:19
		$nombresDirector:=[Colegio:31]Director_Nombres:20
		  //creando archivo
		$fileName:=$folder+"m"+$rolBD+"_21.txt"
		$fileRef:=Create document:C266($fileName;"TEXT")
		$record:="21"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$establecimiento+"\t"+$Dirección+"\t"+$Teléfono+"\t"+$Celular+"\t"+$email+"\t"+$Localidad+"\t"+$noResReconocimiento+"\t"+$fechaReconocimiento+"\t"+$runDirector+"\t"+$dvDirector+"\t"+$aPatDirector+"\t"+$aMatDirector+"\t"+$nombresDirector+"\r"
		SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
		CLOSE DOCUMENT:C267($fileref)
		
	: ($file2Process="22")  //Datos unidades educativas
		$fileName:=$folder+"m"+$rolBD+"_22.txt"
		$fileRef:=Create document:C266($fileName;"TEXT")
		$blobPointer:=->xBlob
		For ($i;1;Size of array:C274(al_DatosUnidadesEduc_Codes))
			ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;0)
			ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;29)
			al_DatosUnidadesEduc_Codes:=$i
			$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
			SET BLOB SIZE:C606($blobPointer->;0)
			BLOB_Variables2Blob ($blobPointer;0;->at_DatosUnidadesEduc_Values)
			$blob:=PREF_fGetBlob (0;$prefRecord;$blobPointer->)
			$blobPointer->:=$blob
			BLOB_Blob2Vars ($blobPointer;0;->at_DatosUnidadesEduc_Values)
			If (at_DatosUnidadesEduc_Values{1}=$rolBD)
				$text:="22"+"\t"+AT_array2text (->at_DatosUnidadesEduc_Values;"\t")+"\r"
				SEND PACKET:C103($fileRef;$text)
			End if 
		End for 
		CLOSE DOCUMENT:C267($fileRef)
		SET BLOB SIZE:C606($blobPointer->;0)
		
	: ($file2Process="23")  //Nomina de estudiantes en matrícula inicial
		  //creando archivo
		$fileName:=$folder+"m"+$rolBD+"_23.txt"
		$fileRef:=Create document:C266($fileName;"TEXT")
		  //proceso y envio de datos al archivo
		QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesOficiales)
		QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
		QUERY SELECTION:C341([Cursos:3]; & [Cursos:3]Numero_del_curso:6>0)
		KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
		QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Nómina de estudiantes en matrícula Inicial(")+$rolBD+__ ("_23.txt)"))
		While (Not:C34(End selection:C36([Alumnos:2])))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Nómina de estudiantes en matrícula Inicial(")+$rolBD+__ ("_23.txt)"))
			
			$indicadorExtranjero:="2"
			If (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilen@"))
				$indicadorExtranjero:="1"
				$run:=[Alumnos:2]NoPasaporte:87
				$DV:=""
			Else 
				$rut:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
				If (Num:C11(Substring:C12($rut;1;1))>0)
					$dv:=$rut[[Length:C16($rut)]]
					$run:=Substring:C12($rut;1;Length:C16($rut)-1)
				Else 
					$run:="ERR"
					$dv:="ERR"
				End if 
			End if 
			
			Case of 
				: ([Alumnos:2]Sexo:49="M")
					$sex:="1"
				: ([Alumnos:2]Sexo:49="F")
					$sex:="2"
				: ([Alumnos:2]Sexo:49="")
					$sex:="ERR"
			End case 
			If ([Alumnos:2]Fecha_de_nacimiento:7=!00-00-00!)
				$date:="ERR"
			Else 
				$date:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
			End if 
			
			$junaeb:="2"
			$chileSolidario:="2"
			If (_InfoReglamentariaAlumno ("Tiene Beneficio JUNAEB")="Si")
				$junaeb:="1"
			End if 
			If (_InfoReglamentariaAlumno ("Tiene Beneficio Chile Solidario")="Si")
				$chileSolidario:="1"
			End if 
			
			$record:="23"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$run+"\t"+$dv+"\t"+[Alumnos:2]Apellido_paterno:3+"\t"+[Alumnos:2]Apellido_materno:4+"\t"+[Alumnos:2]Nombres:2+"\t"+$sex+"\t"+$date+"\t"+[Alumnos:2]Codigo_Comuna:79+"\t"+$indicadorExtranjero+"\t"+$junaeb+"\t"+$chileSolidario+"\t"+"\r"
			SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
			NEXT RECORD:C51([Alumnos:2])
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		  //cierre del archivo
		CLOSE DOCUMENT:C267($fileref)
		
	: ($file2Process="24")  // Datos de los cursos
		  //creando archivo
		$fileName:=$folder+"m"+$rolBD+"_24.txt"
		$fileRef:=Create document:C266($fileName;"TEXT")
		  //proceso y envio de datos al archivo
		QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesOficiales)
		QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
		QUERY SELECTION:C341([Cursos:3]; & [Cursos:3]Numero_del_curso:6>0)
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Datos de los cursos (")+$rolBD+__ ("_24.txt)"))
		While (Not:C34(End selection:C36([Cursos:3])))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Datos de los cursos (")+$rolBD+__ ("_24.txt)"))
			$Tipo_de_enseñanza:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
			
			  // determinacion del nivel
			Case of 
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21=10)  // parvularia
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=160) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=163))  // basica comuna adultos o básica escuelas carceles
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21>=211) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=216))  // Deficiencia auditiva, mental, visual, alteraciones del lenguaje
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21=361)  // media HC Adultos Decreto 12
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=460) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=461))  // TP Comercial adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=560) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=561))  // TP Industrial adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=660) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=661))  // TP Técnica adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=760) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=761))  // TP Agrícola adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=860) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=861))  // TP Marítima adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				Else 
					Case of 
						: ([Cursos:3]Nivel_Numero:7=-2)
							$nivel:="4"
						: ([Cursos:3]Nivel_Numero:7=-1)
							$nivel:="5"
						: ([Cursos:3]Nivel_Numero:7>8)
							$nivel:=String:C10([Cursos:3]Nivel_Numero:7-8)
						Else 
							$nivel:=String:C10([Cursos:3]Nivel_Numero:7)
					End case 
			End case 
			
			$Letra:=[Cursos:3]Letra_Oficial_del_Curso:18
			$año:=String:C10(<>gYear)
			$Jornada:=String:C10([Cursos:3]Jornada:32)
			$Indicador_curso_combinado:=String:C10(0)
			
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
			QUERY:C277([Alumnos:2]; & [Alumnos:2]Sexo:49="F")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
			QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
			KRL_RelateSelection (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumna_embarazada:20=True:C214)
			$alumnasEmbarazadas:=String:C10(Records in selection:C76([Alumnos_FichaMedica:13]))
			
			
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
			QUERY:C277([Alumnos:2]; & [Alumnos:2]Sexo:49="M")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
			QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
			$Número_de_alumnos_hombres:=String:C10(Records in selection:C76([Alumnos:2]))
			
			
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
			QUERY:C277([Alumnos:2]; & [Alumnos:2]Sexo:49="F")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
			QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
			$Número_de_alumnas_mujeres:=String:C10(Records in selection:C76([Alumnos:2]))
			
			  //alumnas (mujeres) de origen indígena
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
			QUERY:C277([Alumnos:2]; & [Alumnos:2]Sexo:49="F")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
			QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
			$count:=0
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
				$count:=$count+Num:C11(_InfoReglamentariaAlumno ("Origen Indígena")="Si")
			End for 
			$alumnAsIndigenas:=String:C10($count)
			
			
			  //alumnos (hombres) de origen indigena
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
			QUERY:C277([Alumnos:2]; & [Alumnos:2]Sexo:49="M")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
			QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
			$count:=0
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
				$count:=$count+Num:C11(_InfoReglamentariaAlumno ("Origen Indígena")="Si")
			End for 
			$alumnOsIndigenas:=String:C10($count)
			
			
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
			$dvProfJefe:=[Profesores:4]RUT:27[[Length:C16([Profesores:4]RUT:27)]]
			$runProfJefe:=Substring:C12([Profesores:4]RUT:27;1;Length:C16([Profesores:4]RUT:27)-1)
			$Apellido_paterno_profesor:=Substring:C12([Profesores:4]Apellido_paterno:3;1;25)
			$Apellido_materno_profesor:=Substring:C12([Profesores:4]Apellido_materno:4;1;25)
			$Nombres_del_profesor_jefe:=Substring:C12([Profesores:4]Nombres:2;1;45)
			$record:="24"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$Tipo_de_enseñanza+"\t"+$nivel+"\t"+$Letra+"\t"+$año+"\t"+$Jornada+"\t"+$Indicador_curso_combinado+"\t"+$Número_de_alumnos_hombres+"\t"+$Número_de_alumnas_mujeres+"\t"+$alumnOsIndigenas+"\t"+$alumnAsIndigenas+"\t"+$alumnasEmbarazadas+"\t"+$runProfJefe+"\t"+$dvProfJefe+"\t"+$Apellido_paterno_profesor+"\t"+$Apellido_materno_profesor+"\t"+$Nombres_del_profesor_jefe+"\r"
			SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
			NEXT RECORD:C51([Cursos:3])
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		  //cierre del archivo
		CLOSE DOCUMENT:C267($fileref)
		
		
		
	: ($file2Process="25")  //Estudiantes de los cursos
		  //creando archivo
		$fileName:=$folder+"m"+$rolBD+"_25.txt"
		$fileRef:=Create document:C266($fileName;"TEXT")
		  //proceso y envio de datos al archivo
		QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesOficiales)
		QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
		QUERY SELECTION:C341([Cursos:3]; & [Cursos:3]Numero_del_curso:6>0)
		KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$fechaLimite)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
		QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Estudiantes de los cursos (")+$rolBD+__ ("_25.txt)"))
		While (Not:C34(End selection:C36([Alumnos:2])))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Estudiantes de los cursos (")+$rolBD+__ ("_25.txt)"))
			
			$indicadorExtranjero:="2"
			If (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilen@"))
				$indicadorExtranjero:="1"
				$run:=[Alumnos:2]NoPasaporte:87
				$DV:=""
			Else 
				$rut:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
				If (Num:C11(Substring:C12($rut;1;1))>0)
					$dv:=$rut[[Length:C16($rut)]]
					$run:=Substring:C12($rut;1;Length:C16($rut)-1)
				Else 
					$run:="ERR"
					$dv:="ERR"
				End if 
			End if 
			Case of 
				: ([Alumnos:2]Sexo:49="M")
					$sex:="1"
				: ([Alumnos:2]Sexo:49="F")
					$sex:="2"
				: ([Alumnos:2]Sexo:49="")
					$sex:="ERR"
			End case 
			If ([Alumnos:2]Fecha_de_nacimiento:7=!00-00-00!)
				$date:="ERR"
			Else 
				$date:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
			End if 
			If ([Alumnos:2]Es_Repitente:77)
				$repitente:="1"
			Else 
				$repitente:="2"
			End if 
			
			$integrado:="2"
			$diferencial:="2"
			$prebasicaEspecialA:="2"
			$prebasicaEspecialB:="2"
			$basicaEspecialA:="2"
			$basicaEspecialB:="2"
			If (_InfoReglamentariaAlumno ("Es Alumno Integrado")="Si")
				$integrado:="1"
			End if 
			If (_InfoReglamentariaAlumno ("En Grupo Diferencial")="Si")
				$diferencial:="1"
			End if 
			If (_InfoReglamentariaAlumno ("En Prebásica Especial A")="Si")
				$prebasicaEspecialA:="1"
			End if 
			If (_InfoReglamentariaAlumno ("En Prebásica Especial B")="Si")
				$prebasicaEspecialB:="1"
			End if 
			If (_InfoReglamentariaAlumno ("En Básica Especial A")="Si")
				$basicaEspecialA:="1"
			End if 
			If (_InfoReglamentariaAlumno ("En Básica Especial B")="Si")
				$basicaEspecialB:="1"
			End if 
			
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
			$tipoEnseñanza:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
			
			  // determinacion del nivel
			Case of 
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21=10)  // parvularia
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=160) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=163))  // basica comuna adultos o básica escuelas carceles
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21>=211) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=216))  // Deficiencia auditiva, mental, visual, alteraciones del lenguaje
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: ([Cursos:3]cl_CodigoTipoEnseñanza:21=361)  // media HC Adultos Decreto 12
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=460) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=461))  // TP Comercial adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=560) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=561))  // TP Industrial adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=660) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=661))  // TP Técnica adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=760) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=761))  // TP Agrícola adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21=860) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=861))  // TP Marítima adultos y decreto 152
					$nivel:=[Cursos:3]cl_CodigoNivelEspecial:36
				Else 
					Case of 
						: ([Cursos:3]Nivel_Numero:7=-2)
							$nivel:="4"
						: ([Cursos:3]Nivel_Numero:7=-1)
							$nivel:="5"
						: ([Cursos:3]Nivel_Numero:7>8)
							$nivel:=String:C10([Cursos:3]Nivel_Numero:7-8)
						Else 
							$nivel:=String:C10([Cursos:3]Nivel_Numero:7)
					End case 
			End case 
			
			
			$Letra:=[Cursos:3]Letra_Oficial_del_Curso:18
			$especialidad:=""
			$sector:=""
			Case of 
				: (([Cursos:3]cl_CodigoTipoEnseñanza:21>=400) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=910) & ([Cursos:3]Nivel_Numero:7>10))
					$especialidad:=String:C10([Cursos:3]cl_CodigoEspecialidadTP:29)
					$sector:=Substring:C12($especialidad;1;3)
					If (([Alumnos:2]nivel_numero:29=9) | ([Alumnos:2]nivel_numero:29=10))
						$especialidad:="0"
						$sector:="0"
					End if 
				Else 
					$especialidad:="0"
					$sector:="0"
			End case 
			
			$record:="25"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$tipoEnseñanza+"\t"+$nivel+"\t"+$Letra+"\t"+$año+"\t"+$run+"\t"+$dv+"\t"+$repitente+"\t"+$integrado+"\t"+$diferencial+"\t"+$sector+"\t"+$especialidad+"\t"+$prebasicaEspecialA+"\t"+$prebasicaEspecialB+"\t"+$basicaEspecialA+"\t"+$basicaEspecialB+"\r"
			SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
			NEXT RECORD:C51([Alumnos:2])
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		  //cierre del archivo
		CLOSE DOCUMENT:C267($fileref)
		
	: ($file2Process="26")  //Estudiantes de enseñanza media TP en nóminas
		  //buscando alumnos
		QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21>=400;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]cl_CodigoTipoEnseñanza:21<=899)
		QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
		QUERY SELECTION:C341([Cursos:3]; & [Cursos:3]Numero_del_curso:6>0)
		KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
		QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42>$fechaLimite)
		
		READ ONLY:C145([MDATA_RegistrosDatosLocales:145])
		KRL_RelateSelection (->[MDATA_RegistrosDatosLocales:145]ID_registro:3;->[Alumnos:2]numero:1)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145];[xxSTR_MetadatosLocales:141]Tabla:2=2;*)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145]; & ;[xxSTR_MetadatosLocales:141]Etiqueta:3="En Práctica, Egresado o Titulado";*)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145]; & ;[MDATA_RegistrosDatosLocales:145]Agno:4=<>gYear)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145]; & ;[MDATA_RegistrosDatosLocales:145]Valor_Numerico:7>0)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[MDATA_RegistrosDatosLocales:145]ID_registro:3;"")
		CREATE SET:C116([Alumnos:2];"actuales")
		
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]cl_CodigoTipoEnseñanza:32>=400;*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]cl_CodigoTipoEnseñanza:32<=899;*)
		QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=<>gYear-1)
		KRL_RelateSelection (->[MDATA_RegistrosDatosLocales:145]ID_registro:3;->[Alumnos_Historico:25]Alumno_Numero:1)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145];[xxSTR_MetadatosLocales:141]Tabla:2=2;*)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145]; & ;[xxSTR_MetadatosLocales:141]Etiqueta:3="En Práctica, Egresado o Titulado";*)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145]; & ;[MDATA_RegistrosDatosLocales:145]Agno:4=<>gYear-1)
		QUERY SELECTION:C341([MDATA_RegistrosDatosLocales:145]; & ;[MDATA_RegistrosDatosLocales:145]Valor_Numerico:7>0)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[MDATA_RegistrosDatosLocales:145]ID_registro:3;"")
		CREATE SET:C116([Alumnos:2];"egresados")
		
		UNION:C120("actuales";"egresados";"nomina")
		SET_UseSet ("nomina")
		SET_ClearSets ("actuales";"egresados";"nomina")
		
		
		If (Records in selection:C76([Alumnos:2])>0)
			  //creando archivo
			$fileName:=$folder+"m"+$rolBD+"_26.txt"
			$fileRef:=Create document:C266($fileName;"TEXT")
			
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Estudiantes de los cursos (")+$rolBD+__ ("_26txt)"))
			While (Not:C34(End selection:C36([Alumnos:2])))
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Estudiantes de los cursos (")+$rolBD+__ ("_25.txt)"))
				$rut:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
				
				
				If ([Alumnos:2]nivel_numero:29<=12)
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
					$tipoEnseñanza:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
				Else 
					QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=<>gYear-1)
					$tipoEnseñanza:=String:C10([Alumnos_Historico:25]cl_CodigoTipoEnseñanza:32)
				End if 
				
				
				If ([Alumnos:2]Nacionalidad:8#"Chilen@")
					$extranjero:="1"
				Else 
					$extranjero:="2"
				End if 
				If (Num:C11(Substring:C12($rut;1;1))>0)
					$dv:=$rut[[Length:C16($rut)]]
					$run:=Substring:C12($rut;1;Length:C16($rut)-1)
				Else 
					If ([Alumnos:2]Nacionalidad:8#"Chilen@")
						$run:=[Alumnos:2]NoPasaporte:87
						$dv:=""
					Else 
						$run:="ERR"
						$dv:="ERR"
					End if 
				End if 
				Case of 
					: ([Alumnos:2]Sexo:49="M")
						$sexo:="1"
					: ([Alumnos:2]Sexo:49="F")
						$sexo:="2"
					: ([Alumnos:2]Sexo:49="")
						$sexo:="ERR"
				End case 
				If ([Alumnos:2]Fecha_de_nacimiento:7=!00-00-00!)
					$date:="ERR"
				Else 
					$date:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
				End if 
				
				$tipoAlumno:=MDATA_RetornaNumerico (->[Alumnos:2]numero:1;"En Práctica, Egresado o Titulado")
				If ($tipoAlumno>0)
					$record:="26"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$tipoEnseñanza+"\t"+$año+"\t"+$run+"\t"+$dv+"\t"+[Alumnos:2]Apellido_paterno:3+"\t"+[Alumnos:2]Apellido_materno:4+"\t"+[Alumnos:2]Nombres:2+"\t"+$sexo+"\t"+$date+"\t"+String:C10($tipoAlumno)+"\t"+$extranjero+"\r"
					SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
				End if 
				NEXT RECORD:C51([Alumnos:2])
			End while 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			  //cierre del archivo
			CLOSE DOCUMENT:C267($fileref)
		End if 
End case 
