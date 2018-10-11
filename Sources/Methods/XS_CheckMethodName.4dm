//%attributes = {}
  //XS_CheckMethodName

$objPtr:=$1

IT_Clairvoyance ($objPtr;->aMethodNames)

If (Form event:C388=On Losing Focus:K2:8)
	If (Position:C15(".";$objPtr->)>0)
		$methodName:=Substring:C12($objPtr->;1;Position:C15(".";$objPtr->)-1)
	Else 
		$methodName:=$objPtr->
	End if 
	If ($methodName#"")
		If (API Does Method Exist ($methodName)=1)
			XS_Settings ("SavePanelColumnSettings")
		Else 
			$objPtr->:=""
			$ignore:=CD_Dlog (0;__ ("El metodo no existe.\r\rPor favor ingrese el nombre de un método válido."))
			GOTO OBJECT:C206($objPtr->)
		End if 
	Else 
		XS_Settings ("SavePanelColumnSettings")
	End if 
End if 