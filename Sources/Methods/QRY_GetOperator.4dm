//%attributes = {}
  // QRY_GetOperator()
  // Por: Alberto Bachler: 21/02/13, 08:57:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: ($1=aDelims{1})
		$0:="="
	: ($1=aDelims{2})
		$0:="="
	: ($1=aDelims{3})
		$0:="#"
	: ($1=aDelims{4})
		$0:=">"
	: ($1=aDelims{5})
		$0:=">="
	: ($1=aDelims{6})
		$0:="<"
	: ($1=aDelims{7})
		$0:="<="
	: ($1=aDelims{8})
		$0:="="
	: ($1=aDelims{9})
		$0:="#"
End case 