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

If ([Colegio:31]Director_IdFuncionario:61>0)
	$l_elemento:=Find in array:C230($al_IdProfesores;[Colegio:31]Director_IdFuncionario:61)
	If ($l_elemento>0)
		$t_actual:=$at_profesores{$l_elemento}
	End if 
End if 

INSERT IN ARRAY:C227($at_profesores;1;2)
INSERT IN ARRAY:C227($al_IdProfesores;1;2)
$at_profesores{1}:=__ ("Ninguno")
$at_profesores{2}:="(-"
$al_IdProfesores{1}:=0
$al_IdProfesores{0}:=0


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_profesores;->$t_actual;OBJECT Get name:C1087(Object current:K67:2))
Case of 
	: ($l_itemSeleccionado>=3)
		$l_id:=$al_IdProfesores{$l_itemSeleccionado}
		KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->$l_id;False:C215)
		[Colegio:31]Director_ApellidoMaterno:19:=[Profesores:4]Apellido_materno:4
		[Colegio:31]Director_ApellidoPaterno:18:=[Profesores:4]Apellido_paterno:3
		[Colegio:31]Director_Nombres:20:=[Profesores:4]Nombres:2
		[Colegio:31]Director_NombreCompleto:13:=ST_ClearSpaces ([Colegio:31]Director_Nombres:20+" "+[Colegio:31]Director_ApellidoPaterno:18+" "+[Colegio:31]Director_ApellidoMaterno:19)
		[Colegio:31]Director_RUN:28:=[Profesores:4]RUT:27
		[Colegio:31]Director_IdFuncionario:61:=[Profesores:4]Numero:1
		  //: ($l_itemSeleccionado=0)
	: (($l_itemSeleccionado=0) | ($l_itemSeleccionado=1))
		[Colegio:31]Director_ApellidoMaterno:19:=""
		[Colegio:31]Director_ApellidoPaterno:18:=""
		[Colegio:31]Director_NombreCompleto:13:=""
		[Colegio:31]Director_Nombres:20:=""
		[Colegio:31]Director_RUN:28:=""
		[Colegio:31]Director_IdFuncionario:61:=0
End case 

