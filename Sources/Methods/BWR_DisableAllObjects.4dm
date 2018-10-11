//%attributes = {}
  //BWR_DisableAllObjects

  //Metodo: Método: BWR_DisableObjects
  //Por abachler
  //Creada el 12/08/2007, 23:19:07
  // ----------------------------------------------------


If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

If (Not:C34(USR_checkRights ("M";$tablePointer)))  //si el usuario no tiene privilegios de modificación se deshabilitan todos los objetos accesibles (con excepción de los plugins)
	_O_DISABLE BUTTON:C193(*;"@")
	OBJECT SET ENTERABLE:C238(*;"@";False:C215)
	BWR_OnActivateFormEvent   //se llama a este metodo para reestabler los atributos de los botones por defectos de los formularios
End if 