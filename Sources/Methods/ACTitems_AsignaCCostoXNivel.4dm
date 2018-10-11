//%attributes = {}
  //ACTitems_AsignaCCostoXNivel

C_LONGINT:C283($l_idItem;$1)
C_BOOLEAN:C305($b_hecho;$0)

$l_idItem:=$1
$b_hecho:=False:C215

KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem;True:C214)
If (ok=1)
	
	If (BLOB size:C605([xxACT_Items:179]xCentro_Costo:41)=0)
		$b_hecho:=True:C214
	Else 
		  //ACTitems_ActualizaCCostoXNivel 
		ARRAY LONGINT:C221($alACT_posiciones;0)
		C_LONGINT:C283($l_lineaItem)
		ACTitems_LeeCentrosCostoXNivel ($l_idItem)
		abACT_CCXN_UsarConfItem{0}:=True:C214
		AT_SearchArray (->abACT_CCXN_UsarConfItem;"=";->$alACT_posiciones)
		For ($l_lineaItem;1;Size of array:C274($alACT_posiciones))
			atACT_CCXN_CentroCosto{$alACT_posiciones{$l_lineaItem}}:=[xxACT_Items:179]Centro_de_Costos:21
			atACT_CCXN_CentroCostoContra{$alACT_posiciones{$l_lineaItem}}:=[xxACT_Items:179]CCentro_de_costos:23
		End for 
		ACTitems_GuardaCCostoXNivel 
		SAVE RECORD:C53([xxACT_Items:179])
		
		$b_hecho:=True:C214
	End if 
	
Else 
	If (Records in selection:C76([xxACT_Items:179])=0)
		$b_hecho:=True:C214
	End if 
End if 
KRL_UnloadReadOnly (->[xxACT_Items:179])

$0:=$b_hecho
