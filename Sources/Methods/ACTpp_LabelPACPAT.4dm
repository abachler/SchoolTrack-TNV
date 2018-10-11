//%attributes = {}
  //ACTpp_LabelPACPAT

C_POINTER:C301(${1})
C_LONGINT:C283($age)

$age:=Int:C8(DT_ReturnAgeInMonths ($1->)/12)
Case of 
	: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
		$2->:=<>at_IDNacional_Names{1}
		$3->:=<>at_IDNacional_Names{1}
	: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
		$2->:=<>at_IDNacional_Names{2}
		$3->:=<>at_IDNacional_Names{2}
	: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
		$2->:=<>at_IDNacional_Names{3}
		$3->:=<>at_IDNacional_Names{3}
	Else 
		$2->:=<>at_IDNacional_Names{1}
		$3->:=<>at_IDNacional_Names{1}
End case 
$2->:=$2->+":"
$3->:=$3->+":"