//%attributes = {}
  //ADTcdd_FindMetaDataDef

$tableNum:=$1
$fieldNum:=$2
$tipoPersona:=""
$MetaName:=""

Case of 
	: (Count parameters:C259=3)
		$tipoPersona:=$3
	: (Count parameters:C259=4)
		$tableNum:=0
		$fieldNum:=0
		$tipoPersona:=""
		$MetaName:=$4
End case 


  // IIIIIIIN MNNNN              HHJUJHHHGGGU  N MM ,HGF      LLKJLKHG M. O.  M , , , , , , , , , , , ,-´PÑ-  VC  <---- Primera linea de Emilia Herreros Abr 2007
READ ONLY:C145([xxADT_MetaDataDefinition:79])
If (($tableNum#0) & ($fieldNum#0))
	QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]TableNum:7=$tableNum;*)
	QUERY:C277([xxADT_MetaDataDefinition:79]; & ;[xxADT_MetaDataDefinition:79]FieldNum:6=$fieldNum)
	If ($tipoPersona#"")
		QUERY SELECTION:C341([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Name:2=($tipoPersona+"@"))
	End if 
Else 
	QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Name:2=$MetaName)
End if 
If (Records in selection:C76([xxADT_MetaDataDefinition:79])=1)
	$0:=[xxADT_MetaDataDefinition:79]Tag:5
Else 
	$0:=""
End if 