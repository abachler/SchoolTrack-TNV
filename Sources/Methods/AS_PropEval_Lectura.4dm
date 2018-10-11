//%attributes = {}
  // MÉTODO: AS_PropEval_Lectura
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 21/12/11, 10:45:22
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_PropEval_Lectura()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_actualizarPropiedades)
C_LONGINT:C283($i;$l_ID_Asignatura;$l_numeroPeriodo;$l_RecordNumberAsignatura;$l_RecordNumberAsignaturaHija)
C_REAL:C285($r_totalCoeficientes;$r_totalPonderaciones)
C_TEXT:C284($t_llaveSubasignatura;$t_NombreRegistroPropiedades)
C_LONGINT:C283($l_numeroPeriodoObj)  //20170531 RCH

C_LONGINT:C283(vi_DecimalesPonderacion;vi_PonderacionTruncada;vi_ConsolidaExamenFinal;vi_ConsolidaNotasFinales)

C_TEXT:C284(vt_UltimasPropiedadesLeidas)

If (False:C215)
	C_TEXT:C284(AS_PropEval_Lectura ;$1)
	C_LONGINT:C283(AS_PropEval_Lectura ;$2)
End if 

  // CODIGO PRINCIPAL
Case of 
	: (Count parameters:C259=2)
		$l_numeroPeriodo:=$2
		$t_NombreRegistroPropiedades:=$1
	: (Count parameters:C259=1)
		$l_numeroPeriodo:=atSTR_Periodos_Nombre
		$t_NombreRegistroPropiedades:=$1
	Else 
		$t_NombreRegistroPropiedades:=""
		$l_numeroPeriodo:=atSTR_Periodos_Nombre
End case 

If ($t_NombreRegistroPropiedades="")
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		$t_nodo:="P"+String:C10($l_numeroPeriodo)
	Else 
		$t_nodo:="Anual"
	End if 
	$t_NombreRegistroPropiedades:=$t_nodo
Else 
	$t_nodo:=$t_NombreRegistroPropiedades
End if 

  //If (Not([Asignaturas]Consolidacion_PorPeriodo))  //20170530 RCH Había problemas con la lectura desde la verificación de vínculos de subasignaturas
  //$l_numeroPeriodo:=0
  //$t_nodo:="Anual"
  //End if 
$l_numeroPeriodoObj:=$l_numeroPeriodo  //20170531 RCH
If (Not:C34([Asignaturas:18]Consolidacion_PorPeriodo:58))  //20170530 RCH Había problemas con la lectura desde la verificación de vínculos de subasignaturas
	$l_numeroPeriodoObj:=0
	$t_nodo:="Anual"
End if 


$t_NombreRegistroPropiedades:=$t_NombreRegistroPropiedades+"."+[Asignaturas:18]auto_uuid:12

  //If ($t_NombreRegistroPropiedades#vt_UltimasPropiedadesLeidas)
vt_UltimasPropiedadesLeidas:=$t_NombreRegistroPropiedades

$l_ID_Asignatura:=[Asignaturas:18]Numero:1
$l_RecordNumberAsignatura:=Record number:C243([Asignaturas:18])

  //MAIN CODE
vlAS_CalcMethod:=0
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
ARRAY REAL:C219(arAS_EvalPropPonderacion;0)

  //MONO
ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
ARRAY DATE:C224(ad_BloqueoParcial_p5;0)

If (Not:C34(Is new record:C668([Asignaturas:18])))
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	atSTR_Periodos_Nombre:=$l_numeroPeriodo  //reestablezco el periodo pasado en argumento (puede haber sido cambiado por el período actual al llamar a Periodos_LoadData))
End if 

AS_CreateConfigObj 

