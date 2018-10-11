//%attributes = {}
  // MSG_TextoMensaje()
  // Por: Alberto Bachler: 26/03/13, 16:10:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_idMensaje)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_idMensaje;$t_llaveMensaje;$t_refMensaje)

If (False:C215)
	C_TEXT:C284(MSG_TextoMensaje ;$0)
	C_TEXT:C284(MSG_TextoMensaje ;$1)
	C_TEXT:C284(MSG_TextoMensaje ;$2)
	C_TEXT:C284(MSG_TextoMensaje ;$3)
End if 

$t_refMensaje:=$1
$t_idMensaje:=ST_GetWord ($t_refMensaje;1;"/")
$l_idMensaje:=Num:C11($t_idMensaje)

$t_codigoPais:=<>vtXS_CountryCode
$t_codigoLenguaje:=<>vtXS_langage
Case of 
	: (Count parameters:C259=3)
		$t_codigoPais:=$2
		$t_codigoLenguaje:=$3
End case 

If (($t_codigoPais="cl") & ($t_codigoLenguaje="es"))
	  // si el pais corresponde y el idioma corresponden a Chile y Español devuelvo en $0 el mensaje de referencia
	KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion:244]ID:5;->$l_idMensaje;False:C215)
	$0:=[xShell_MensajesAplicacion:244]Mensaje:4
Else 
	  // si se trata de otra combinacion Pais/Idioma busco el mensaje en la tabla relacionada [xShell_MensajesAplicacion_Loc]Llave
	$t_llaveMensaje:=$t_idMensaje+"."+$t_codigoPais+"."+$t_codigoLenguaje
	KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion_Loc:242]Llave:2;->$t_llaveMensaje;False:C215)
	If ((OK=1) & ([xShell_MensajesAplicacion_Loc:242]Mensaje:3#""))
		  // si el registro existe y el mensaje no es vacio, lo devuelvo
		$0:=[xShell_MensajesAplicacion_Loc:242]Mensaje:3
	Else 
		  // en caso contrario devuelvo el texto del mensaje de referencia
		KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion:244]ID:5;->$l_idMensaje;False:C215)
		$0:=[xShell_MensajesAplicacion:244]Mensaje:4
	End if 
End if 

