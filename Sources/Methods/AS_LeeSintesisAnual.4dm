//%attributes = {}
  //Metodo: AS_LeeSintesisAnual
  //Por abachler
  //Creada el `22/10/2008, 09:11:50
  // ----------------------------------------------------
  // Descripción
  // retorna en la variable pasada como puntero en $3 ($valuePointer) el valor del campo pasado como puntero en $2 ($field Pointer) almacenado en el registro correspondiente a la llave pasada en $1 ($key)
  // Si el registro no existe es creado automaticamente
  // ----------------------------------------------------
  // Parámetros
  // $1: llave de index; &T; asignado a $key
  // $2: puntero sobre el campo a retornar; &Pointer; asignado a $FieldPointer
  // $3: puntero sobre la variable a en la que se retorna el resultado; &Pointer; 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES

C_TEXT:C284($key;$1)
C_LONGINT:C283($idInstitucion;$año;$idAlumno;$periodo)
C_POINTER:C301($fieldPointer;$2;$valuePointer;$3)
C_BOOLEAN:C305($save;$4)
$key:=$1
$fieldPointer:=$2
$valuePointer:=$3

  //CUERPO
$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$key;False:C215)
If ($recNum<0)
	CREATE RECORD:C68([Asignaturas_SintesisAnual:202])
	[Asignaturas_SintesisAnual:202]LLavePrimaria:5:=$key
	[Asignaturas_SintesisAnual:202]ID_Institucion:1:=Num:C11(ST_GetWord ($key;1;"."))
	[Asignaturas_SintesisAnual:202]Año:3:=Num:C11(ST_GetWord ($key;2;"."))
	[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=Num:C11(ST_GetWord ($key;3;"."))
	SAVE RECORD:C53([Alumnos_SintesisAnual:210])
End if 

$valuePointer->:=$fieldPointer->


  //LIMPIEZA
