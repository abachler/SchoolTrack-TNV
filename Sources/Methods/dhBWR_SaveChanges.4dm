//%attributes = {}
  //dhBWR_SaveChanges

  //xShell, Alberto Bachler
  //Metodo: dhBWR_SaveChanges
  //Por abachler
  //Creada el 29/09/2003, 10:15:56
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: BWR_SaveChanges
	  //utilizar para desviar el procesamiento estandar del evento en xShell (muestra un dialogo de confirmación)
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar TRUE a $dontSave si el registro no puede ser guardado  (el formulario queda en pantalla)
	  //
End if 

  //****DECLARACIONES****
C_BOOLEAN:C305($dontSave;$0)

  //****INICIALIZACIONES****
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

  //****CUERPO****
Case of 
	: ((Table:C252($tablePointer)=Table:C252(->[Asignaturas:18])) & ([Asignaturas:18]Asignatura:3=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Alumnos:2])) & ([Alumnos:2]Apellido_paterno:3=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Profesores:4])) & ([Profesores:4]Apellido_paterno:3=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Actividades:29])) & ([Actividades:29]Nombre:2=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Profesores:4])) & ([Profesores:4]Apellido_paterno:3=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Cursos:3])) & ([Cursos:3]Curso:1=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Personas:7])) & ([Personas:7]Apellido_paterno:3=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[Familia:78])) & ([Familia:78]Nombre_de_la_familia:3=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[BBL_Items:61])) & ([BBL_Items:61]Primer_título:4=""))
		$dontSave:=True:C214
	: ((Table:C252($tablePointer)=Table:C252(->[BBL_Lectores:72])) & ([BBL_Lectores:72]Apellido_paterno:12=""))
		$dontSave:=True:C214
End case 
$0:=$dontSave

  //****LIMPIEZA****
