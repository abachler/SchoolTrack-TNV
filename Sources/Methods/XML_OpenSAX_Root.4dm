//%attributes = {}
  //XML_OpenSAX_Root

C_TIME:C306($1;$docRef)
C_TEXT:C284($2;$root;$encoding)
C_BOOLEAN:C305($standAlone)
$docRef:=$1
$root:=$2
$encoding:="UTF-16"
$standAlone:=True:C214

Case of 
	: (Count parameters:C259=4)
		$encoding:=$3
		$standAlone:=$4
	: (Count parameters:C259=3)
		$encoding:=$3
		$standAlone:=True:C214
End case 

SAX SET XML DECLARATION:C858($DocRef;$encoding;$standAlone)  // set encoding and stand alone values
SAX OPEN XML ELEMENT:C853($DocRef;$root)