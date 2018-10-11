//%attributes = {}
  // Método: TGR_SN3_PublicationPrefs
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:32:52
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[SN3_PublicationPrefs:161]DTS_Modificacion:3:=DTS_MakeFromDateTime 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[SN3_PublicationPrefs:161]DTS_Modificacion:3:=DTS_MakeFromDateTime 
	End case 
End if 



