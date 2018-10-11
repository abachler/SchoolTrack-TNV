//%attributes = {}
  //EV2_EstableceColor

C_TEXT:C284($0;$evaluacion)
C_POINTER:C301($1;$fieldPointer)
C_TEXT:C284($key)
C_LONGINT:C283($2;$periodo;$3;$4;$year;$5;$institucion)
C_LONGINT:C283($grupoParciales;$tableNumber;$fieldNumber;$fieldIndex)

$institucion:=<>gInstitucion
$year:=<>gYear
$fieldPointer:=$1
$periodo:=vPeriodo

$tableNumber:=Table:C252($fieldPointer)
$fieldNumber:=Field:C253($fieldPointer)
$fieldName:=Field name:C257($fieldPointer)


Case of 
	: (Count parameters:C259=4)
		$institucion:=$4
		$year:=$3
		$periodo:=$2
		
	: (Count parameters:C259=3)
		$periodo:=$3
		
	: (Count parameters:C259=2)
		$periodo:=$2
		
End case 



Case of 
	: ($fieldName="@Real")
		  //no se hace nada, el campo es el real
		
	: ($fieldName="@Nota")
		$fieldName:=Replace string:C233($fieldName;"Nota";"Real")
		
	: ($fieldName="@Simbolo")
		$fieldName:=Replace string:C233($fieldName;"Simbolo";"Real")
		
	: ($fieldName="@Puntos")
		$fieldName:=Replace string:C233($fieldName;"Puntos";"Real")
		
	: ($fieldName="@Literal")
		$fieldName:=Replace string:C233($fieldName;"Literal";"Real")
		
	: ($fieldName="@Palabras")
		$fieldName:=Replace string:C233($fieldName;"Palabras";"Real")
		
	: ($fieldName="@RealNoAprox")
		$fieldName:=Replace string:C233($fieldName;"RealNoAprox";"Real")
End case 

$key:=String:C10($institucion)+"."+String:C10($year)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10([Alumnos_Calificaciones:208]ID_Asignatura:5)+"."+String:C10([Alumnos_Calificaciones:208]ID_Alumno:6)
If ($key#[Alumnos_Calificaciones:208]Llave_principal:1)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$key)
End if 

$fieldPointer:=KRL_GetFieldPointerByName ($fieldName)

Case of 
		
	: ($fieldPointer->=-10)
		SR_SetColor ("White")
		
		
	: ($fieldPointer->=-2)
		SR_SetColor ("Red")
		
		
	: ($fieldPointer-><rPctMinimum)
		SR_SetColor ("Red")
		
	: ($fieldPointer->>=rPctMinimum)
		SR_SetColor ("Blue")
		
	Else 
		SR_SetColor ("Black")
End case 



