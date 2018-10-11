//%attributes = {}
  //XML_Get_TagValue

C_LONGINT:C283($1;$vl_TypeOfData)
C_TEXT:C284($2;$vt_XMLSource)
C_TEXT:C284($3;$vt_TagVarName)
C_TEXT:C284($0;$vt_Result)

$vl_TypeOfData:=$1
$vt_XMLSource:=$2
$vt_TagVarName:=$3


Case of 
	: ($vl_TypeOfData=Is text:K8:3)
		
		
		C_TEXT:C284($vt_OpenTag;$vt_CloseTag;$vt_HeaderXML;$vt_FooterXML;$vt_CarriageReturn)
		C_TEXT:C284($vt_OpenSymbol;$vt_CloseSymbol;$vt_CloseSymbol2)
		$vt_OpenSymbol:=">"
		$vt_CloseSymbol:="</"
		$vt_CloseSymbol2:="<"
		$vt_OpenTag:="<+>"
		$vt_CloseTag:="</+>"
		$vt_CarriageReturn:="\r"
		
		  //C_LONGINT($vl_PositionHeader;$vl_OpenPosition;$vl_ClosePosition)
		
		  // //Create Header and Footer
		$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vt_TagVarName)
		$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_TagVarName)
		
		  // //Extract First Position of HeaderXML in the XML Source
		$vl_PositionHeader:=Position:C15($vt_HeaderXML;$vt_XMLSource)
		Case of 
			: ($vl_PositionHeader>0)
				  // //Extract Header of VarTag
				$vt_ResultHeader:=Substring:C12($vt_XMLSource;$vl_PositionHeader)
				  // //Extract Open Symbol Position in Result Header
				$vl_OpenPosition:=Position:C15($vt_OpenSymbol;$vt_ResultHeader)
				  // //Extract Close Symbol Position in Result Header
				$vl_ClosePosition:=Position:C15($vt_CloseSymbol;$vt_ResultHeader)
				
				  //Re Extract Positions
				$vt_ResultHeader:=Substring:C12($vt_ResultHeader;$vl_OpenPosition;$vl_ClosePosition)
				  // //Extract Open Symbol Position in Result Header
				$vl_OpenPosition:=Position:C15($vt_OpenSymbol;$vt_ResultHeader)
				  // //Extract Close Symbol Position in Result Header
				$vl_ClosePosition:=Position:C15($vt_CloseSymbol;$vt_ResultHeader)
				$vt_ResultHeader:=Substring:C12($vt_ResultHeader;$vl_OpenPosition;($vl_ClosePosition-$vl_OpenPosition)+1)
				$vt_ResultHeader:=Replace string:C233($vt_ResultHeader;$vt_CloseSymbol2;"")
				$vt_ResultHeader:=Replace string:C233($vt_ResultHeader;$vt_OpenSymbol;"")
				
				  //Cleaning CarriageReturn
				$vt_ResultHeader:=Replace string:C233($vt_ResultHeader;$vt_CarriageReturn;"")
				
			: ($vl_PositionHeader<=0)
				$vt_ResultHeader:=""
		End case 
		
	: ($vl_TypeOfData=Is BLOB:K8:12)
		
		  //C_BLOB($2;$vx_XMLSource)
		  //C_TEXT($3;$vt_Tag_Element)
		  //C_TEXT($4;$vt_Tag_Value)
		  //$vx_XMLSource:=$2
		  //$vt_Tag_Element:=$3
		  //$vt_Tag_Value:=$4
		  //
		  //C_TEXT($vt_RefXML;$vt_Result)
		  //C_LONGINT($vl_Index)
		  //
		  //$vt_RefXML:=DOM Parse XML variable($vx_XMLSource;False;"<?xml")
		  //
		  //$vl_Index:=DOM Count XML elements($vt_RefXML;XML_Gen_CleanXML ($vt_Tag_Element))
		  //$vt_DOM_Result:=DOM Get XML element($vt_RefXML;XML_Gen_CleanXML ($vt_Tag_Element);$vl_Index;$vt_elementValue)
		  //
		  //$vl_Index:=DOM Count XML elements($vt_DOM_Result;$vt_Tag_Value)
		  //$vt_DOM_Result:=DOM Get XML element($vt_DOM_Result;$vt_Tag_Value;$vl_Index;$vt_ResultHeader)
		  //
		  //$vt_ResultHeader:=ST_CleanString ($vt_ResultHeader)
		
		
End case 

$vt_Result:=$vt_ResultHeader

$0:=$vt_Result