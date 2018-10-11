//%attributes = {}
  //Método: _EfemerideReligiosa_texto

C_POINTER:C301($1;$fieldPointer)
C_TEXT:C284($2;$religion;$3;$efemeride;$0)
C_LONGINT:C283($tableNum)
$fieldPointer:=$1
$religion:=$2
$efemeride:=$3
$tableNum:=Table:C252($fieldPointer)

QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=$religion;*)
QUERY:C277([xxSTR_MetaReligionDef:165]; & ;[xxSTR_MetaReligionDef:165]Efemeride:3=$efemeride)
If (Records in selection:C76([xxSTR_MetaReligionDef:165])=1)
	$idEfemeride:=[xxSTR_MetaReligionDef:165]ID:1
	Case of 
		: ($tableNum=Table:C252(->[Alumnos:2]))
			QUERY:C277([xxSTR_MetaReligionValues:164];[xxSTR_MetaReligionValues:164]ID_Efemeride:1;=;$idEfemeride;*)
			QUERY:C277([xxSTR_MetaReligionValues:164]; & ;[xxSTR_MetaReligionValues:164]ID_Alumno:2;=;$fieldPointer->)
			$0:=String:C10([xxSTR_MetaReligionValues:164]Fecha:5;Internal date short:K1:7)
			
		: ($tableNum=Table:C252(->[Personas:7]))
			QUERY:C277([xxSTR_MetaReligionValues:164];[xxSTR_MetaReligionValues:164]ID_Efemeride:1;=;$idEfemeride;*)
			QUERY:C277([xxSTR_MetaReligionValues:164]; & ;[xxSTR_MetaReligionValues:164]ID_Persona:3;=;$fieldPointer->)
			$0:=String:C10([xxSTR_MetaReligionValues:164]Fecha:5;Internal date short:K1:7)
			
		: ($tableNum=Table:C252(->[Profesores:4]))
			QUERY:C277([xxSTR_MetaReligionValues:164];[xxSTR_MetaReligionValues:164]ID_Efemeride:1;=;$idEfemeride;*)
			QUERY:C277([xxSTR_MetaReligionValues:164]; & ;[xxSTR_MetaReligionValues:164]ID_Profesor:4;=;$fieldPointer->)
			$0:=String:C10([xxSTR_MetaReligionValues:164]Fecha:5;Internal date short:K1:7)
			
	End case 
Else 
	$0:="N/D"
End if 
