//%attributes = {}
  // EVS_IrPagina()
  // Por: Alberto Bachler K.: 29-12-14, 10:37:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_pagina:=$1

Case of 
	: ($l_pagina=5)
		EVS_GuardaConversionSimbolos 
		EVS_CargaTablaConversion 
		
	: ($l_pagina=4)
		EVS_GuardaTablaConversion (True:C214)
		EVS_GuardaEstiloEvaluacion 
		
	: ($l_pagina=6)
		EVS_GuardaTablaEsfuerzo 
		EVS_GuardaEstiloEvaluacion 
		
	Else 
		
End case 

FORM GOTO PAGE:C247($l_pagina)
OBJECT SET FONT STYLE:C166(*;"pagina@";Plain:K14:1)
OBJECT SET FONT STYLE:C166(*;"pagina"+String:C10($l_pagina)+"_@";Bold:K14:2)