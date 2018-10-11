If (Not:C34(vb_WindowsExpanded))
	OBJECT MOVE:C664(*;"programacion6";0;0;0;195)
	OBJECT MOVE:C664(vp_FondoConfig;0;0;0;178)
Else 
	OBJECT MOVE:C664(*;"programacion6";0;0;0;-195)
	OBJECT MOVE:C664(vp_FondoConfig;0;0;0;-178)
End if 
WDW_ExpandVertically (195)