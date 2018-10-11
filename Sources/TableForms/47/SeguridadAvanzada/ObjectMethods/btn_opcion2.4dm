Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Self:C308->=1)
			$y_opcion1:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion1")
			$y_opcion2:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion3")
			$y_opcion3:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion4")
			$y_opcion1->:=0
			$y_opcion2->:=0
			$y_opcion3->:=0
		End if 
End case 