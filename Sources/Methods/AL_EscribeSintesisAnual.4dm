//%attributes = {}
  //Metodo: AL_EscribeSintesisAnual
  //Por abachler
  //Creada el 30/05/2008, 11:07:34
  // ----------------------------------------------------
  // Descripción
  // Asigna el valor pasado como puntero $2 ($valuePointer) al campo pasado como puntero en $3 ($field Pointer) en el registro correspondiente a la llave pasada en $1 ($key)
  // Si el registro no existe es creado automaticamente
  // Si $4 ($save) es igual a TRUE o si es omitido, el registro es escrito inmediatamente
  // Si $4 ($save) es FALSE, se asume que este mismo metodo será llamado consecutivamente siendo modificado en memoria y escrito sólo una vez que se reciba
  //     un llamado con $4 en TRUE o bien un llamado sin argumentos
  // Si el metodo es llamado sin argumentos se asume que la intención del programador es escribir el registro con los valores que hay en memoria
  // ----------------------------------------------------
  // Parámetros
  // $1: llave de index; &T; asignado a $key
  // $2: puntero sobre el campo a modificar; &Pointer; asignado a $FieldPointer
  // $3: puntero sobre el valor a asignar; &Pointer; asignado a $valuePointer
  // $4: indica si el registro debe ser escrito disco o sólo modificado en memoria
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES

C_TEXT:C284($key;$1)
C_LONGINT:C283($idInstitucion;$año;$idAlumno;$periodo;$nivel)
C_POINTER:C301($fieldPointer;$2;$valuePointer;$3)
C_BOOLEAN:C305($save;$4)

If (Count parameters:C259>0)
	$key:=$1
	$idInstitucion:=Num:C11(ST_GetWord ($key;1;"."))
	$año:=Num:C11(ST_GetWord ($key;2;"."))
	$nivel:=Num:C11(ST_GetWord ($key;3;"."))
	$idAlumno:=Num:C11(ST_GetWord ($key;4;"."))
End if 

  //CUERPO
If (($nivel>Nivel_AdmisionDirecta) & ($nivel<Nivel_Egresados))
	If (Count parameters:C259=0)
		$save:=True:C214
	Else 
		$fieldPointer:=$2
		$valuePointer:=$3
		
		$save:=True:C214
		If (Count parameters:C259=4)
			$save:=$4
		End if 
		$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		If ($recNum<0)
			AL_CreaRegistrosSintesis ($idAlumno;$año;$nivel;$idInstitucion)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		End if 
		$fieldPointer->:=$valuePointer->
	End if 
	
	
	If ($save)
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
	End if 
End if 

  //LIMPIEZA


