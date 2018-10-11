  // [BBL_Prestamos].ListaPrestamos_Items.Botón invisible()
  // Por: Alberto Bachler K.: 19-02-14, 05:40:11
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_recNumPrestamo;$l_selectedRecord)

OBJECT SET VISIBLE:C603(*;"rectangulo1";True:C214)
$l_recNumPrestamo:=Num:C11(OBJECT Get title:C1068(*;"l_recNumPrestamo"))
$l_selectedRecord:=Num:C11(OBJECT Get title:C1068(*;"l_selectedRecord"))
If ($l_selectedRecord>0)
	GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selectedRecord)
End if 

