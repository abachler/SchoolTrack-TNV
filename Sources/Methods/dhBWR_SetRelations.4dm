//%attributes = {}
  //dhBWR_SetRelations
  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 07-03-11, 11:13:37
  // ----------------------------------------------------
  // Método: dhBWR_SetRelations
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If ("INSTRUCCIONES"="")
	  //utilizar para desviar el procesamiento estandar del evento en xShell
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar True a $trapped si el evento es procesado
End if 

  //****DECLARACIONES****
C_BOOLEAN:C305($trapped;$b_set;$2)
C_POINTER:C301($tablePointer;$1)

  //****INICIALIZACIONES****
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 
If (Count parameters:C259=2)
	$b_set:=$2
End if 
$trapped:=False:C215

Case of 
	: (Table:C252($tablePointer)=Table:C252(->[Alumnos:2]))
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		If ($b_set)
			SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Automatic:K51:4;Automatic:K51:4)
		Else 
			SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Structure configuration:K51:2;Structure configuration:K51:2)
		End if 
		$trapped:=True:C214
End case 

$0:=$trapped