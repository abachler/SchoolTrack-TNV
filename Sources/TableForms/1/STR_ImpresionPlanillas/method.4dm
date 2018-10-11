  // [xxSTR_Constants].STR_ImpresionPlanillas()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-04-16, 13:41:59
  // -----------------------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		b1:=1
		b2:=0
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;viSTR_PeriodoActual_Numero)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
