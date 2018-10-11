//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-08-18, 19:49:52
  // ----------------------------------------------------
  // Método: AS_PropEval_CreaObjeto
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------




C_LONGINT:C283(vi_DecimalesPonderacion;vi_PonderacionTruncada;$i_periodo;$1)
C_BLOB:C604($x_blob)
C_OBJECT:C1216($objeto;$o_nodo)

$l_nivel:=$1

ARRAY TEXT:C222(atAS_EvalPropSourceName;0)
ARRAY TEXT:C222(atAS_EvalPropClassName;0)
ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;0)
ARRAY REAL:C219(arAS_EvalPropPercent;0)
ARRAY REAL:C219(arAS_EvalPropCoefficient;0)
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;0)
ARRAY TEXT:C222(atAS_EvalPropPrintName;0)
ARRAY DATE:C224(adAS_EvalPropDueDate;0)
ARRAY REAL:C219(arAS_EvalPropPonderacion;0)
ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
ARRAY DATE:C224(ad_BloqueoParcial_p5;0)


AT_RedimArrays (12;->atAS_EvalPropSourceName;->atAS_EvalPropClassName;->alAS_EvalPropSourceID;->aiAS_EvalPropEnterable;->arAS_EvalPropPercent)
AT_RedimArrays (12;->arAS_EvalPropCoefficient;->abAS_EvalPropPrintDetail;->atAS_EvalPropPrintName;->adAS_EvalPropDueDate;->arAS_EvalPropPonderacion)
AT_RedimArrays (12;->ad_BloqueoParcial_p1;->ad_BloqueoParcial_p2;->ad_BloqueoParcial_p3;->ad_BloqueoParcial_p4;->ad_BloqueoParcial_p5)


PERIODOS_LoadData ($l_nivel)
$l_iteraciones:=Size of array:C274(atSTR_Periodos_Nombre)+1

For ($l_indice;1;$l_iteraciones)
	
	For ($i;1;12)
		atAS_EvalPropSourceName{$i}:=__ ("Evaluación ingresable")
		alAS_EvalPropSourceID{$i}:=0
		aiAS_EvalPropEnterable{$i}:=1
		arAS_EvalPropCoefficient{$i}:=1
		arAS_EvalPropPercent{$i}:=0
		abAS_EvalPropPrintDetail{$i}:=False:C215
		atAS_EvalPropPrintName{$i}:=""
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
	
	If ($l_indice<=Size of array:C274(atSTR_Periodos_Nombre))
		$t_nodo:="P"+String:C10($l_indice)
	Else 
		$t_nodo:="Anual"
	End if 
	
	Case of 
		: (vlAS_CalcMethod=0)
			ARRAY REAL:C219(arAS_EvalPropPonderacion;0)
			ARRAY REAL:C219(arAS_EvalPropPonderacion;12)
			ARRAY REAL:C219(arAS_EvalPropCoefficient;12)
			For ($i;1;12)
				arAS_EvalPropCoefficient{$i}:=1
			End for 
		: (vlAS_CalcMethod=1)
			COPY ARRAY:C226(arAS_EvalPropPonderacion;arAS_EvalPropCoefficient)
		: (vlAS_CalcMethod=2)
			COPY ARRAY:C226(arAS_EvalPropPonderacion;arAS_EvalPropPercent)
	End case 
	
	OB SET ARRAY:C1227($o_nodo;"SourceID";alAS_EvalPropSourceID)
	OB SET ARRAY:C1227($o_nodo;"SourceName";atAS_EvalPropSourceName)
	OB SET ARRAY:C1227($o_nodo;"ClassName";atAS_EvalPropClassName)
	OB SET ARRAY:C1227($o_nodo;"Enterable";aiAS_EvalPropEnterable)
	OB SET ARRAY:C1227($o_nodo;"Percent";arAS_EvalPropPercent)
	OB SET ARRAY:C1227($o_nodo;"Coefficient";arAS_EvalPropCoefficient)
	OB SET ARRAY:C1227($o_nodo;"PrintDetail";abAS_EvalPropPrintDetail)
	OB SET ARRAY:C1227($o_nodo;"PrintName";atAS_EvalPropPrintName)
	OB SET ARRAY:C1227($o_nodo;"Description";atAS_EvalPropDescription)
	OB SET ARRAY:C1227($o_nodo;"DueDate";adAS_EvalPropDueDate)
	
	OB SET:C1220($o_nodo;"CalcMethod";vlAS_CalcMethod)
	OB SET:C1220($o_nodo;"DecimalesPonderacion";vi_DecimalesPonderacion)
	OB SET:C1220($o_nodo;"PonderacionTruncada";vi_PonderacionTruncada)
	OB SET:C1220($o_nodo;"ConsolidaExamenFinal";vi_ConsolidaExamenFinal)
	OB SET:C1220($o_nodo;"ConsolidaNotasFinales";vi_ConsolidaNotasFinales)
	
	
	OB SET:C1220($objeto;$t_nodo;$o_nodo)
	
End for 

OB SET ARRAY:C1227($objeto;"LimiteIngresoParciales_P1";ad_BloqueoParcial_p1)
OB SET ARRAY:C1227($objeto;"LimiteIngresoParciales_P2";ad_BloqueoParcial_p2)
OB SET ARRAY:C1227($objeto;"LimiteIngresoParciales_P3";ad_BloqueoParcial_p3)
OB SET ARRAY:C1227($objeto;"LimiteIngresoParciales_P4";ad_BloqueoParcial_p4)
OB SET ARRAY:C1227($objeto;"LimiteIngresoParciales_P5";ad_BloqueoParcial_p5)


$0:=$objeto