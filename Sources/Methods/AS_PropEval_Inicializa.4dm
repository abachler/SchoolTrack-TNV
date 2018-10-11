//%attributes = {}
  // AS_PropEval_Inicializa()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/10/12, 10:36:20
  // ---------------------------------------------


  // CODIGO
vlAS_CalcMethod:=0
vi_DecimalesPonderacion:=0
vi_PonderacionTruncada:=0
vi_ConsolidaExamenFinal:=0
vi_ConsolidaNotasFinales:=0

ARRAY TEXT:C222(atAS_EvalPropSourceName;0)  //destination name
ARRAY TEXT:C222(atAS_EvalPropClassName;0)  //destination class
ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)  //id destination
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;0)  //method
ARRAY REAL:C219(arAS_EvalPropPercent;0)  //grade weight
ARRAY REAL:C219(arAS_EvalPropCoefficient;0)  //coefficient
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;0)  //print on reports
ARRAY TEXT:C222(atAS_EvalPropPrintName;0)  //print as
ARRAY TEXT:C222(atAS_EvalPropDescription;0)  //description
ARRAY DATE:C224(adAS_EvalPropDueDate;0)  //due date 
ARRAY REAL:C219(arAS_EvalPropCoefficient;0)  //coefficient  
AT_RedimArrays (12;->atAS_EvalPropSourceName;->atAS_EvalPropClassName;->alAS_EvalPropSourceID;->aiAS_EvalPropEnterable;->arAS_EvalPropPercent;->arAS_EvalPropCoefficient;->abAS_EvalPropPrintDetail;->atAS_EvalPropPrintName;->atAS_EvalPropDescription;->adAS_EvalPropDueDate;->arAS_EvalPropCoefficient)
  //MONO BLoqueo de parciales
ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
ARRAY DATE:C224(ad_BloqueoParcial_p5;0)

For ($i;1;12)
	atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
	alAS_EvalPropSourceID{$i}:=0
	aiAS_EvalPropEnterable{$i}:=1
	arAS_EvalPropCoefficient{$i}:=1
	If (Not:C34(abAS_EvalPropPrintDetail{$i}))
		atAS_EvalPropPrintName{$i}:=""
	End if 
End for 
COPY ARRAY:C226(arAS_EvalPropCoefficient;arAS_EvalPropPonderacion)
  //AS_PropEval_Escritura ($t_NombreRegistroPropiedades)
AS_PropEval_Escritura (0;False:C215)  //MONO CAMBIO AS_PropEval_Escritura




