//%attributes = {}
  // 4D_ListaIDsTablasDisponibles()
  // 
  //
  // creado por: Alberto Bachler Klein: 21-10-16, 16:14:14
  // -----------------------------------------------------------


ARRAY LONGINT:C221($al_idDisponibles;0)

$t_IdTablasDisponibles:=""
For ($i;1;Get last table number:C254)
	If (Not:C34(Is table number valid:C999($i)))
		APPEND TO ARRAY:C911($al_idDisponibles;$i)
	End if 
End for 

SORT ARRAY:C229($al_idDisponibles;<)
$t_primerIdDisponible:="La próxima tabla agregada tomará el ID: "+String:C10($al_idDisponibles{1})
DELETE FROM ARRAY:C228($al_idDisponibles;1)
$t_siguientesIDs:="\r\rLas tablas que se agreguen después tomarán los IDs: "+AT_array2text (->$al_idDisponibles;", ")

ALERT:C41("Números de tablas disponibles\r\r"+$t_primerIdDisponible+$t_siguientesIDs)
