//%attributes = {}
  // AScsd_DesconectaHijas_TODAS()
  // Por: Alberto Bachler K.: 21-03-14, 17:25:43
  //  ---------------------------------------------
  // Desconecta todas las asignaturas o subasignaturas actualmente asociadas a la madre cuyo ID es pasado en $1
  // Si el ID pasado en $1 es positivo se trata de una asignatura; si es negativo se trata de una subasignatura
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_cancelTrans;$b_EliminaSubasignaturas)
_O_C_INTEGER:C282($i_subasignaturas)
C_LONGINT:C283($l_IdAsignaturaMadre)

ARRAY LONGINT:C221($al_RecNumSubasignaturas;0)
ARRAY LONGINT:C221($aRecNum;0)
If (False:C215)
	C_BOOLEAN:C305(AScsd_DesconectaHijas_TODAS ;$0)
	C_LONGINT:C283(AScsd_DesconectaHijas_TODAS ;$1)
	C_BOOLEAN:C305(AScsd_DesconectaHijas_TODAS ;$2)
End if 



$l_IdAsignaturaMadre:=$1
$b_EliminaSubasignaturas:=$2
$b_cancelTrans:=False:C215

READ WRITE:C146([Asignaturas:18])

  //busco las referencias de consolidacion para la asignatura actual
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_IdAsignaturaMadre)

  // obtengo la lista de asignaturas que tinen alguna referencia apuntando a la asignatura actual
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;"")

  //conservo la selección de asignaturas que tenían referencias sobre la asignatura actual en un conjunto local
CREATE SET:C116([Asignaturas:18];"$temp")

  // elimino todas las referencias de consolidación apuntando a la asignatura actual
KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])

  // reutilizo el conjunto de asignaturas que tenían referencias de consolidación  a la asignatura actual
USE SET:C118("$temp")
  //recorro todas las asignaturas que consolidaban en la asignatura actual y elimino las referencias de consolidación
While (Not:C34(End selection:C36([Asignaturas:18])))
	If (Not:C34(KRL_IsRecordLocked (->[Asignaturas:18])))
		AScsd_LeeReferencias ([Asignaturas:18]Numero:1)  //leo las referencias de consolidación de cada asignatura
		
		  //si no hay ninguna referencia apuntando a otra asignaturas madres inicializo los campos de referencia única
		If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
			[Asignaturas:18]Consolidacion_Madre_Id:7:=0
			[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
			[Asignaturas:18]nivel_jerarquico:107:=0
			[Asignaturas:18]ordenGeneral:105:=String:C10([Asignaturas:18]posicion_en_informes_de_notas:36;"000")
		End if 
		SAVE RECORD:C53([Asignaturas:18])
		NEXT RECORD:C51([Asignaturas:18])
	Else 
		$b_cancelTrans:=True:C214
		LAST RECORD:C200([Asignaturas:18])
	End if 
End while 
SET_ClearSets ("$temp")
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignaturaMadre)

If ($b_EliminaSubasignaturas)
	QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$l_IdAsignaturaMadre)
	OK:=KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])
	If (OK=0)
		$b_cancelTrans:=True:C214
	Else 
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			For ($l_periodo;1;5)
				AS_PropEval_Lectura ("";$l_periodo)
				For ($i;1;Size of array:C274(alAS_EvalPropSourceID))
					If (alAS_EvalPropSourceID{$i}<0)
						atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
						atAS_EvalPropClassName{$i}:=""
						alAS_EvalPropSourceID{$i}:=0
						aiAS_EvalPropEnterable{$i}:=1
						arAS_EvalPropPercent{$i}:=0
						arAS_EvalPropCoefficient{$i}:=0
						abAS_EvalPropPrintDetail{$i}:=False:C215
						atAS_EvalPropPrintName{$i}:=""
						atAS_EvalPropDescription{$i}:=""
						adAS_EvalPropDueDate{$i}:=!00-00-00!
						arAS_EvalPropPonderacion{$i}:=0
					End if 
				End for 
				AS_PropEval_Escritura ($l_periodo)
			End for 
			
		Else 
			AS_PropEval_Lectura ("";0)
			For ($i;1;Size of array:C274(alAS_EvalPropSourceID))
				If (alAS_EvalPropSourceID{$i}<0)
					atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
					atAS_EvalPropClassName{$i}:=""
					alAS_EvalPropSourceID{$i}:=0
					aiAS_EvalPropEnterable{$i}:=1
					arAS_EvalPropPercent{$i}:=0
					arAS_EvalPropCoefficient{$i}:=0
					abAS_EvalPropPrintDetail{$i}:=False:C215
					atAS_EvalPropPrintName{$i}:=""
					atAS_EvalPropDescription{$i}:=""
					adAS_EvalPropDueDate{$i}:=!00-00-00!
					arAS_EvalPropPonderacion{$i}:=0
				End if 
			End for 
			AS_PropEval_Escritura (0)
		End if 
	End if 
Else 
	QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$l_IdAsignaturaMadre)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Subasignaturas:83];$al_RecNumSubasignaturas;"")
	For ($i_subasignaturas;1;Size of array:C274($al_RecNumSubasignaturas))
		KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$al_RecNumSubasignaturas{$i_subasignaturas};True:C214)
		If (OK=1)
			[xxSTR_Subasignaturas:83]Columna:13:=0
			SAVE RECORD:C53([xxSTR_Subasignaturas:83])
		Else 
			$i_subasignaturas:=Size of array:C274($al_RecNumSubasignaturas)
			$b_cancelTrans:=True:C214
		End if 
	End for 
End if 

$0:=$b_cancelTrans
  //END OF METHOD

