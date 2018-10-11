//%attributes = {}
  //EVS_GetEvStyleREALValue

C_BLOB:C604($blob)
C_REAL:C285($1;$0;$result)
_O_C_STRING:C293(255;$PropertyName)
$result:=-9999
$StyleID:=$1
$PropertyName:=$2

$recNum:=Find in field:C653([xxSTR_EstilosEvaluacion:44]ID:1;$styleID)
KRL_GotoRecord (->[xxSTR_EstilosEvaluacion:44];$recNum)
If (OK=1)
	$blob:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
	$OTref:=OT BLOBToObject ($blob)
	$result:=OT GetReal ($OTref;$PropertyName)
	OT Clear ($OTref)
Else 
	CD_Dlog (0;__ ("Error: Estilo de evaluación inexistente."))
End if 

$0:=$result
