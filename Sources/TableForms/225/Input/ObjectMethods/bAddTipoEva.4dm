C_LONGINT:C283($ultimoID)
$ultimoID:=a_LB_IdTipoEva{Size of array:C274(a_LB_IdTipoEva)}
APPEND TO ARRAY:C911(a_LB_IdTipoEva;$ultimoID+1)
APPEND TO ARRAY:C911(a_LB_TipoEVA;"Ingrese un tipo de evaluación")

OBJECT SET ENABLED:C1123(*;"bRemoveTipoEVa";(Size of array:C274(a_LB_IdTipoEva)=0))
