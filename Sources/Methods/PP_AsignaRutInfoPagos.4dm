//%attributes = {}
  //PP_AsignaRutInfoPagos

C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_Mensaje;$l_Resp)
C_POINTER:C301($y_Campo;$y_Tabla)

$y_Tabla:=$1
$y_Campo:=$2
$l_Mensaje:=$3
$0:=$y_Campo->

PUSH RECORD:C176($y_Tabla->)
QUERY:C277([Personas:7];$y_Campo->=$y_Campo->)
SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;at_NombreApoderado;[Personas:7]No:1;al_IDsApoderado)

Case of 
	: ($l_Mensaje=1)
		$l_Resp:=CD_Dlog (0;__ ("Este ")+<>at_IDNacional_Names{1}+__ (" de tarjetahabiente está siendo utilizado por:  ")+AT_array2text (->at_NombreApoderado;",")+"."+"\r\r"+__ ("¿Desea utilizar el ")+<>at_IDNacional_Names{1}+__ (" en este apoderado?")+"\r\r"+__ ("Si asigna el ")+<>at_IDNacional_Names{1}+__ (" en la presente casilla, éste se eliminará del o los usuarios que actualmente lo tienen en uso.");"";__ ("Si");__ ("No"))
	: ($l_Mensaje=2)
		$l_Resp:=CD_Dlog (0;__ ("Este ")+<>at_IDNacional_Names{1}+__ (" de tarjetahabiente está siendo utilizado por:  ")+AT_array2text (->at_NombreApoderado;",")+"."+"\r\r"+__ ("¿Desea utilizar el ")+<>at_IDNacional_Names{1}+__ (" en este apoderado?")+"\r\r"+__ ("Si asigna el ")+<>at_IDNacional_Names{1}+__ (" en la presente casilla, éste se eliminará del o los usuarios que actualmente lo tienen en uso.");"";__ ("Si");__ ("No"))
	: ($l_Mensaje=3)
		$l_Resp:=CD_Dlog (0;__ ("Este ")+<>at_IDNacional_Names{1}+__ (" de titular de cuenta corriente está siendo utilizado por: ")+AT_array2text (->at_NombreApoderado;",")+"."+"\r\r"+__ ("¿Desea utilizar el ")+<>at_IDNacional_Names{1}+__ (" en este apoderado?")+"\r\r"+__ ("Si asigna el ")+<>at_IDNacional_Names{1}+__ (" en la presente casilla, éste se eliminará del o los usuarios que actualmente lo tienen en uso.");"";__ ("Si");__ ("No"))
End case 

If ($l_Resp=1)
	START TRANSACTION:C239
	QRY_QueryWithArray (->[Personas:7]No:1;->al_IDsApoderado)
	APPLY TO SELECTION:C70($y_Tabla->;$y_Campo->:="")
	If (Records in set:C195("LockedSet")>0)
		CANCEL TRANSACTION:C241
		CD_Dlog (0;"Mensaje")
		$0:=""
	Else 
		VALIDATE TRANSACTION:C240
	End if 
	UNLOAD RECORD:C212($y_Tabla->)
	POP RECORD:C177([Personas:7])
Else 
	POP RECORD:C177([Personas:7])
	$0:=""
End if 
