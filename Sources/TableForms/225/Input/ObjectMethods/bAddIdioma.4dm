C_LONGINT:C283($ultimoID)
$ultimoID:=a_LB_IdLenguaMaterna{Size of array:C274(a_LB_IdLenguaMaterna)}
APPEND TO ARRAY:C911(a_LB_IdLenguaMaterna;$ultimoID+1)
APPEND TO ARRAY:C911(a_LB_LenguaMaterna;"Ingrese un idioma")

OBJECT SET ENABLED:C1123(*;"bRemoveIdioma";(Size of array:C274(a_LB_LenguaMaterna)>0))