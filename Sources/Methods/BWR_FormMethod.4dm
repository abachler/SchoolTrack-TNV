//%attributes = {}
  //BWR_FormMethod

If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 



Case of 
	: (Form event:C388=On Load:K2:1)
		BWR_SetMenuBar 
		BWR_OnLoadFormEvent ($tablePointer)
		BWR_OnLoadingRecord ($tablePointer)
		
	: (Form event:C388=On Activate:K2:9)
		BWR_SetMenuBar 
		BWR_OnActivateFormEvent ($tablePointer)
		XS_SetInterface 
		dhBWR_SetFormALsInterface 
		
		
	: (Form event:C388=On Unload:K2:2)
		BWR_OnUnloadFormEvent ($tablePointer)
		
	: (Form event:C388=On Close Box:K2:21)
		BWR_OnCloseBoxFormEvent ($tablePointer)
		
	: (Form event:C388=On Clicked:K2:4)
		$lastObject:=Focus object:C278
		RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldnum)
		If (($varName="xALP_@") | ($varName="xAL_@"))
			AL_ExitCell ($lastObject->)
		End if 
		BWR_DispatchButtonActions ($tablePointer)
		
	: (Form event:C388=On Menu Selected:K2:14)
		BWR_BrowserMenuHandler (Menu selected:C152\65536;Menu selected:C152%65536)
		BWR_SetMenuBar 
		BWR_SetInputFormButtons 
	: (Form event:C388=On Data Change:K2:15)
		ST_LimpiaTexto 
		Spell_CheckSpelling 
		
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		dhBWR_SetFormALsInterface 
		
	Else 
		dhBWR_OptionalFormEvents ($tablePointer)
End case 
