If (Form event:C388=On Load:K2:1)
	C_LONGINT:C283($i;$j;$Males;$Females)
	RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
	$males:=0
	$females:=0
	
	ARRAY TEXT:C222(<>aText1;0)
	ARRAY TEXT:C222(<>aText2;0)
	ARRAY TEXT:C222(<>aText3;0)
	ARRAY TEXT:C222(<>aText4;0)
	Case of 
		: (vt_PLConfigMessage="byName")
			prClassbyName (Self:C308)
		: (vt_PLConfigMessage="BySex")
			prClassBySex (Self:C308)
		: (vt_PLConfigMessage="byGroup")
			prClassByGrp (Self:C308)
		: (vt_PLConfigMessage="byNationality")
			prClassByNac (Self:C308)
		: (vt_PLConfigMessage="bylocality")
			prClassbyLoc (Self:C308)
	End case 
End if 







