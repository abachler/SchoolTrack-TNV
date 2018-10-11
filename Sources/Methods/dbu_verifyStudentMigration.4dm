//%attributes = {}
  //dbu_verifyStudentMigration



C_LONGINT:C283($i;$p;$el)
C_BOOLEAN:C305($vb_Formula;$2;$go)
C_POINTER:C301($ptrTable;$ptrField;$1)
C_TIME:C306($ref)
C_TEXT:C284($text;$versionAnterior)
C_TEXT:C284($vtACT_document)
$ptrTable:=$1
$go:=True:C214
Case of 
	: (Count parameters:C259=1)
		$vb_Formula:=False:C215
	: (Count parameters:C259=2)
		$vb_Formula:=$2
	Else 
		$ptrTable:=->[Alumnos:2]
		$vb_Formula:=False:C215
End case 

Case of 
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos:2]))
		$ptrField:=->[Alumnos:2]numero:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Conducta:8]))
		$ptrField:=->[Alumnos_Conducta:8]Número_de_Alumno:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Castigos:9]))
		$ptrField:=->[Alumnos_Castigos:9]Alumno_Numero:8
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Inasistencias:10]))
		$ptrField:=->[Alumnos_Inasistencias:10]Alumno_Numero:4
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Anotaciones:11]))
		$ptrField:=->[Alumnos_Anotaciones:11]Alumno_Numero:6
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Suspensiones:12]))
		$ptrField:=->[Alumnos_Suspensiones:12]Alumno_Numero:7
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_FichaMedica:13]))
		$ptrField:=->[Alumnos_FichaMedica:13]Alumno_Numero:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_EventosEnfermeria:14]))
		$ptrField:=->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Orientacion:15]))
		$ptrField:=->[Alumnos_Orientacion:15]Alumno_Numero:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_EventosPersonales:16]))
		$ptrField:=->[Alumnos_EventosPersonales:16]Alumno_Numero:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_ObservacionesEvaluacion:30]))
		$ptrField:=->[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Atrasos:55]))
		$ptrField:=->[Alumnos_Atrasos:55]Alumno_numero:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Vacunas:101]))
		$ptrField:=->[Alumnos_Vacunas:101]Numero_Alumno:1
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_Calificaciones:208]))
		$ptrField:=->[Alumnos_Calificaciones:208]ID_Alumno:6
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
		$ptrField:=->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6
	: (Table:C252($ptrTable)=Table:C252(->[Alumnos_SintesisAnual:210]))
		$ptrField:=->[Alumnos_SintesisAnual:210]ID_Alumno:4
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		$ptrField:=->[ACT_Documentos_en_Cartera:182]ID:1
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Transacciones:178]))
		$ptrField:=->[ACT_Transacciones:178]ID_Transaccion:1
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Pagares:184]))
		$ptrField:=->[ACT_Pagares:184]
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		$ptrField:=->[ACT_Documentos_en_Cartera:182]ID:1
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Boletas:181]))
		$ptrField:=->[ACT_Boletas:181]ID:1
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Pagos:172]))
		$ptrField:=->[ACT_Pagos:172]ID:1
	: (Table:C252($ptrTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		$ptrField:=->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
	Else 
		$go:=False:C215
		CD_Dlog (0;"La tabla que ingreso no existe o está mal escrita.")
End case 
If ($go)
	
	
	If (Not:C34($vb_Formula))
		$ref:=Create document:C266("";"TEXT")
		EM_ErrorManager ("Clear")
		If ($ref#?00:00:00?)
			
			ALL RECORDS:C47($ptrTable->)
			ORDER BY:C49($ptrTable->;$ptrField->;>)
			SELECTION TO ARRAY:C260($ptrField->;$aNumAlumnos)
			AT_DistinctsArrayValues (->$aNumAlumnos)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando informe de datos de tabla "+Table name:C256($ptrTable))
			IO_SendPacket ($ref;"Versión: "+SYS_LeeVersionEstructura +"\r")
			For ($i;1;Size of array:C274($aNumAlumnos))
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aNumAlumnos))
				IO_SendPacket ($ref;String:C10($aNumAlumnos{$i})+"\r")
			End for 
			CLOSE DOCUMENT:C267($ref)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			CD_Dlog (0;"Archivo generado correctamente")
		Else 
			CD_Dlog (0;"se canceló la impresión del archivo")
		End if 
	Else 
		ARRAY LONGINT:C221($aNumAlumnos;0)
		ARRAY LONGINT:C221($aNumAlumnos2;0)
		ARRAY TEXT:C222($atResultado;0)
		$ref:=Open document:C264("";Read mode:K24:5)
		$vtACT_document:=document
		If ($ref#?00:00:00?)
			RECEIVE PACKET:C104($ref;$text;"\r")
			$versionAnterior:=$text
			RECEIVE PACKET:C104($ref;$text;"\r")
			$p:=IT_UThermometer (1;0;"Leyendo archivo...")
			While ($text#"")
				$id_alumno:=Num:C11(ST_GetWord ($text;1;"\r"))
				APPEND TO ARRAY:C911($aNumAlumnos;$id_alumno)
				RECEIVE PACKET:C104($ref;$text;"\r")
			End while 
			$el:=Find in array:C230($aNumAlumnos;0)
			If ($el#-1)
				DELETE FROM ARRAY:C228($aNumAlumnos;$el)
			End if 
			IT_UThermometer (-2;$p)
			CLOSE DOCUMENT:C267($ref)
			DELETE DOCUMENT:C159($vtACT_document)  //Elimino el documento generado anteriormente
			
			$ref:=Create document:C266("";"TEXT")
			$vtACT_document:=document
			EM_ErrorManager ("Clear")
			If ($ref#?00:00:00?)
				ARRAY TEXT:C222($alNumAlumnoB1;0)
				ARRAY TEXT:C222($alNumAlumnoB2;0)
				ALL RECORDS:C47($ptrTable->)
				SELECTION TO ARRAY:C260($ptrField->;$aNumAlumnos2)
				AT_DistinctsArrayValues (->$aNumAlumnos2)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Creando reporte final de comparación de tabla "+Table name:C256($ptrTable))
				For ($i;1;Size of array:C274($aNumAlumnos))
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aNumAlumnos))
					$el:=Find in array:C230($aNumAlumnos2;$aNumAlumnos{$i})
					If ($el=-1)
						APPEND TO ARRAY:C911($atResultado;"FALSO")
						APPEND TO ARRAY:C911($alNumAlumnoB2;"")
						APPEND TO ARRAY:C911($alNumAlumnoB1;String:C10($aNumAlumnos{$i}))
					Else 
						APPEND TO ARRAY:C911($atResultado;"VERDADERO")
						APPEND TO ARRAY:C911($alNumAlumnoB1;String:C10($aNumAlumnos{$i}))
						APPEND TO ARRAY:C911($alNumAlumnoB2;String:C10($aNumAlumnos{$i}))
					End if 
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				IO_SendPacket ($ref;$versionAnterior+"\t"+"Version: "+SYS_LeeVersionEstructura +"\r"+"Id "+Table name:C256($ptrTable)+"\t"+"Id "+Table name:C256($ptrTable)+"\t"+"Resultado"+"\r")
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Finalizando...")
				For ($i;1;Size of array:C274($alNumAlumnoB2))
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alNumAlumnoB2))
					IO_SendPacket ($ref;$alNumAlumnoB1{$i}+"\t"+$alNumAlumnoB2{$i}+"\t"+$atResultado{$i}+"\r")
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				CD_Dlog (0;"Archivo generado correctamente")
				
				CLOSE DOCUMENT:C267($ref)
				
				ACTcd_DlogWithShowOnDisk ($vtACT_document;0;"La exportación de archivo ha concluido."+"\r\r"+"La encontrará en: "+"\r"+$vtACT_document+"\r\r"+"Le recomendamos abrirla con Microsoft Excel.")
				
			Else 
				CD_Dlog (0;"se canceló la impresión del archivo, o existe problema al crear el archivo")
			End if 
		End if 
	End if 
End if 


