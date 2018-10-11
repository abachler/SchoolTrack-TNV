//%attributes = {}
  //dhMNU_CreateReferencedMenus

  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 18:38:57
  // ----------------------------------------------------
  // Método: dhMNU_CreateReferencedMenus `solo para v11
  // Descripción: Crear utilizando el metodo MNU_ModuleRefMenus_AppendItem
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If (Application version:C493>="11@")
	
	
	  //insertar el código antes de esta línea
	vlMNU_ModuleReferencedMenus:=Size of array:C274(atMNU_ModuleReferencesMenus)
End if 