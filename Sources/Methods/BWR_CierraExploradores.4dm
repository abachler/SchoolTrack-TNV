//%attributes = {}
  // BWR_CierraExploradores()
  // Por: Alberto Bachler K.: 20-04-15, 11:11:33
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


<>vt_CloseSesion:=True:C214
For ($i;1;Size of array:C274(<>alXS_ModuleProcessID))
	If (<>alXS_ModuleProcessID{$i}#0)
		POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$i})
		While (Process state:C330(<>alXS_ModuleProcessID{$i})>=0)
			DELAY PROCESS:C323(Current process:C322;10)
			POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$i})
		End while 
		<>alXS_ModuleProcessID{$i}:=0
	End if 
End for 