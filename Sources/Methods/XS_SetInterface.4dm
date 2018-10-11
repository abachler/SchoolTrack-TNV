//%attributes = {}
  //XS_SetInterface

If (Count parameters:C259=1)
	$condition:=$1
Else 
	$condition:=True:C214
End if 
OBJECT SET VISIBLE:C603(*;"aqua";True:C214)


If (Not:C34(Undefined:C82(vsBWR_CurrentModule)))
	If (vsBWR_CurrentModule#"")
		  //PICTURE LIBRARY LIST($al_refs;$at_nombres)
		  //$l_elemento:=Find in array("PrefPanel"+vsBWR_CurrentModule)
		  //If ($l_elemento>0)
		  //$t_ref:=
		  //End if 
		GET PICTURE FROM LIBRARY:C565("PrefPanel"+vsBWR_CurrentModule;PrefIcon)
		OBJECT SET FORMAT:C236(*;"bIconoWZD";"1;1;PrefIcon;96;0")
		GET PICTURE FROM LIBRARY:C565("Config_Back_"+vsBWR_CurrentModule;vp_ModuleIconBack)
	End if 
End if 