//%attributes = {}
  //SRal_SetPictureFormat

TRACE:C157
$r:=SR Get Object Properties (SRArea;SRObjectPrintRef;$objectName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
$err:=SR Set Object Format (SRArea;SRObjectPrintRef;SR Attribute Format;"";0;0;0;Char:C90(6);$foreRed;$foreGreen;$foreBlue;$backRed;$backGreen;$backBlue;0;0;0;0;0)