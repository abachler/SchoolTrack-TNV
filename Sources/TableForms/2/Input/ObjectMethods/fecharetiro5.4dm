  // [Alumnos].Input.Botón invisible()
  // Por: Alberto Bachler: 14/11/13, 10:01:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If ([Alumnos:2]Status:50="Retirado@")
	WDW_OpenFormWindow (->[Alumnos:2];"Retiros";-1;Movable form dialog box:K39:8)
	DIALOG:C40([Alumnos:2];"Retiros")
	CLOSE WINDOW:C154
End if 




