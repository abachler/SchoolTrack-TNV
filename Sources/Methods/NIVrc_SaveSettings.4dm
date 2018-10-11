//%attributes = {}
  //NIVrc_SaveSettings

C_BLOB:C604(myBlob)
SET BLOB SIZE:C606(myBlob;0)


vi_Lang:=<>aLang
vi_popL:=popL
vi_popC:=popC
vi_popR:=popR
vi_printmode:=aEvPrintMode
$offset:=0
  //BLOB_Variables2Blob (->myBlob;$offset;->vi_lang;->r1;->r2;->bc1;->bc2;->bc3;->bc4;->bc5;->bc6;->bc7;->vi_popL;->vi_popC;->vi_popR;->bXcr;->bXcr;->bXcrFinal;->bgrpArea;->bEvVal;->bNotes;->bTitle;->iFSize;->bt1;->bt2;->bt3;->bgray;->bgrpAvg;->aBkgColor;->aForColor;->f1;->f2;->vi_PrintMode;->p1;->p2;->bAverages;->bSectorAvg;->bAllColumns)
BLOB_Variables2Blob (->myBlob;$offset;->vi_lang;->r1;->r2;->bc1;->bc2;->bc3;->bc4;->bc5;->bc6;->bc7;->vi_popL;->vi_popC;->vi_popR;->bXcr;->bXcr;->bXcrFinal;->bgrpArea;->bEvVal;->bNotes;->bTitle;->iFSize;->bt1;->bt2;->bt3;->bgray;->bgrpAvg;->aBkgColor;->aForColor;->f1;->f2;->vi_PrintMode;->p1;->p2;->bAverages;->bSectorAvg;->bAllColumns;->bPrintLogoCol;->bPrintFotoAl)  //para imágenes


PREF_SetBlob (0;vs_lastRCModel;myBlob)

SET BLOB SIZE:C606(myBlob;0)