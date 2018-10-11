  // [BBL_Items].Input.Botón invisible()
  // Por: Alberto Bachler: 20/11/13, 13:35:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_elemento;$l_id;$l_itemSeleccionado)
C_TEXT:C284($t_actual)

ARRAY LONGINT:C221($al_IdProfesores;0)
ARRAY TEXT:C222($at_profesores;0)
READ ONLY:C145([Profesores:4])
ALL RECORDS:C47([Profesores:4])
SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;$at_profesores;[Profesores:4]Numero:1;$al_IdProfesores)
SORT ARRAY:C229($at_profesores;$al_IdProfesores;>)
QUERY SELECTION BY FORMULA:C207([Profesores:4];([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)=vRespName)
If (Records in selection:C76([Profesores:4])=1)
	$t_actual:=[Profesores:4]Apellidos_y_nombres:28
Else 
	If (vRespName="")
		$t_actual:=__ ("Utilizar nombre y firma del profesor jefe")
	End if 
End if 

INSERT IN ARRAY:C227($at_profesores;1;2)
INSERT IN ARRAY:C227($al_IdProfesores;1;2)
$at_profesores{1}:=__ ("Utilizar nombre y firma del profesor jefe")
$at_profesores{2}:="(-"
$al_IdProfesores{1}:=0
$al_IdProfesores{0}:=0

$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_profesores;->$t_actual;OBJECT Get name:C1087(Object current:K67:2))
Case of 
	: ($l_itemSeleccionado>=3)
		$l_id:=$al_IdProfesores{$l_itemSeleccionado}
		KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->$l_id;False:C215)
		vRespName:=ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)
	: (($l_itemSeleccionado=1) | ($l_itemSeleccionado=2))  //20180122 //TICKET ABC 196461 
		vRespName:=""
End case 
ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)


