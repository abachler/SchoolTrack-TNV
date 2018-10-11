  // [BBL_Items].Input.bFichaCatalografica_anterior()
  // Por: Alberto Bachler: 16/11/13, 16:48:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (Selected record number:C246([BBL_FichasCatalograficas:81])>1)
	PREVIOUS RECORD:C110([BBL_FichasCatalograficas:81])
	Case of 
		: (Selected record number:C246([BBL_FichasCatalograficas:81])=1)
			OBJECT SET VISIBLE:C603(*;"bFichaCatalografica_anterior";False:C215)
		: (Selected record number:C246([BBL_FichasCatalograficas:81])<Records in selection:C76([BBL_FichasCatalograficas:81]))
			OBJECT SET VISIBLE:C603(*;"bFichaCatalografica_siguiente";True:C214)
	End case 
End if 


