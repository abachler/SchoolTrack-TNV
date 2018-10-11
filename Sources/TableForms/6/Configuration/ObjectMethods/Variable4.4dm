C_LONGINT:C283($ref;$subList)
C_TEXT:C284($text)
GET LIST ITEM:C378(hl_tipoEducacion;Selected list items:C379(hl_tipoEducacion);$ref;$text;$sublist)
Case of 
	: ($ref=0)
		
	: ($ref=1)
		BEEP:C151
		If ([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41=0)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEducacion;1)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEducacion;[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
		End if 
		_O_REDRAW LIST:C382(hl_TipoEducacion)
	Else 
		[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41:=$ref
End case 


If ($ref>1)
	  //$msg:="Usted modificó el Tipo de Enseñanza del nivel."+◊cr+"Por defecto este cambio sólo se aplicará a los cursos del nivel que lo "+"utilizaban."+◊cr+◊cr+"Si desea que el cambio se aplique a todos los cursos del nivel, pulse el botón "+"Aplicaos."
	  //$msg:=$msg+◊cr+"Por defecto este cambio sólo se aplicará a los cursos del nivel que lo "+"utilizaban."
	  //$msg:=$msg+◊cr+◊cr+"Si desea que el cambio se aplique a todos los cursos del nivel, pulse el botón "+ST_Qte ("Aplicar a todos")+"."
	$result:=CD_Dlog (0;__ ("Usted modificó el Tipo de Enseñanza del nivel.\rPor defecto este cambio sólo se aplicará a los cursos del nivel que lo utilizaban.\r\rSi desea que el cambio se aplique a todos los cursos del nivel, pulse el botón Aplicar a todos.");"";__ ("Aplicar");__ ("Aplicar a todos");__ ("Cancelar"))
	
	Case of 
		: ($result=3)
			[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41:=Old:C35([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
			If ([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41=0)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEducacion;1)
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEducacion;[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
			End if 
			_O_REDRAW LIST:C382(hl_TipoEducacion)
		: ($result=2)
			READ WRITE:C146([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
			ARRAY LONGINT:C221(al_Long1;Records in selection:C76([Cursos:3]))
			SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;al_Long1)
			For ($i;1;Size of array:C274(al_Long1))
				al_Long1{$i}:=[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41
			End for 
			OK:=KRL_Array2Selection (->al_Long1;->[Cursos:3]cl_CodigoTipoEnseñanza:21)
			READ ONLY:C145([Cursos:3])
			SAVE RECORD:C53([xxSTR_Niveles:6])
		: ($result=1)
			READ WRITE:C146([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
			QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=(Old:C35([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)))
			ARRAY LONGINT:C221(al_Long1;Records in selection:C76([Cursos:3]))
			SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;al_Long1)
			For ($i;1;Size of array:C274(al_Long1))
				al_Long1{$i}:=[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41
			End for 
			OK:=KRL_Array2Selection (->al_Long1;->[Cursos:3]cl_CodigoTipoEnseñanza:21)
			READ ONLY:C145([Cursos:3])
			SAVE RECORD:C53([xxSTR_Niveles:6])
	End case 
End if 