Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(aAsignaturasProfesor;0)
		STR_LeePreferenciasConducta2 
		COPY ARRAY:C226(<>atSTR_Anotaciones_motivo;aMotAnot)
		WDW_SlideDrawer (->[Alumnos_Anotaciones:11];"MultiInput")
		vt_observaciones:=""
		sMotivo:=""
		vtSTRal_CategoriaAnotacion:=""
		vlSTRal_PuntosAnotación:=0
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		If (DateIsValid (Current date:C33;0))
			dFrom:=Current date:C33
		Else 
			dFrom:=!00-00-00!
		End if 
		If (<>lUSR_RelatedTableUserID>0)
			sprof:=<>tUSR_CurrentUserName
			iProfID:=<>lUSR_RelatedTableUserID
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=iprofId;*)
			QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=iprofId)
			AT_DistinctsFieldValues (->[Asignaturas:18]denominacion_interna:16;->aAsignaturasProfesor)
			  // Modificado por: Alexis Bustamante (28-06-2017)
			  //ticket 184235 
			AT_Insert (1;1;->aAsignaturasProfesor)
			aAsignaturasProfesor{1}:="Sin Asignatura"
			If (Size of array:C274(aAsignaturasProfesor)>0)
				aAsignaturasProfesor:=1
			End if 
		Else 
			sprof:=""
			iProfID:=0
		End if 
		
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
		If (Size of array:C274(aAsignaturasProfesor)>0)
			OBJECT SET ENTERABLE:C238(*;"asignatura@";True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*;"asignatura@";False:C215)
		End if 
		REDRAW WINDOW:C456
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
End case 
