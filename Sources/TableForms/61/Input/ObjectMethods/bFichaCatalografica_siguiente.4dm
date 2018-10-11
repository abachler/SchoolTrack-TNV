  // [BBL_Items].Input.bFichaCatalografica_siguiente()
  // Por: Alberto Bachler: 16/11/13, 16:39:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Selected record number:C246([BBL_FichasCatalograficas:81])<Records in selection:C76([BBL_FichasCatalograficas:81]))
	NEXT RECORD:C51([BBL_FichasCatalograficas:81])
	Case of 
		: (Selected record number:C246([BBL_FichasCatalograficas:81])=Records in selection:C76([BBL_FichasCatalograficas:81]))
			OBJECT SET VISIBLE:C603(*;"bFichaCatalografica_siguiente";False:C215)
		: (Selected record number:C246([BBL_FichasCatalograficas:81])>1)
			OBJECT SET VISIBLE:C603(*;"bFichaCatalografica_anterior";True:C214)
	End case 
End if 

