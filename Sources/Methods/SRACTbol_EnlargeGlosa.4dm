//%attributes = {}
  //SRACTbol_EnlargeGlosa

If (cbAgruparBoletas=1)
	r:=SR Get Object Properties (SRArea;SRObjectPrintRef;objectName;rectTop;rectLeft;rectBottom;rectRight;objType;options;order;selected;tableNo;fieldNo;varType;arrayElem;calcType;calcName;rows;cols;repeatHOffset;repeatVOffset)
	rectRight:=418
	r:=SR Set Object Properties (SRArea;SRObjectPrintRef;2;objectName;rectTop;rectLeft;rectBottom;rectRight;objType;options;order;selected;tableNo;fieldNo;varType;arrayElem;calcType;calcName;rows;cols;repeatHOffset;repeatVOffset)
	$r:=SR Change Object Order (SRArea;SRObjectPrintRef;-1)
End if 