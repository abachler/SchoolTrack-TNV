//%attributes = {}
  //EV2_RetornaInfoNota

C_POINTER:C301($1;$fieldPointer)
C_TEXT:C284($2;$infoRetorno)
C_TEXT:C284($fieldRef)

$fieldPointer:=$1
$infoRetorno:=$2

$fieldRef:=String:C10(Field:C253($fieldPointer))

$key:=[Alumnos_Calificaciones:208]Llave_principal:1+"."+$fieldRef
KRL_FindAndLoadRecordByIndex (->[xxSTR_InfoCalificaciones:142]Llave:1;->$key)

Case of 
	: ($infoRetorno="Info1")
		$0:=[xxSTR_InfoCalificaciones:142]Info1:5
	: ($infoRetorno="Info2")
		$0:=[xxSTR_InfoCalificaciones:142]Info2:6
	: ($infoRetorno="Info3")
		$0:=[xxSTR_InfoCalificaciones:142]Info3:7
	: ($infoRetorno="log")
		$0:=[xxSTR_InfoCalificaciones:142]Log:8
	: (($infoRetorno="Fecha") | ($infoRetorno="Date"))
		$0:=String:C10([xxSTR_InfoCalificaciones:142]Registro_Fecha:3;7)
	: (($infoRetorno="Hora") | ($infoRetorno="Hour") | ($infoRetorno="Time") | ($infoRetorno="Heure"))
		$0:=String:C10([xxSTR_InfoCalificaciones:142]Registro_hora:2;"00:00:00")
	: (($infoRetorno="Autor") | ($infoRetorno="Usuario") | ($infoRetorno="User") | ($infoRetorno="Author") | ($infoRetorno="Auteur") | ($infoRetorno="Utilisateur"))
		$0:=[xxSTR_InfoCalificaciones:142]Registro_Autor:4
End case 





