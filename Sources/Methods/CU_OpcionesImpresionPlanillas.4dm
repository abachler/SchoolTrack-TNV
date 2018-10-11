//%attributes = {}
  //CU_OpcionesImpresionPlanillas

C_BOOLEAN:C305($1;$selectPeriod)
ARRAY TEXT:C222(aEvViewMode;0)
ARRAY TEXT:C222(aEvStyleType;0)


Case of 
	: (Count parameters:C259=2)
		$selectPeriod:=$1
		vi_formPage:=$2
	: (Count parameters:C259=1)
		$selectPeriod:=$1
		vi_formPage:=1
	Else 
		$selectPeriod:=True:C214
		vi_formPage:=1
End case 


If ($selectPeriod)
	ARRAY TEXT:C222(aPeriodos;0)
	COPY ARRAY:C226(atSTR_Periodos_Nombre;aPeriodos)
	aPeriodos:=Find in array:C230(aiSTR_Periodos_Numero;viSTR_PeriodoActual_Numero)
	INSERT IN ARRAY:C227(aPeriodos;Size of array:C274(aPeriodos)+1;2)
	aPeriodos{Size of array:C274(aPeriodos)-1}:="-"
	aPeriodos{Size of array:C274(aPeriodos)}:="Promedio general"
Else 
	ARRAY TEXT:C222(aPeriodos;1)
	aPeriodos{1}:="Todos"
	aPeriodos:=1
End if 

WDW_OpenFormWindow (->[Cursos:3];"OpcionesImpresionPlanillas";-1;Movable form dialog box:K39:8;__ ("Opciones de impresión para evaluaciones"))
DIALOG:C40([Cursos:3];"OpcionesImpresionPlanillas")
CLOSE WINDOW:C154

If (ok=1)
	If (aPeriodos=Size of array:C274(aPeriodos))
		vPeriodo:=0
	Else 
		vPeriodo:=aPeriodos
	End if 
End if 