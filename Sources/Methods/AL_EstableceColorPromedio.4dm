//%attributes = {}
  //Metodo: AL_EstableceColorPromedio
  //Por abachler
  //Creada el 05/06/2008, 12:30:02
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($0;$evaluacion)
C_POINTER:C301($1;$fieldPointer)
C_TEXT:C284($key)
C_LONGINT:C283($2;$periodo)
C_LONGINT:C283($grupoParciales;$tableNumber;$fieldNumber;$fieldIndex)

$institucion:=<>gInstitucion
$year:=<>gYear
$fieldPointer:=$1
$periodo:=vPeriodo

$tableNumber:=Table:C252($fieldPointer)
$fieldNumber:=Field:C253($fieldPointer)
$fieldName:=Field name:C257($fieldPointer)

Case of 
	: (Count parameters:C259=2)
		$periodo:=$2
		
	: (Count parameters:C259=1)
		
End case 
  //CUERPO

Case of 
	: ($fieldName="PromedioOficial@")
		$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25
		$estiloEvaluacion:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]EvStyle_oficial:23)
	: ($fieldName="PromedioAnual@")
		$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15
		$estiloEvaluacion:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]EvStyle_interno:33)
	: ($fieldName="Promediofinal@")
		$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20
		$estiloEvaluacion:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]EvStyle_interno:33)
End case 

EVS_ReadStyleData ($estiloEvaluacion)

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


  //LIMPIEZA
