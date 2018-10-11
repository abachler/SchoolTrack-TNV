//%attributes = {}
  // Método: TGR_xxSTR_MetadatosLocales
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:58:28
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
			If ([xxSTR_MetadatosLocales:141]UUID:10="")
				[xxSTR_MetadatosLocales:141]UUID:10:=Generate UUID:C1066
			End if 
			[xxSTR_MetadatosLocales:141]LlavePrimaria:4:=[xxSTR_MetadatosLocales:141]CodigoPais:1+"."+String:C10([xxSTR_MetadatosLocales:141]Tabla:2)+"."+[xxSTR_MetadatosLocales:141]UUID:10
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xxSTR_MetadatosLocales:141]LlavePrimaria:4:=[xxSTR_MetadatosLocales:141]CodigoPais:1+"."+String:C10([xxSTR_MetadatosLocales:141]Tabla:2)+"."+[xxSTR_MetadatosLocales:141]UUID:10
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 



