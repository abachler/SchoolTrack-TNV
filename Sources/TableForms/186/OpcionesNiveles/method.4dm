  // Método: Método de Formulario: [MPA_DefinicionAreas]OpcionesNiveles
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 14/06/10, 17:18:11
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

Case of 
	: (Form event:C388=On Load:K2:1)
		FORM GOTO PAGE:C247(vl_TipoObjeto)
		If (vl_RegistrosEvaluados>0)
			OBJECT SET VISIBLE:C603(*;"ConEval@";True:C214)
			OBJECT SET VISIBLE:C603(*;"SinEval@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"ConEval@";False:C215)
			OBJECT SET VISIBLE:C603(*;"SinEval@";True:C214)
		End if 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 



