//%attributes = {}
  // AS_AbstractoConfiguracion()
  // Por: Alberto Bachler K.: 21-03-14, 15:39:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_tieneSubasignaturas;$b_utilizaCoeficientes;$b_utilizaPonderaciones)
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($i;$l_idAsignatura;$l_idAsignaturaHija)
C_TEXT:C284($t_asignaturaMadre;$t_falso;$t_madres;$t_nombreAsignatura;$t_verdadero)

ARRAY LONGINT:C221($al_IdAsignaturasHijas;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_AsignaturasMadres;0)
ARRAY TEXT:C222($at_refPeriodo;0)

If (False:C215)
	C_LONGINT:C283(AS_AbstractoConfiguracion ;$1)
End if 

$l_idAsignatura:=$1

vtEvalProperties:=""
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;$l_idAsignatura)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Consolidantes:231];$al_RecNums;"")
$t_madres:=""
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Asignaturas_Consolidantes:231];$al_RecNums{$i_registros})
	$t_asignaturaMadre:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;->[Asignaturas:18]denominacion_interna:16)
	$t_asignaturaMadre:=Replace string:C233($t_asignaturaMadre;"&";"and")
	If (Num:C11([Asignaturas_Consolidantes:231]Periodo:3)#0)
		$t_asignaturaMadre:=IT_SetTextStyle_Bold (->$t_asignaturaMadre)+" (P"+[Asignaturas_Consolidantes:231]Periodo:3+")"
	End if 
	
	QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5=[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
	If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
		APPEND TO ARRAY:C911($at_AsignaturasMadres;$t_asignaturaMadre+" –> ")
		$t_madres:=$t_madres+$t_asignaturaMadre+" –> "
		While (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
			$t_asignaturaMadre:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;->[Asignaturas:18]denominacion_interna:16)
			$t_asignaturaMadre:=Replace string:C233($t_asignaturaMadre;"&";"and")
			$t_asignaturaMadre:=IT_SetTextStyle_Bold (->$t_asignaturaMadre)
			If (Num:C11([Asignaturas_Consolidantes:231]Periodo:3)#0)
				$t_asignaturaMadre:=$t_asignaturaMadre+" (P"+[Asignaturas_Consolidantes:231]Periodo:3+")"
			End if 
			QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5=[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
			If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
				$t_madres:=$t_madres+$t_asignaturaMadre+" –> "
			Else 
				$t_madres:=$t_madres+$t_asignaturaMadre
			End if 
		End while 
	Else 
		If ($i<Size of array:C274($al_RecNums))
			$t_madres:=$t_madres+$t_asignaturaMadre+"; "
			APPEND TO ARRAY:C911($at_AsignaturasMadres;$t_asignaturaMadre+"; ")
		Else 
			APPEND TO ARRAY:C911($at_AsignaturasMadres;$t_asignaturaMadre)
			$t_madres:=$t_madres+$t_asignaturaMadre
		End if 
	End if 
End for 
If (Size of array:C274($at_AsignaturasMadres)>0)
	vtEvalProperties:=vtEvalProperties+__ ("Consolida en: ")+$t_madres
Else 
	vtEvalProperties:=vtEvalProperties+__ ("No consolida en ninguna otra Asignatura")
End if 



  // determino si esta asignatura tiene asignaturas hijas
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=;$l_idAsignatura)
If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
	vtEvalProperties:=vtEvalProperties+"\r"+__ ("Sin asignaturas consolidantes")
Else 
	SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_ParentRecord:5;$al_IdAsignaturasHijas;[Asignaturas_Consolidantes:231]Periodo:3;$at_refPeriodo)
	SORT ARRAY:C229($at_refPeriodo;$al_IdAsignaturasHijas;>)
	ARRAY TEXT:C222($at_nombreAsignaturas;Size of array:C274($al_IdAsignaturasHijas))
	For ($i;1;Size of array:C274($al_IdAsignaturasHijas))
		$l_idAsignaturaHija:=$al_IdAsignaturasHijas{$i}
		$t_nombreAsignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignaturaHija;->[Asignaturas:18]denominacion_interna:16)
		$t_nombreAsignatura:=Replace string:C233($t_nombreAsignatura;"&";"and")
		$t_nombreAsignatura:=IT_SetTextStyle_Bold (->$t_nombreAsignatura)
		If (($at_refPeriodo{$i}#"") & ($at_refPeriodo{$i}#"0"))
			$at_nombreAsignaturas{$i}:=$t_nombreAsignatura+" (P"+$at_refPeriodo{$i}+")"
		Else 
			$at_nombreAsignaturas{$i}:=$t_nombreAsignatura
		End if 
	End for 
	AT_MultiLevelSort (">>";->$at_refPeriodo;->$at_nombreAsignaturas)
	vtEvalProperties:=vtEvalProperties+"\r"+__ ("Asignaturas consolidantes: ")+AT_array2text (->$at_nombreAsignaturas;", ")
End if 

$t_falso:=__ ("No")
$t_verdadero:=("Si")

  // determino si esta asignatura tiene subasignaturas
For ($i;1;Size of array:C274(atAS_EvalPropSourceName))
	If (alAS_EvalPropSourceID{$i}<0)
		$b_tieneSubasignaturas:=True:C214
	End if 
End for 
vtEvalProperties:=vtEvalProperties+"\r"+__ ("Se evalúa en subasignaturas: ")+Choose:C955($b_tieneSubasignaturas;IT_SetTextStyle_Bold (->$t_verdadero);IT_SetTextStyle_Bold (->$t_falso))

  // determino si los promedios son calculados con notas ponderadas
For ($i;1;Size of array:C274(atAS_EvalPropSourceName))
	If (arAS_EvalPropPercent{$i}>0)
		$b_utilizaPonderaciones:=True:C214
	End if 
	If (arAS_EvalPropCoefficient{$i}>1)
		$b_utilizaCoeficientes:=True:C214
	End if 
End for 
vtEvalProperties:=vtEvalProperties+"\r"+__ ("Evaluaciones parciales ponderadas: ")+Choose:C955($b_utilizaPonderaciones;IT_SetTextStyle_Bold (->$t_verdadero);IT_SetTextStyle_Bold (->$t_falso))
vtEvalProperties:=vtEvalProperties+"\r"+__ ("Evaluaciones parciales con coeficientes: ")+Choose:C955($b_utilizaPonderaciones;IT_SetTextStyle_Bold (->$t_verdadero);IT_SetTextStyle_Bold (->$t_falso))

