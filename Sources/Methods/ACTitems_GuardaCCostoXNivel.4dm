//%attributes = {}
  //ACTitems_GuardaCCostoXNivel
  // Modificado por: Saúl Ponce (09-12-2016)
  // Se modifica para aceptar un parámetro que indica cuál campo es el que se debe guardar ([xxACT_Items]xCentro_Costo / [xxACT_Items]ContaMonedaPagoPais)

If (Count parameters:C259=1)
	C_POINTER:C301($vy_punteroCampo)
	$vy_punteroCampo:=$1
Else 
	$vy_punteroCampo:=->[xxACT_Items:179]xCentro_Costo:41
End if 


C_REAL:C285($r_offSet)
ARRAY LONGINT:C221($alACT_elementos;0)
C_BOOLEAN:C305(vbACTcfg_EnItemsEsp)
C_POINTER:C301($vy_pointer2Field)
C_BLOB:C604($xBlob)

abACT_CCXN_UsarConfItem{0}:=False:C215
AT_SearchArray (->abACT_CCXN_UsarConfItem;"=";->$alACT_elementos)

If (vbACTcfg_EnItemsEsp)
	$vy_pointer2Field:=->vx_CentroCostoXNivel
Else 
	  //$vy_pointer2Field:=->[xxACT_Items]xCentro_Costo
	$vy_pointer2Field:=$vy_punteroCampo
End if 

If (Size of array:C274($alACT_elementos)>0)
	  //$r_offSet:=BLOB_Variables2Blob (->$xBlob;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID)
	$r_offSet:=BLOB_Variables2Blob (->$xBlob;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID;->atACT_CCXN_CodAux;->atACT_CCXN_CodPlanCtas;->atACT_CCXN_CodAuxCC;->atACT_CCXN_CodPlanCCtas)
	$vy_pointer2Field->:=$xBlob
Else 
	SET BLOB SIZE:C606($vy_pointer2Field->;0)
End if 

ACTcfg_DeclaraArreglos ("ACTcfgitems_CentroCostoXNivel")