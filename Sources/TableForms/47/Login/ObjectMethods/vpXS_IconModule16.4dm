Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		For ($h;1;8)
			$textPointer:=Get pointer:C304("vsXS_ModuleName"+String:C10($h))
			OBJECT SET FONT STYLE:C166($textPointer->;0)
		End for 
		RESOLVE POINTER:C394(Self:C308;$name;$num;$fnum)
		$textPointer:=Get pointer:C304("vsXS_ModuleName"+Substring:C12($name;Length:C16($name)))
		OBJECT SET FONT STYLE:C166($textPointer->;1)
	: (Form event:C388=On Mouse Leave:K2:34)
		For ($h;1;8)
			$textPointer:=Get pointer:C304("vsXS_ModuleName"+String:C10($h))
			OBJECT SET FONT STYLE:C166($textPointer->;0)
		End for 
		If (vlXS_LastModule#0)
			$textPointer:=Get pointer:C304("vsXS_ModuleName"+String:C10(vlXS_LastModule))
			OBJECT SET FONT STYLE:C166($textPointer->;1)
		End if 
	: (Form event:C388=On Clicked:K2:4)
		RESOLVE POINTER:C394(Self:C308;$name;$num;$fnum)
		vlBWR_CurrentModuleRef:=Num:C11(Substring:C12($name;Length:C16($name)))
		POST KEY:C465(3;0)
End case 