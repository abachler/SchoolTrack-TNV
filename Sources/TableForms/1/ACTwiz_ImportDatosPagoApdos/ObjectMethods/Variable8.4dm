vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=1
		OBJECT SET VISIBLE:C603(bPrev;True:C214)
		OBJECT SET VISIBLE:C603(bNext;True:C214)
		OBJECT SET VISIBLE:C603(vi_step;True:C214)
	: (vi_PageNumber=2)
		OBJECT SET VISIBLE:C603(bPrev;False:C215)
		OBJECT SET VISIBLE:C603(bNext;False:C215)
		OBJECT SET VISIBLE:C603(vi_step;False:C215)
		vi_step:=2
		_O_ENABLE BUTTON:C192(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		IT_SetButtonState ((vt_g1#"");->bImport)
End case 