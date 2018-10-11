//%attributes = {}
  //XS_RemoveCFGItemPicture

$0:=1
$pictRef:=$1

If ($pictRef#0)
	If ((WDW_FindWindowByName ("Caja de Herramientas";Design process:K36:9)>0) | (WDW_FindWindowByName ("Toolbox";Design process:K36:9)>0))
		ALERT:C41("Este método no puede ser ejecutado con la Caja de Herramientas abierta en el modo"+" diseño")
		$0:=0
	Else 
		REMOVE PICTURE FROM LIBRARY:C567($pictRef)
		$pictRefList:=Load list:C383("XS_CFGIconsRef")
		DELETE FROM LIST:C624($pictRefList;$pictRef)
		SAVE LIST:C384($pictRefList;"XS_CFGIconsRef")
		CLEAR LIST:C377($pictRefList)
	End if 
End if 

