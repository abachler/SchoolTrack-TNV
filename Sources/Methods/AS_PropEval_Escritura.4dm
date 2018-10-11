//%attributes = {}
  // AS_PropEval_Escritura()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/11/12, 05:34:52
  // ---------------------------------------------
_O_C_STRING:C293(35;$t_referenciaRegistroConfig)
C_LONGINT:C283(vi_DecimalesPonderacion;vi_PonderacionTruncada;$i_periodo;$1)
C_BOOLEAN:C305($2;$salvar)
C_BLOB:C604($x_blob)

  //MONO CAMBIOS
  //ahora debería recibir el numero del periodo o 0 cuando es anual
$i_periodo:=$1
$b_salvar:=True:C214
$b_consolidacionPorPeriodo:=[Asignaturas:18]Consolidacion_PorPeriodo:58

  //If (Count parameters=2)
  //$b_salvar:=$2
  //End if 

Case of 
	: (Count parameters:C259=2)
		$b_salvar:=$2
	: (Count parameters:C259=3)
		$b_salvar:=$2
		$b_consolidacionPorPeriodo:=$3
End case 


  //If ($i_periodo>0)
  //If (($i_periodo>0) & ([Asignaturas]Consolidacion_PorPeriodo))  //20170530 RCH Si la configuración es anual, se debe guardar siempre en el nodo anual
If (($i_periodo>0) & ($b_consolidacionPorPeriodo))  //20170623 ASM 
	$t_nodo:="P"+String:C10($i_periodo)
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

If (Locked:C147([Asignaturas:18]))
	KRL_ReloadInReadWriteMode (->[Asignaturas:18])
End if 

C_OBJECT:C1216($objeto)
$objeto:=OB_Create 


If (Not:C34(OB Is defined:C1231([Asignaturas:18]Configuracion:63)))  //Si el objeto no está creado debemos cargar la con
	[Asignaturas:18]Configuracion:63:=OB_Create 
Else 
	$objeto:=[Asignaturas:18]Configuracion:63
End if 

OB_SET ($objeto;->alAS_EvalPropSourceID;$t_nodo+".SourceID")
OB_SET ($objeto;->atAS_EvalPropSourceName;$t_nodo+".SourceName")
OB_SET ($objeto;->atAS_EvalPropClassName;$t_nodo+".ClassName")
OB_SET ($objeto;->aiAS_EvalPropEnterable;$t_nodo+".Enterable")
OB_SET ($objeto;->arAS_EvalPropPercent;$t_nodo+".Percent")
OB_SET ($objeto;->arAS_EvalPropCoefficient;$t_nodo+".Coefficient")
OB_SET ($objeto;->abAS_EvalPropPrintDetail;$t_nodo+".PrintDetail")
OB_SET ($objeto;->atAS_EvalPropPrintName;$t_nodo+".PrintName")
OB_SET ($objeto;->atAS_EvalPropDescription;$t_nodo+".Description")
OB_SET ($objeto;->adAS_EvalPropDueDate;$t_nodo+".DueDate")

OB_SET ($objeto;->vlAS_CalcMethod;$t_nodo+".CalcMethod")
OB_SET ($objeto;->vi_DecimalesPonderacion;$t_nodo+".DecimalesPonderacion")
OB_SET ($objeto;->vi_PonderacionTruncada;$t_nodo+".PonderacionTruncada")
OB_SET ($objeto;->vi_ConsolidaExamenFinal;$t_nodo+".ConsolidaExamenFinal")
OB_SET ($objeto;->vi_ConsolidaNotasFinales;$t_nodo+".ConsolidaNotasFinales")

OB_SET ($objeto;->ad_BloqueoParcial_p1;"LimiteIngresoParciales_P1")
OB_SET ($objeto;->ad_BloqueoParcial_p2;"LimiteIngresoParciales_P2")
OB_SET ($objeto;->ad_BloqueoParcial_p3;"LimiteIngresoParciales_P3")
OB_SET ($objeto;->ad_BloqueoParcial_p4;"LimiteIngresoParciales_P4")
OB_SET ($objeto;->ad_BloqueoParcial_p5;"LimiteIngresoParciales_P5")

  //C_OBJECT($objeto)
  //$objeto:=[Asignaturas]Configuracion
[Asignaturas:18]Configuracion:63:=$objeto
If ($b_salvar)
	SAVE RECORD:C53([Asignaturas:18])
End if 