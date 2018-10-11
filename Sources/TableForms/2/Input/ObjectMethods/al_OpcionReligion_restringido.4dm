vTipo:="ALU"
WDW_OpenFormWindow (->[xxSTR_MetaReligionValues:164];"Input";0;-Palette form window:K39:9)
DIALOG:C40([xxSTR_MetaReligionValues:164];"Input")
CLOSE WINDOW:C154
For ($i;1;Size of array:C274(aRecNums))
	If (aRecNums{$i}=-1)
		CREATE RECORD:C68([xxSTR_MetaReligionValues:164])
		[xxSTR_MetaReligionValues:164]Fecha:5:=aFechaEfemeride{$i}
		[xxSTR_MetaReligionValues:164]ID_Alumno:2:=[Alumnos:2]numero:1
		[xxSTR_MetaReligionValues:164]ID_Efemeride:1:=aIDEfemeride{$i}
		SAVE RECORD:C53([xxSTR_MetaReligionValues:164])
	Else 
		READ WRITE:C146([xxSTR_MetaReligionValues:164])
		GOTO RECORD:C242([xxSTR_MetaReligionValues:164];aRecNums{$i})
		[xxSTR_MetaReligionValues:164]Fecha:5:=aFechaEfemeride{$i}
		SAVE RECORD:C53([xxSTR_MetaReligionValues:164])
	End if 
	KRL_UnloadReadOnly (->[xxSTR_MetaReligionValues:164])
End for 