
Case of 
	: (Form event:C388=On Load:K2:1)
		STR_LeePreferenciasAtrasos2 
		vi_TiempoAtraso:=0
		vi_TiempoAtrasoGral:=0
		If (vi_RegistrarMinutosEnAtrasos>0)
			OBJECT SET VISIBLE:C603(*;"minutos@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"minutos@";False:C215)
		End if 
		
		XS_SetInterface 
		WDW_SlideDrawer (->[Alumnos_Conducta:8];"LateExpress")
		sCurso:=""
		sName:=""
		$r:=DateIsValid (Current date:C33(*);0)
		If (Not:C34($r))
			dDate:=!00-00-00!
		End if 
		OBJECT SET ENTERABLE:C238(dDate;False:C215)
		If ((sCurso="") | (dDate=!00-00-00!))
			OBJECT SET ENTERABLE:C238(sName;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(sName;True:C214)
		End if 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (sCurso="")
			OBJECT SET ENTERABLE:C238(dDate;False:C215)
		End if 
		If ((sCurso="") | (dDate=!00-00-00!))
			OBJECT SET ENTERABLE:C238(sName;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(sName;True:C214)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_Anot)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 