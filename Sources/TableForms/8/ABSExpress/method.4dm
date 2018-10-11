Case of 
	: (Form event:C388=On Load:K2:1)
		CU_LoadArrays 
		WDW_SlideDrawer (->[Alumnos_Conducta:8];"ABSExpress")
		$r:=DateIsValid (Current date:C33(*);0)
		If (Not:C34($r))
			dDate:=!00-00-00!
		Else 
			dDate:=Current date:C33(*)
		End if 
		<>aCursos{0}:=""
		ARRAY TEXT:C222(atABS_Alumnos;0)
		ARRAY LONGINT:C221(alABS_AlumnosID;0)
		If (<>bUSR_EsProfesorJefe)
			<>aCursos{0}:=<>tSTR_CursoProfesor_USR
		End if 
		vtABS_CursoActual:=""
		vlABS_NivelActual:=0
		OBJECT SET ENABLED:C1123(bOK;False:C215)
		OBJECT SET ENABLED:C1123(bDelLines;False:C215)
		OBJECT SET ENTERABLE:C238(sName;False:C215)
		sName:=""
		Lid:=0
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 