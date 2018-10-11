//%attributes = {}
  //FQR_Prestamos

RELATE MANY:C262([BBL_Items:61]Numero:1)
SELECTION TO ARRAY:C260([BBL_Registros:66]Número_de_préstamos:22;aInt1)
$0:=AT_GetSumArray (->aInt1)