  // Método: Método de Objeto: ReportObjectLib.hl_ReportObjLib
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/02/10, 13:46:51
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //GET LIST ITEM(Self->;*;$itemRef;$itemText)
  //$parentItem:=List item parent(Self->;$itemRef)
  //Case of 
  //: ($parentItem=-999999999)
  //QUERY([XShell_ReportObjLib_Objects];[XShell_ReportObjLib_Objects]ID_Class=$itemRef)
  //hl_Objects:=HL_Selection2List (->[XShell_ReportObjLib_Objects]UI_Name;->[XShell_ReportObjLib_Objects]ID_Object)
  //
  //End case 



If (Form event:C388=On Begin Drag Over:K2:44)
	GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$objectID;$objectName)
	If ($objectID>0)
		$0:=0
	Else 
		$0:=-1
	End if 
End if 




