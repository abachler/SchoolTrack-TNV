//%attributes = {}
  // Método: TGR_xxSTR_Niveles
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:59:01
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_BOOLEAN:C305(<>vb_ImportHistoricos_STX)
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
	End case 
	CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[xxSTR_Niveles:6])
End if 


