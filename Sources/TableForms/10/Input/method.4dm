Case of 
	: (Form event:C388=On Load:K2:1)
		WDW_SlideDrawer (->[Alumnos_Inasistencias:10];"Input")
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		If (DateIsValid (Current date:C33(*);0))
			dFrom:=Current date:C33(*)
			dTo:=Current date:C33(*)
		Else 
			dFrom:=!00-00-00!
			dTo:=!00-00-00!
		End if 
		vt_observaciones:=""
		If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
			Case of 
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)=1) & (vLocation="browser"))
					READ ONLY:C145([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
					lID:=[Alumnos:2]numero:1
					sName:=[Alumnos:2]apellidos_y_nombres:40
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)>1) & (vLocation="browser"))
					sName:="("+String:C10(Size of array:C274(aBrSelect))+"Alumnos seleccionados)"
					OBJECT SET ENTERABLE:C238(sName;False:C215)
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (vLOcation#"Browser"))
					lID:=[Alumnos:2]numero:1
					sName:=[Alumnos:2]apellidos_y_nombres:40
					OBJECT SET ENTERABLE:C238(sName;False:C215)
				Else 
					sName:=""
			End case 
		Else 
			ARRAY LONGINT:C221(abrSelect;0)
			sName:=""
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		Spell_CheckSpelling 
		
End case 