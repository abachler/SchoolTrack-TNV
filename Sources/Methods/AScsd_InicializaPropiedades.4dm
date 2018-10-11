//%attributes = {}
  // MÉTODO: AScsd_InicializaPropiedades
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/08/11, 12:36:23
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AScsd_InicializaPropiedades()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($1;$l_idAsignatura)
$l_idAsignatura:=$1


  // CODIGO PRINCIPAL
  //se inicializan los parametros de configuración
ARRAY TEXT:C222(atAS_EvalPropSourceName;0)  //destination name
ARRAY TEXT:C222(atAS_EvalPropClassName;0)  //destination class
ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)  //id destination
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;0)  //method
ARRAY REAL:C219(arAS_EvalPropPercent;0)  //grade weight  
ARRAY REAL:C219(arAS_EvalPropCoefficient;0)  //coefficient
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;0)
ARRAY TEXT:C222(atAS_EvalPropPrintName;0)
ARRAY DATE:C224(adAS_EvalPropDueDate;0)
ARRAY REAL:C219(arAS_EvalPropPonderacion;0)

ARRAY TEXT:C222(atAS_EvalPropSourceName;12)  //destination name
ARRAY TEXT:C222(atAS_EvalPropClassName;12)  //destination class
ARRAY LONGINT:C221(alAS_EvalPropSourceID;12)  //id destination
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;12)  //method
ARRAY REAL:C219(arAS_EvalPropPercent;12)  //grade weight
ARRAY REAL:C219(arAS_EvalPropCoefficient;12)  //coefficient
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;12)
ARRAY TEXT:C222(atAS_EvalPropPrintName;12)
ARRAY DATE:C224(adAS_EvalPropDueDate;12)
ARRAY REAL:C219(arAS_EvalPropPonderacion;12)  //Ponderacion

For ($i;1;12)
	atAS_EvalPropSourceName{$i}:=__ ("Evaluación ingresable")
	alAS_EvalPropSourceID{$i}:=0
	aiAS_EvalPropEnterable{$i}:=1
	arAS_EvalPropCoefficient{$i}:=1
	arAS_EvalPropPercent{$i}:=0
	abAS_EvalPropPrintDetail{$i}:=False:C215
	atAS_EvalPropPrintName{$i}:=__ ("Evaluación Parcial Nº ")+String:C10($i)
	atAS_EvalPropClassName{$i}:=""
	arAS_EvalPropPercent{$i}:=0
	arAS_EvalPropPonderacion{$i}:=0
End for 
vi_DecimalesPonderacion:=0
vi_PonderacionTruncada:=0
vi_ConsolidaExamenFinal:=0
vi_ConsolidaNotasFinales:=0
vlAS_CalcMethod:=0
w0iguales:=1
w1coeficiente:=0
w2porcentaje:=0
AS_PropEval_Escritura (0)  //MONO CAMBIO AS_PropEval_Escritura - Revisar llamado
  //AS_PropEval_Escritura ("Blob_ConfigNotas/"+String($l_idAsignatura))

  //ASM Ticket 216399
For ($l_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
	AS_PropEval_Escritura ($l_periodo)
End for 
