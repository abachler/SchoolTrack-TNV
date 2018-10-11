//%attributes = {}
  //PP_UDFamilyParent

C_LONGINT:C283($1)
C_TEXT:C284($2)
$id:=$1
$sexo:=$2
DELAY PROCESS:C323(Current process:C322;15)
READ WRITE:C146([Familia:78])
Case of 
	: ($sexo="F")
		QUERY:C277([Familia:78];[Familia:78]Madre_Número:6=$id)
	: ($sexo="M")
		QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=$id)
End case 
[Familia:78]Numero:1:=[Familia:78]Numero:1  //fuerzo la ejecución del trigger
SAVE RECORD:C53([Familia:78])
UNLOAD RECORD:C212([Familia:78])
READ ONLY:C145([Familia:78])
