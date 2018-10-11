//%attributes = {}
  //dhQF2_PreProcessValue

C_POINTER:C301($fieldPointer)
C_TEXT:C284($0;$vt_SearchValue;$vt_retorno)
C_LONGINT:C283($type)

$vt_SearchValue:=$1
$fieldPointer:=Field:C253(alVS_QFSourceTableNumber{atVS_QFSourceFieldAlias};alVS_QFSourcefieldNumber{atVS_QFSourceFieldAlias})
$type:=Type:C295($fieldPointer->)
Case of 
	: ($type=Is boolean:K8:9)
		Case of 
			: (($vt_SearchValue="1") | ($vt_SearchValue="Y") | ($vt_SearchValue="S") | ($vt_SearchValue="Si") | ($vt_SearchValue="Yes") | ($vt_SearchValue="Oui") | ($vt_SearchValue="Verdadero") | ($vt_SearchValue="True") | ($vt_SearchValue="Vrai") | ($vt_SearchValue="V"))
				$vt_retorno:="True"
			: (($vt_SearchValue="0") | ($vt_SearchValue="N") | ($vt_SearchValue="No") | ($vt_SearchValue="Non") | ($vt_SearchValue="Falso") | ($vt_SearchValue="False") | ($vt_SearchValue="Faux") | ($vt_SearchValue="F"))
				$vt_retorno:="False"
				
		End case 
		
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (KRL_isSameField (->[Personas:7]ACT_Numero_TC:54;$fieldPointer))
				$vt_retorno:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->$vt_SearchValue;->[Personas:7]ACT_xPass:91)
		End case 
		
End case 

$0:=$vt_retorno