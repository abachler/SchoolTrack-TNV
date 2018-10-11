vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		OBJECT SET ENABLED:C1123(bPrev;False:C215)
		OBJECT SET ENABLED:C1123(bNext;True:C214)
		vi_step:=1
		OBJECT SET VISIBLE:C603(bPrev;True:C214)
		OBJECT SET VISIBLE:C603(bNext;True:C214)
		OBJECT SET VISIBLE:C603(vi_step;True:C214)
	: (vi_PageNumber=2)
		OBJECT SET VISIBLE:C603(bPrev;True:C214)
		OBJECT SET VISIBLE:C603(bNext;True:C214)
		OBJECT SET VISIBLE:C603(vi_step;True:C214)
		vi_step:=2
		OBJECT SET ENABLED:C1123(bPrev;True:C214)
		  //20170621 RCH
		  //IT_SetButtonState ((vt_g1#"");->bNext)
		OBJECT SET ENABLED:C1123(bNext;(vt_g1#""))
	: (vi_PageNumber=3)
		OBJECT SET VISIBLE:C603(bPrev;False:C215)
		OBJECT SET VISIBLE:C603(bNext;False:C215)
		OBJECT SET VISIBLE:C603(vi_step;False:C215)
		vi_step:=3
		OBJECT SET ENABLED:C1123(bPrev;True:C214)
		OBJECT SET ENABLED:C1123(bNext;False:C215)
End case 