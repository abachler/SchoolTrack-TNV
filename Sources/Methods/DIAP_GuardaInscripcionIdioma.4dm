//%attributes = {}
C_POINTER:C301($y_field;$2)
C_TEXT:C284($uuid;$1;$valor;$3)
C_BOOLEAN:C305($0)
C_LONGINT:C283($l_rn)

$uuid:=$1
$y_field:=$2
$valor:=$3


$l_rn:=Find in field:C653([DIAP_AlumnosIdiomas:218]Auto_UUID:1;$uuid)
If ($l_rn>=0)
	READ WRITE:C146([DIAP_AlumnosIdiomas:218])
	GOTO RECORD:C242([DIAP_AlumnosIdiomas:218];$l_rn)
	ST_Text2Anything ($y_field;$valor)
	SAVE RECORD:C53([DIAP_AlumnosIdiomas:218])
	KRL_UnloadReadOnly (->[DIAP_AlumnosIdiomas:218])
	$0:=True:C214
Else 
	$0:=False:C215
End if 

