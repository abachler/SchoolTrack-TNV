//%attributes = {}
  //0xDev_TIPO_RecuperacionRegistro

  //este metodo es una suerte de templeta que permite recuperar registros perdidos desde una copia
  //anterior de la base de datos

  //los registros de una o mas tablas pueden ser exportados llamando al método IO_ExportRecordsFromTables
  //IO_ExportRecordsFromTables recibe un puntero sobre un arreglo de punteros sobre las tablas a exportar

  //Este método de, 0xDev_TIPO_RecuperacionRegistro, debe ser adaptado según las tablas que se desean recuperar
  //No es posible hacerlo generico que se debe utilizar uno o más campos indexados que aseguren la unicidad.

  //PRECAUCIONES A TOMAR
  //- NO UTILIZAR los recnum de los registros (pueden haber cambiado entre una y otra base por compactaje, recuperacion o export/import
  //- Asegurarse que los index de la base de datos recepcionante estén sanos.


  //DECLARATIONS
_O_C_STRING:C293(255;$tableName)
C_LONGINT:C283($i;$j;$records;$tableNumber;$tables2import)

  //INITIALIZATION


  //MAIN CODE
SET CHANNEL:C77(10;"")

$ref:=Create document:C266("logRestauracionRegistros.txt")

0xDev_AvoidTriggerExecution (True:C214)

If (ok=1)
	RECEIVE VARIABLE:C81($tables2import)
	For ($j;1;$tables2import)
		RECEIVE VARIABLE:C81($tablenumber)
		RECEIVE VARIABLE:C81($tableName)
		RECEIVE VARIABLE:C81($records)
		$RCVtablename:=Table name:C256($tableNumber)
		If ($tablename=$RCVtablename)
			DEFAULT TABLE:C46(Table:C252($tableNumber)->)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros en el archivo ")+$tableName)
			For ($i;1;$records)
				RECEIVE RECORD:C79
				Case of 
					: ($tableNumber=Table:C252(->[Cursos:3]))
						$recNum:=Find in field:C653([Cursos:3]Curso:1;[Cursos:3]Curso:1)  //verifico la existencia del identificador en la tabla de índices
						If ($recNum<0)  //si el identificador no existe el registro es importado. si no existe es omitido
							$text:="CURSOS\t"+[Cursos:3]Curso:1+Char:C90(Carriage return:K15:38)
							SEND PACKET:C103($ref;$text)
							SAVE RECORD:C53
						End if 
						
					: ($tableNumber=Table:C252(->[Alumnos:2]))
						$recNum:=Find in field:C653([Alumnos:2]numero:1;[Alumnos:2]numero:1)  //verifico la existencia del identificador en la tabla de índices
						If ($recNum<0)  //si el identificador no existe el registro es importado. si no existe es omitido
							$text:="ALUMNOS\t"+[Alumnos:2]apellidos_y_nombres:40+Char:C90(Carriage return:K15:38)
							SEND PACKET:C103($ref;$text)
							SAVE RECORD:C53
						End if 
						
					: ($tableNumber=Table:C252(->[Alumnos_Calificaciones:208]))
						$recNum:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;[Alumnos_Calificaciones:208]Llave_principal:1)  //verifico la existencia del identificador en la tabla de índices
						If ($recNum<0)  //si el identificador no existe el registro es importado. si no existe es omitido
							SAVE RECORD:C53
							$idAlumno:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
							KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno)
							$idAsignatura:=Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
							KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$idAsignatura)
							$text:="CALIFICACIONES\t"+[Alumnos_Calificaciones:208]Llave_principal:1+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+[Asignaturas:18]denominacion_interna:16+Char:C90(Carriage return:K15:38)
							SEND PACKET:C103($ref;$text)
						End if 
						
				End case 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$records)
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Else 
			ALERT:C41("Los datos exportados no corresponden al archivo que debe recibirlos")
			$j:=$tables2import
		End if 
	End for 
End if 

CLOSE DOCUMENT:C267($ref)



0xDev_AvoidTriggerExecution (False:C215)