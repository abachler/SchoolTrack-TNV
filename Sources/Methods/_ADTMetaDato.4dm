//%attributes = {}
  //_ADTMetaDato

C_TEXT:C284($0;$1)

$0:=""
READ ONLY:C145([xxADT_MetaDataDefinition:79])
QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Name:2=$1)
If (Records in selection:C76([xxADT_MetaDataDefinition:79])=1)
	READ ONLY:C145([xxADT_MetaDataValues:80])
	QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Candidato:4=[ADT_Candidatos:49]Candidato_numero:1)
	FIRST RECORD:C50([xxADT_MetaDataValues:80])
	While (Not:C34(End selection:C36([xxADT_MetaDataValues:80])))
		If ([xxADT_MetaDataValues:80]ID_Definition:1=[xxADT_MetaDataDefinition:79]ID:1)
			$0:=[xxADT_MetaDataValues:80]Value:2
		End if 
		NEXT RECORD:C51([xxADT_MetaDataValues:80])
	End while 
End if 