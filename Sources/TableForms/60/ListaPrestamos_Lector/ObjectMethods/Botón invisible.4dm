  // [BBL_Prestamos].ListaPrestamos_Lector.Botón invisible()
  // Por: Alberto Bachler: 05/11/13, 18:55:11
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

OBJECT SET VISIBLE:C603(*;"rectangulo1";True:C214)
$l_recNumPrestamo:=Num:C11(OBJECT Get title:C1068(*;"$l_recNumPrestamo"))
$l_selectedRecord:=Num:C11(OBJECT Get title:C1068(*;"$l_selectedRecord"))
If ($l_selectedRecord>0)
	GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selectedRecord)
End if 


