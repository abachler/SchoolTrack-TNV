//%attributes = {}
  // BUILD_Start()
  // 
  //
  // creado por: Alberto Bachler Klein: 29-07-16, 17:55:49
  // -----------------------------------------------------------

$l_refVentana:=Open form window:C675("BUILD_Generacion";Plain form window:K39:10;On the left:K39:2;At the top:K39:5)
DIALOG:C40("BUILD_Generacion")
CLOSE WINDOW:C154

If (OK=1)
	QUIT 4D:C291
End if 

