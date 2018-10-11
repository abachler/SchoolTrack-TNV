//%attributes = {}
  // MÉTODO: EV2_UpdateInfoCalificaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 02/04/12, 10:41:53
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_UpdateInfoCalificaciones()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_fieldNum;$l_recNumCalificaciones)
C_POINTER:C301($y_fieldPointer)
C_TEXT:C284($t_nuevoValor;$t_observacion;$t_valorAnterior)
C_TEXT:C284($t_CurrentUsername)
If (False:C215)
	C_LONGINT:C283(EV2_UpdateInfoCalificaciones ;$1)
	C_POINTER:C301(EV2_UpdateInfoCalificaciones ;$2)
	C_TEXT:C284(EV2_UpdateInfoCalificaciones ;$3)
	C_TEXT:C284(EV2_UpdateInfoCalificaciones ;$4)
End if 



$t_CurrentUsername:=<>tUSR_CurrentUserName
$l_recNumCalificaciones:=$1
$y_fieldPointer:=$2
Case of 
	: (Count parameters:C259=4)
		$t_observacion:=$3
		$t_CurrentUsername:=$4
		
	: (Count parameters:C259=3)
		$t_observacion:=$3
End case 
If ($t_CurrentUsername="")
	$t_CurrentUsername:=<>tUSR_CurrentUserName
End if 

$l_fieldNum:=Field:C253($y_fieldPointer)
If ($l_recNumCalificaciones#Record number:C243([Alumnos_Calificaciones:208]))
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones)
End if 

vs_Key:=[Alumnos_Calificaciones:208]Llave_principal:1+"."+String:C10($l_fieldNum)
$t_valorAnterior:=Old:C35($y_fieldPointer->)
If ($t_valorAnterior="")
	$t_valorAnterior:="[ ]"
End if 
$t_nuevoValor:=$y_fieldPointer->
If ($t_nuevoValor="")
	$t_nuevoValor:="[ ]"
End if 

$l_recNumCalificaciones:=KRL_FindAndLoadRecordByIndex (->[xxSTR_InfoCalificaciones:142]Llave:1;->vs_Key;True:C214)
If ($l_recNumCalificaciones<0)
	CREATE RECORD:C68([xxSTR_InfoCalificaciones:142])
	[xxSTR_InfoCalificaciones:142]Llave:1:=vs_Key
End if 
[xxSTR_InfoCalificaciones:142]Registro_Autor:4:=$t_CurrentUsername
[xxSTR_InfoCalificaciones:142]Registro_Fecha:3:=Current date:C33(*)
[xxSTR_InfoCalificaciones:142]Registro_hora:2:=Current time:C178(*)
If ($t_observacion="")
	[xxSTR_InfoCalificaciones:142]Log:8:=[xxSTR_InfoCalificaciones:142]Log:8+$t_CurrentUsername+", "+String:C10([xxSTR_InfoCalificaciones:142]Registro_Fecha:3;7)+", "+String:C10([xxSTR_InfoCalificaciones:142]Registro_hora:2)+": "+$t_valorAnterior+" -> "+$t_nuevoValor+Char:C90(Carriage return:K15:38)
Else 
	[xxSTR_InfoCalificaciones:142]Log:8:=[xxSTR_InfoCalificaciones:142]Log:8+$t_CurrentUsername+", "+String:C10([xxSTR_InfoCalificaciones:142]Registro_Fecha:3;7)+", "+String:C10([xxSTR_InfoCalificaciones:142]Registro_hora:2)+": "+$t_valorAnterior+" -> "+$t_nuevoValor+" ("+$t_observacion+")"+Char:C90(Carriage return:K15:38)
End if 

SAVE RECORD:C53([xxSTR_InfoCalificaciones:142])
KRL_UnloadReadOnly (->[xxSTR_InfoCalificaciones:142])