OB_GET ([Asignaturas:18]Configuracion:63;->alAS_EvalPropSourceID;$t_nodo+".SourceID")
OB_GET ([Asignaturas:18]Configuracion:63;->atAS_EvalPropSourceName;$t_nodo+".SourceName")
OB_GET ([Asignaturas:18]Configuracion:63;->atAS_EvalPropClassName;$t_nodo+".ClassName")
OB_GET ([Asignaturas:18]Configuracion:63;->aiAS_EvalPropEnterable;$t_nodo+".Enterable")
OB_GET ([Asignaturas:18]Configuracion:63;->arAS_EvalPropPercent;$t_nodo+".Percent")
OB_GET ([Asignaturas:18]Configuracion:63;->arAS_EvalPropCoefficient;$t_nodo+".Coefficient")
OB_GET ([Asignaturas:18]Configuracion:63;->abAS_EvalPropPrintDetail;$t_nodo+".PrintDetail")
OB_GET ([Asignaturas:18]Configuracion:63;->atAS_EvalPropPrintName;$t_nodo+".PrintName")
OB_GET ([Asignaturas:18]Configuracion:63;->atAS_EvalPropDescription;$t_nodo+".Description")
OB_GET ([Asignaturas:18]Configuracion:63;->adAS_EvalPropDueDate;$t_nodo+".DueDate";"DD/MM/YYYY")

OB_GET ([Asignaturas:18]Configuracion:63;->vlAS_CalcMethod;$t_nodo+".CalcMethod")
OB_GET ([Asignaturas:18]Configuracion:63;->vi_DecimalesPonderacion;$t_nodo+".DecimalesPonderacion")
OB_GET ([Asignaturas:18]Configuracion:63;->vi_PonderacionTruncada;$t_nodo+".PonderacionTruncada")
OB_GET ([Asignaturas:18]Configuracion:63;->vi_ConsolidaExamenFinal;$t_nodo+".ConsolidaExamenFinal")
OB_GET ([Asignaturas:18]Configuracion:63;->vi_ConsolidaNotasFinales;$t_nodo+".ConsolidaNotasFinales")

OB_GET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p1;"LimiteIngresoParciales_P1";"DD/MM/YYYY")
OB_GET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p2;"LimiteIngresoParciales_P2";"DD/MM/YYYY")
OB_GET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p3;"LimiteIngresoParciales_P3";"DD/MM/YYYY")
OB_GET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p4;"LimiteIngresoParciales_P4";"DD/MM/YYYY")
OB_GET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p5;"LimiteIngresoParciales_P5";"DD/MM/YYYY")

AT_RedimArrays (12;->alAS_EvalPropSourceID;->atAS_EvalPropSourceName;->atAS_EvalPropClassName;->aiAS_EvalPropEnterable;->arAS_EvalPropPercent;->arAS_EvalPropCoefficient;->abAS_EvalPropPrintDetail;->atAS_EvalPropPrintName;->atAS_EvalPropDescription;->adAS_EvalPropDueDate;->arAS_EvalPropPonderacion)
AT_RedimArrays (12;->ad_BloqueoParcial_p1;->ad_BloqueoParcial_p2;->ad_BloqueoParcial_p3;->ad_BloqueoParcial_p4;->ad_BloqueoParcial_p5)

