//%attributes = {}
  //XS_SetCFGPicture

$pictureVarPointer:=$1
$pictureRef:=$2
$pictureName:=$3

If ((WDW_FindWindowByName ("Caja de Herramientas";Design process:K36:9)>0) | (WDW_FindWindowByName ("Toolbox";Design process:K36:9)>0))
	ALERT:C41("Este método no puede ser ejecutado con la Caja de Herramientas abierta en el modo"+" diseño")
	$0:=0
Else 
	$pictureName:=Replace string:C233($pictureName;":";"_")
	$pictureName:=Replace string:C233($pictureName;"\"";"_")
	If (Position:C15("/";$pictureName)>0)
		$pictureName:=Substring:C12($pictureName;1;Position:C15("/";$pictureName)-1)
	End if 
	
	If ($pictureRef#0)
		SET PICTURE TO LIBRARY:C566($pictureVarPointer->;$pictureRef;$pictureName)
	Else 
		$pictureRef:=PICT_Append2Library ($pictureVarPointer;$pictureName)
		If ($pictureRef#0)
			$pictRefList:=Load list:C383("XS_CFGIconsRef")
			$elementName:=HL_FindInListByReference ($pictRefList;$pictureRef)
			  //SELECT LIST ITEMS BY REFERENCE($pictRefList;$pictureRef)
			If ($elementName="")
				  //GET LIST ITEM($pictRefList;Selected list items($pictRefList);$itemRef;$itemText)
				  //If ($itemRef=0)
				APPEND TO LIST:C376($pictRefList;$pictureName;$pictureRef)
				SET LIST ITEM PROPERTIES:C386($pictRefList;$pictureRef;False:C215;0;$pictureRef+131072)
				SAVE LIST:C384($pictRefList;"XS_CFGIconsRef")
				CLEAR LIST:C377($pictRefList)
			Else 
				SET LIST ITEM:C385($pictRefList;$pictureRef;$pictureName;$pictureRef)
				SET LIST ITEM PROPERTIES:C386($pictRefList;$pictureRef;False:C215;0;$pictureRef+131072)
			End if 
		End if 
		$0:=$pictureRef
	End if 
End if 
