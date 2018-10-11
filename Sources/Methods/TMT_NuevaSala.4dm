//%attributes = {}
  // TMT_NuevaSala()
  // Por: Alberto Bachler: 22/05/13, 08:36:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (USR_checkRights ("A";->[TMT_Horario:166]))
	WDW_OpenFormWindow (->[TMT_Salas:167];"Input";-1;8)
	FORM SET INPUT:C55([TMT_Salas:167];"Input")
	ADD RECORD:C56([TMT_Salas:167];*)
	CLOSE WINDOW:C154
	If (ok=1)
		TMT_CargaSalas 
	End if 
End if 


