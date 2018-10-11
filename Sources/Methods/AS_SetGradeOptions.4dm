//%attributes = {}
  // MÉTODO: AS_SetGradeOptions
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 13:47:40
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_SetGradeOptions()
  // ----------------------------------------------------
C_LONGINT:C283($1)

C_BLOB:C604($x_RecNumsArray)
C_BOOLEAN:C305($b_recalc)
C_LONGINT:C283($l_elemento;$l_resultado;$l_resultado)
C_REAL:C285($r_coeficienteAnterior;$r_ponderacionAnterior;$r_sumaPonderaciones)

ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
If (False:C215)
	C_LONGINT:C283(AS_SetGradeOptions ;$1)
End if 

  // CODIGO PRINCIPAL

vi_Parcial:=$1
$b_recalc:=False:C215

AS_PropEval_Lectura 

$l_elemento:=Find in array:C230(aiAS_EvalPropColumnIndex;vi_Parcial)
If ($l_elemento>0)
	$r_coeficienteAnterior:=arAS_EvalPropCoefficient{$l_elemento}
	$r_ponderacionAnterior:=arAS_EvalPropPercent{$l_elemento}
Else 
	$r_coeficienteAnterior:=1
	$r_ponderacionAnterior:=0
End if 

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ (".\r\rNo se guardara ningún cambio en las propiedades de evaluación."))
End if 
WDW_OpenDialogInDrawer (->[Asignaturas:18];"EvalProp_Col")
If (ok=1)
	
	If (vlAS_CalcMethod=2)
		$r_sumaPonderaciones:=AT_GetSumArray (->arAS_EvalPropPonderacion)-$r_ponderacionAnterior+vrAS_ColPropPonderacion
		Case of 
			: (($r_sumaPonderaciones=0) | ($r_sumaPonderaciones=100))
			: ($r_sumaPonderaciones<100)
				$l_resultado:=CD_Dlog (0;__ ("Recuerde que la suma de los pesos relativos de consolidación debe ser superior o igual a 100."))
			Else 
				$l_resultado:=CD_Dlog (0;__ ("La suma total de ponderaciones es superior a 100%.\rSi las ponderaciones de las evaluaciones registradas para un alumno superan el 100%, el promedio calculado es dividido por la suma de ponderaciones y multiplicado por 100.\r")+__ ("\rPuede utilizar esta forma de cálculo pero deberá asegurarse que la suma de ponderaciones para cada alumno no sea superior a 100%\r\r¿Desea continuar utilizando esta forma de cálculo?");__ ("");__ ("No");__ ("Si"))
				If ($l_resultado=2)
				Else 
					vrAS_ColPropPonderacion:=arAS_EvalPropPonderacion{vi_Parcial}
				End if 
		End case 
	End if 
	
	If (vrAS_ColPropPonderacion#arAS_EvalPropPonderacion{vi_Parcial})
		$b_recalc:=True:C214
		arAS_EvalPropPonderacion{vi_Parcial}:=vrAS_ColPropPonderacion
		Case of 
			: (vlAS_CalcMethod=0)
				arAS_EvalPropCoefficient{vi_Parcial}:=vrAS_ColPropPonderacion
			: (vlAS_CalcMethod=1)
				arAS_EvalPropCoefficient{vi_Parcial}:=vrAS_ColPropPonderacion
			: (vlAS_CalcMethod=2)
				arAS_EvalPropPercent{vi_Parcial}:=vrAS_ColPropPonderacion
		End case 
	End if 
	
	adAS_EvalPropDueDate{vi_Parcial}:=vdAS_ColPropDueDate
	atAS_EvalPropDescription{vi_Parcial}:=vtAS_ColPropDescription
	atAS_EvalPropPrintName{vi_Parcial}:=vsAS_ColPropPrintName
	abAS_EvalPropPrintDetail{vi_Parcial}:=(viAS_ColPropPrintDetail=1)
	
	AS_PropEval_Escritura (vlSTR_PeriodoSeleccionado)  //MONO CAMBIO AS_PropEval_Escritura - Revisar Caso de llamado debido a que se está pasando un elemento de la interfaz.
	If ($b_recalc)
		APPEND TO ARRAY:C911($al_RecNumsAsignaturas;Record number:C243([Asignaturas:18]))
		BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
		EV2dbu_Recalculos ($x_RecNumsArray)
	End if 
	AS_PaginaEvaluacion 
End if 