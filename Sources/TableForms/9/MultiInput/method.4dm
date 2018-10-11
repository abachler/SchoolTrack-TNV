C_REAL:C285(iiHrs)
Spell_CheckSpelling 
Case of 
	: (Form event:C388=On Load:K2:1)
		STR_LeePreferenciasConducta2 
		WDW_SlideDrawer (->[Alumnos_Castigos:9];"MultiInput")
		sMotivo:=""
		If (DateIsValid (Current date:C33;0))
			dFrom:=Current date:C33
			dTo:=Current date:C33
		Else 
			dFrom:=!00-00-00!
			dTo:=!00-00-00!
		End if 
		vt_observaciones:=""
		If (<>lUSR_RelatedTableUserID>0)
			sprof:=<>tUSR_CurrentUserName
			iProfID:=<>lUSR_RelatedTableUserID
		Else 
			sprof:=""
			iProfID:=0
		End if 
		
		iiHrs:=0
		If (USR_checkRights ("A";->[Alumnos_Conducta:8]))
			Case of 
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)=1) & (vLocation="browser"))
					READ ONLY:C145([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{1}})
					lID:=[Alumnos:2]numero:1
					sName:=[Alumnos:2]apellidos_y_nombres:40
				: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)>1) & (vLocation="browser"))
					sName:="("+String:C10(Size of array:C274(aBrSelect))+" Alumnos seleccionados)"
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
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 