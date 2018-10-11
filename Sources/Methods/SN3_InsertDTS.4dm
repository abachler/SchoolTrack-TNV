//%attributes = {}
  //SN3_InsertDTS

$xmlRef:=$1

SAX_CreateNode ($xmlRef;"dts")
SAX_CreateNode ($xmlRef;"valor";True:C214;DTS_MakeFromDateTime )
SAX CLOSE XML ELEMENT:C854($xmlRef)

