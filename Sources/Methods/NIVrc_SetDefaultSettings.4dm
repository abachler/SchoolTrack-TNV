//%attributes = {}
  //NIVrc_SetDefaultSettings

C_BLOB:C604(myBlob)
SET BLOB SIZE:C606(myBlob;0)

<>aLang:=1
r1:=0
r2:=1
bc1:=1
bc2:=0
bc3:=0
bc4:=0
bc5:=0
bc6:=0
bc7:=0
vi_popL:=1
vi_popC:=7
vi_popR:=4
bXcr:=0
bXcrFinal:=0
bGrpArea:=0
bEvVal:=1
bNotes:=1
bTitle:=1
iFSize:=9
bt1:=0
bt2:=0
bt3:=0
bGray:=0  //not used anymore
bGrpAvg:=1
ARRAY INTEGER:C220(aBkgColor;Size of array:C274(aObjects))
ARRAY INTEGER:C220(aForColor;Size of array:C274(aObjects))
For ($i;1;Size of array:C274(aBkgColor))
	aBkgColor{$i}:=1
	aForColor{$i}:=16
End for 
f1:=1
f2:=0
p1:=1
p2:=1
bAverages:=1
bSectorAvg:=0
vi_printMode:=aEvPrintMode
bAllcolumns:=1
vi_lang:=1

bPrintLogoCol:=0
bPrintFotoAl:=0

$offset:=0
  //BLOB_Variables2Blob (->myBlob;$offset;->vi_lang;->r1;->r2;->bc1;->bc2;->bc3;->bc4;->bc5;->bc6;->bc7;->vi_popL;->vi_popC;->vi_popR;->bXcr;->bXcr;->bXcrFinal;->bgrpArea;->bEvVal;->bNotes;->bTitle;->iFSize;->bt1;->bt2;->bt3;->bgray;->bgrpAvg;->aBkgColor;->aForColor;->f1;->f2;->vi_PrintMode;->p1;->p2;->bAverages;->bSectorAvg;->bAllColumns)
BLOB_Variables2Blob (->myBlob;$offset;->vi_lang;->r1;->r2;->bc1;->bc2;->bc3;->bc4;->bc5;->bc6;->bc7;->vi_popL;->vi_popC;->vi_popR;->bXcr;->bXcr;->bXcrFinal;->bgrpArea;->bEvVal;->bNotes;->bTitle;->iFSize;->bt1;->bt2;->bt3;->bgray;->bgrpAvg;->aBkgColor;->aForColor;->f1;->f2;->vi_PrintMode;->p1;->p2;->bAverages;->bSectorAvg;->bAllColumns;->bPrintLogoCol;->bPrintFotoAl)  //imágenes