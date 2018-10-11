  //$msg:="Usted modificó el código del Plan de Estudio."+◊cr+"Por defecto este cambio solo se aplicará a los cursos del nivel que lo "+"utilizaban."+◊cr+◊cr+"Si desea que el cambio se aplique a todos los cursos del nivel, pulse el botón "+"Aplicar s."
  //$msg:=$msg+◊cr+"Por defecto este cambio solo se aplicará a los cursos del nivel que lo "+"utilizaban."
  //$msg:=$msg+◊cr+◊cr+"Si desea que el cambio se aplique a todos los cursos del nivel, pulse el botón "+ST_Qte ("Aplicar a todos")+"."
$result:=CD_Dlog (0;__ ("Usted modificó el código del Plan de Estudio.\rPor defecto este cambio solo se aplicará a los cursos del nivel que lo utilizaban.\r\rSi desea que el cambio se aplique a todos los cursos del nivel, pulse el botón Aplicar a todos.");"";__ ("Aplicar");__ ("Aplicar a todos");__ ("Cancelar"))

TRACE:C157
Case of 
	: ($result=3)
		[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40:=Old:C35([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40)
	: ($result=2)
		READ WRITE:C146([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
		ARRAY LONGINT:C221(al_Long1;Records in selection:C76([Cursos:3]))
		SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoPlanEstudios:23;al_Long1)
		For ($i;1;Size of array:C274(al_Long1))
			al_Long1{$i}:=[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40
		End for 
		OK:=KRL_Array2Selection (->al_Long1;->[Cursos:3]cl_CodigoPlanEstudios:23)
		READ ONLY:C145([Cursos:3])
		SAVE RECORD:C53([xxSTR_Niveles:6])
	: ($result=1)
		READ WRITE:C146([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
		QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_CodigoPlanEstudios:23=(Old:C35([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40)))
		ARRAY TEXT:C222(<>aText1;Records in selection:C76([Cursos:3]))
		SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoPlanEstudios:23;al_Long1)
		For ($i;1;Size of array:C274(al_Long1))
			al_Long1{$i}:=[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40
		End for 
		OK:=KRL_Array2Selection (->al_Long1;->[Cursos:3]cl_CodigoPlanEstudios:23)
		READ ONLY:C145([Cursos:3])
		SAVE RECORD:C53([xxSTR_Niveles:6])
End case 