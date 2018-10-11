//%attributes = {}
  // Método: TGR_xxSTR_DatosPeriodos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:55:20
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_ImportHistoricos_STX)


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xxSTR_DatosPeriodos:132]LlavePrincipal:11:=String:C10([xxSTR_DatosPeriodos:132]ID_Institucion:10)+"."+String:C10([xxSTR_DatosPeriodos:132]ID_Configuracion:9)+"."+String:C10([xxSTR_DatosPeriodos:132]NumeroPeriodo:1)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xxSTR_DatosPeriodos:132]LlavePrincipal:11:=String:C10([xxSTR_DatosPeriodos:132]ID_Institucion:10)+"."+String:C10([xxSTR_DatosPeriodos:132]ID_Configuracion:9)+"."+String:C10([xxSTR_DatosPeriodos:132]NumeroPeriodo:1)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 



