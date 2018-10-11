Case of 
	: (Self:C308->=1)
		OBJECT SET ENTERABLE:C238(*;"Condicionalidad@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"Condicionalidad@";True:C214)
	: (Self:C308->=0)
		OK:=CD_Dlog (0;__ ("¿Está Ud. segura(o) de querer borrar la condicionalidad?");__ ("");__ ("Si");__ ("No"))
		If (ok=1)
			vd_FechaCondicionalidad:=!00-00-00!
			vt_motivoCondicionalidad:=""
			Self:C308->:=0
			OBJECT SET ENTERABLE:C238(*;"Condicionalidad@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"Condicionalidad@";False:C215)
		Else 
			Self:C308->:=1
			OBJECT SET ENTERABLE:C238(*;"Condicionalidad@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"Condicionalidad@";True:C214)
		End if 
End case 