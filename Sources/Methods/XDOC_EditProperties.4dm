//%attributes = {}
  //XDOC_EditProperties

$recNum:=$1
READ WRITE:C146([xShell_Documents:91])
GOTO RECORD:C242([xShell_Documents:91];$recNum)
WDW_OpenFormWindow (->[xShell_Documents:91];"Input";7;4;__ ("Propiedades"))
KRL_ModifyRecord (->[xShell_Documents:91];"Input")
CLOSE WINDOW:C154