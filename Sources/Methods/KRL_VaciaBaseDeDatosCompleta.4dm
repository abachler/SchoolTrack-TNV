//%attributes = {}
  // KRL_VaciaBaseDeDatosCompleta()
  // Por: Alberto Bachler K.: 20-04-15, 11:13:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_tablas:=Get last table number:C254
For ($i_tablas;1;$l_tablas)
	If (Is table number valid:C999($i_tablas))
		READ WRITE:C146(Table:C252($i_tablas)->)
		TRUNCATE TABLE:C1051(Table:C252($i_tablas)->)
	End if 
End for 
