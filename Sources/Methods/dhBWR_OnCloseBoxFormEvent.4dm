//%attributes = {}
  //dhBWR_OnCloseBoxFormEvent

If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 


$trapped:=False:C215

Case of 
	: (Table:C252($tablePointer)=Table:C252(->[Alumnos:2]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[Familia:78]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[Cursos:3]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[Profesores:4]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[Asignaturas:18]))
		AS_OnCloseInputForm 
		$trapped:=True:C214
		
	: (Table:C252($tablePointer)=Table:C252(->[Actividades:29]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[Personas:7]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Items:61]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Lectores:72]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Subscripciones:117]))
		
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_CuentasCorrientes:175]))
		
		
End case 
$0:=$trapped