$b_actualizarPropiedades:=False:C215
ARRAY LONGINT:C221(aiAS_EvalPropColumnIndex;12)  //index destination
For ($i;1;12)
	aiAS_EvalPropColumnIndex{$i}:=$i
	Case of 
		: (alAS_EvalPropSourceID{$i}<0)
			If ((atAS_EvalPropSourceName{$i}="") | (atAS_EvalPropSourceName{$i}="No Ingresable") | (atAS_EvalPropSourceName{$i}="Evaluación ingresable"))
				$t_llaveSubasignatura:=String:C10($l_ID_Asignatura)+"."+String:C10($l_numeroPeriodo)+"."+String:C10($i)
				$l_RecordNumberAsignaturaHija:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$t_llaveSubasignatura)
				If ($l_RecordNumberAsignaturaHija>=0)
					GOTO RECORD:C242([xxSTR_Subasignaturas:83];$l_RecordNumberAsignaturaHija)  //reestablecemos el nombre y volvemos al registro actual
					$t_nombreSubasignatura:=[xxSTR_Subasignaturas:83]Name:2
					GOTO RECORD:C242([Asignaturas:18];$l_RecordNumberAsignatura)
					If (atAS_EvalPropSourceName{$i}#$t_nombreSubasignatura)
						atAS_EvalPropSourceName{$i}:=$t_nombreSubasignatura
						$b_actualizarPropiedades:=True:C214
					End if 
				End if 
			Else 
				$t_llaveSubasignatura:=String:C10($l_ID_Asignatura)+"."+String:C10($l_numeroPeriodo)+"."+String:C10($i)
				$l_RecordNumberAsignaturaHija:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$t_llaveSubasignatura)
			End if 
			
		: (alAS_EvalPropSourceID{$i}>0)
			  //actualizo el nombre la asignatura en caso que hubiese sido modificado. Válido también para el curso
			  //El nombre para impresión no es modifcado ya que se puede haber establecido un nombre distinto al nombre de la asignatura
			$l_RecordNumberAsignaturaHija:=Find in field:C653([Asignaturas:18]Numero:1;alAS_EvalPropSourceID{$i})
			If ($l_RecordNumberAsignaturaHija>=0)  //reestablecemos el nombre y volvemos al registro actual
				GOTO RECORD:C242([Asignaturas:18];$l_RecordNumberAsignaturaHija)
				$t_denominacionInterna:=[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]"
				GOTO RECORD:C242([Asignaturas:18];$l_RecordNumberAsignatura)
				If (atAS_EvalPropSourceName{$i}#$t_denominacionInterna)
					atAS_EvalPropSourceName{$i}:=$t_denominacionInterna  // ASM Ticket 183466 20170613
					$b_actualizarPropiedades:=True:C214
				End if 
			Else   //si la asignatura que consolidaba notas (origen de la evaluación) ya no existe
				If (alAS_EvalPropSourceID{$i}>0)
					alAS_EvalPropSourceID{$i}:=0
					aiAS_EvalPropEnterable{$i}:=1
					atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
					$b_actualizarPropiedades:=True:C214
				End if 
			End if 
			
		: ((alAS_EvalPropSourceID{$i}=0) & (aiAS_EvalPropEnterable{$i}=1))
			If (atAS_EvalPropSourceName{$i}#"Evaluación ingresable")
				atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
				$b_actualizarPropiedades:=True:C214
			End if 
			
		: (aiAS_EvalPropEnterable{$i}=0)
			If (atAS_EvalPropSourceName{$i}#"No ingresable")
				atAS_EvalPropSourceName{$i}:="No ingresable"
				$b_actualizarPropiedades:=True:C214
			End if 
			
	End case 
	
	If (Not:C34(abAS_EvalPropPrintDetail{$i}))
		If (atAS_EvalPropPrintName{$i}#"")
			atAS_EvalPropPrintName{$i}:=""
			$b_actualizarPropiedades:=True:C214
		End if 
	End if 
End for 

$r_totalPonderaciones:=0
For ($i;1;Size of array:C274(arAS_EvalPropPercent))
	$r_totalPonderaciones:=$r_totalPonderaciones+arAS_EvalPropPercent{$i}
End for 
$r_totalCoeficientes:=0
For ($i;1;Size of array:C274(arAS_EvalPropCoefficient))
	$r_totalCoeficientes:=$r_totalCoeficientes+arAS_EvalPropCoefficient{$i}
End for 

Case of 
	: ((vlAS_CalcMethod=0) & ($r_totalPonderaciones=100))
		vlAS_CalcMethod:=2
	: ((vlAS_CalcMethod=0) & ($r_totalCoeficientes#12) & ($r_totalCoeficientes>0))
		vlAS_CalcMethod:=1
End case 

Case of 
	: ((vlAS_CalcMethod=1) | (vlAS_CalcMethod=0))
		If (Size of array:C274(arAS_EvalPropCoefficient)<12)
			ARRAY REAL:C219(arAS_EvalPropCoefficient;12)
			For ($i;1;12)
				If (arAS_EvalPropCoefficient{$i}#1)
					arAS_EvalPropCoefficient{$i}:=1
					$b_actualizarPropiedades:=True:C214
				End if 
			End for 
			
			COPY ARRAY:C226(arAS_EvalPropCoefficient;arAS_EvalPropPonderacion)
		Else 
			COPY ARRAY:C226(arAS_EvalPropCoefficient;arAS_EvalPropPonderacion)
		End if 
	: (vlAS_CalcMethod=2)
		COPY ARRAY:C226(arAS_EvalPropPercent;arAS_EvalPropPonderacion)
End case 
If ($b_actualizarPropiedades)
	  //AS_PropEval_Escritura ($l_numeroPeriodo)  //MONO CAMBIO AS_PropEval_Escritura
	AS_PropEval_Escritura ($l_numeroPeriodoObj)  //20170531 RCH
End if 

  //End if 