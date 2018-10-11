Case of 
	: (Self:C308->=0)
		f1:=1
		f2:=0
	: (Self:C308-><5)
		CD_Dlog (0;__ ("El tamaño de fuente no puede ser inferior a 5 ni superior a 9."))
		Self:C308->:=5
		f1:=0
		f2:=1
	: (Self:C308->>9)
		CD_Dlog (0;__ ("El tamaño de fuente no puede ser inferior a 5 ni superior a 9."))
		Self:C308->:=9
		f1:=0
		f2:=1
	Else 
		f1:=0
		f2:=1
End case 