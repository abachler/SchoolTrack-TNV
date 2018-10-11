  // [BBL_Lectores].Identificadores()
  // Por: Alberto Bachler: 30/07/13, 10:57:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		vt_mensaje:=""
		If (([BBL_Lectores:72]Número_de_alumno:6>0) | ([BBL_Lectores:72]Número_de_Profesor:30>0) | ([BBL_Lectores:72]Número_de_Persona:31>0) | ([BBL_Lectores:72]ID:1<0))
			OBJECT SET ENTERABLE:C238(*;"@";False:C215)
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 



