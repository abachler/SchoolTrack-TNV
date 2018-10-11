//%attributes = {}
  //dhBWR_OnActivate

C_BOOLEAN:C305(<>vb_Refresh)
Case of 
	: (<>vsXS_CurrentModule="AccountTrack")
		If (<>vb_Refresh)
			DELAY PROCESS:C323(Current process:C322;30)
			POST KEY:C465(-96)
		End if 
End case 
<>vb_Refresh:=False:C215