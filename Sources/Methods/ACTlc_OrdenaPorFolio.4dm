//%attributes = {}
  //  ACTlc_OrdenaPorFolio 

C_LONGINT:C283($i)
ARRAY LONGINT:C221($al_recNum;0)
ARRAY LONGINT:C221($al_numSerie;0)
ARRAY TEXT:C222($at_numSerie;0)

SELECTION TO ARRAY:C260([ACT_Documentos_de_Pago:176];$al_recNum;[ACT_Documentos_de_Pago:176]NoSerie:12;$at_numSerie)
For ($i;1;Size of array:C274($at_numSerie))
	APPEND TO ARRAY:C911($al_numSerie;Num:C11($at_numSerie{$i}))
End for 

SORT ARRAY:C229($al_numSerie;$al_recNum;>)
CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Pago:176];$al_recNum;"")
