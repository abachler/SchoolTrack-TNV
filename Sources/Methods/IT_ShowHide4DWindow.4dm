//%attributes = {}
  //IT_ShowHide4DWindow

C_BOOLEAN:C305(<>vb_4DWindowVisible)
If (<>vb_4DWindowVisible=False:C215)
	SHOW WINDOW:C435(<>vl_4DDefaultWindow)
	WDW_SetFrontmost (<>vl_4DDefaultWindow)
	<>vb_4DWindowVisible:=True:C214
	POST KEY:C465(Character code:C91("i");256)
Else 
	HIDE WINDOW:C436(<>vl_4DDefaultWindow)
	<>vb_4DWindowVisible:=False:C215
End if 