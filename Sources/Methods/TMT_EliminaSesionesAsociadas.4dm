//%attributes = {}
  // TMT_EliminaSesionesAsociadas
  // Por: Alberto Bachler: 18/05/13, 17:46:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_DATE:C307($2)
C_DATE:C307($3)

C_BOOLEAN:C305($b_enTransaccionAnterior)
C_DATE:C307($d_inicioSesiones;$d_terminoSesiones)
C_LONGINT:C283($i)
C_POINTER:C301($y_recNumAsignacionesHorario_al)

ARRAY LONGINT:C221($al_RecNumSesiones;0)
If (False:C215)
	C_POINTER:C301(TMT_EliminaSesionesAsociadas ;$1)
	C_DATE:C307(TMT_EliminaSesionesAsociadas ;$2)
	C_DATE:C307(TMT_EliminaSesionesAsociadas ;$3)
End if 

$y_recNumAsignacionesHorario_al:=$1

Case of 
	: (Count parameters:C259=3)
		$d_inicioSesiones:=$2
		$d_terminoSesiones:=$3
End case 

  // busco las sesiones asociadas a la asignación de horario
If (Not:C34(In transaction:C397))
	START TRANSACTION:C239
Else 
	$b_enTransaccionAnterior:=True:C214
End if 
For ($i;1;Size of array:C274($y_recNumAsignacionesHorario_al->))
	KRL_GotoRecord (->[TMT_Horario:166];$y_recNumAsignacionesHorario_al->{$i})
	If (Count parameters:C259=1)
		$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
		$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
	End if 
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[TMT_Horario:166]No_Ciclo:14;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4;=;[TMT_Horario:166]NumeroHora:2;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15;=;[TMT_Horario:166]NumeroDia:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>=;$d_inicioSesiones;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;$d_terminoSesiones)
	ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>)
	
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNumSesiones)
	OK:=ASrs_EliminaSesiones (->$al_RecNumSesiones)
	
	If (OK=0)
		$i:=Size of array:C274($y_recNumAsignacionesHorario_al->)
	End if 
End for 
KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])

If (Not:C34($b_enTransaccionAnterior))
	If (OK=1)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
End if 

$0:=OK
