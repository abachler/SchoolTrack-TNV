//%attributes = {}
  //NIVrc_GetSettings

C_BLOB:C604(myBlob)
SET BLOB SIZE:C606(myBlob;0)
p1:=0
p2:=0
bAverages:=0



NIVrc_SetDefaultSettings 
If (vs_lastRCModel#"")
	myBlob:=PREF_fGetBlob (0;vs_lastRCModel;myBlob)
	
	$offset:=0
	<>vb_TraceBlobReading:=True:C214
	  //BLOB_Blob2Vars (->myBlob;$offset;->vi_lang;->r1;->r2;->bc1;->bc2;->bc3;->bc4;->bc5;->bc6;->bc7;->vi_popL;->vi_popC;->vi_popR;->bXcr;->bXcr;->bXcrFinal;->bgrpArea;->bEvVal;->bNotes;->bTitle;->iFSize;->bt1;->bt2;->bt3;->bgray;->bgrpAvg;->aBkgColor;->aForColor;->f1;->f2;->vi_PrintMode;->p1;->p2;->bAverages;->bSectorAvg;->bAllColumns)
	BLOB_Blob2Vars (->myBlob;$offset;->vi_lang;->r1;->r2;->bc1;->bc2;->bc3;->bc4;->bc5;->bc6;->bc7;->vi_popL;->vi_popC;->vi_popR;->bXcr;->bXcr;->bXcrFinal;->bgrpArea;->bEvVal;->bNotes;->bTitle;->iFSize;->bt1;->bt2;->bt3;->bgray;->bgrpAvg;->aBkgColor;->aForColor;->f1;->f2;->vi_PrintMode;->p1;->p2;->bAverages;->bSectorAvg;->bAllColumns;->bPrintLogoCol;->bPrintFotoAl)  //imágenes
	
	If (vi_lang=0)
		vi_lang:=1
	End if 
	<>aLang:=vi_lang
	popL:=vi_popL
	popC:=vi_popC
	popR:=vi_popR
	aEvPrintMode:=vi_PrintMode
	
	If (p1=1)
		p2:=0
	Else 
		p2:=1
	End if 
	
	SET BLOB SIZE:C606(myBlob;0)
End if 