//%attributes = {}
  // Método: TGR_ADT_Contactos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:56:14
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializacione

  // Código principal
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[ADT_Contactos:95]Apellidos_y_Nombres:5:=[ADT_Contactos:95]Apellido_Paterno:2+" "+[ADT_Contactos:95]Apellido_Materno:3+" "+[ADT_Contactos:95]Nombres:4
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			  //mono 26-012-2011: cambio la asignación del valor de numero de prospectos al método ADTcon_SaveProspectos
			  //SET QUERY DESTINATION(Into variable;$recs)
			  //QUERY([ADT_Prospectos];[ADT_Prospectos]ID_Contacto=[ADT_Contactos]ID)
			  //SET QUERY DESTINATION(Into current selection)
			  //[ADT_Contactos]Numero_de_Prospectos:=$recs
			[ADT_Contactos:95]Apellidos_y_Nombres:5:=[ADT_Contactos:95]Apellido_Paterno:2+" "+[ADT_Contactos:95]Apellido_Materno:3+" "+[ADT_Contactos:95]Nombres:4
	End case 
End if 


