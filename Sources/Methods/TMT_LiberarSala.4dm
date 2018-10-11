//%attributes = {}
  // TMT_LiberarSala()
  // Por: Alberto Bachler: 31/05/13, 18:19:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_salaLiberada)
C_LONGINT:C283($l_OpcionUsuario;$l_recNumAsignacion)
C_TEXT:C284($t_asignatura;$t_dia;$t_hora;$t_mensaje;$t_nombreSala;$t_registroLog)

If (False:C215)
	C_BOOLEAN:C305(TMT_LiberarSala ;$0)
	C_LONGINT:C283(TMT_LiberarSala ;$1)
End if 
$l_recNumAsignacion:=$1

KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;True:C214)
If (OK=1)
	$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)
	$t_dia:=DT_DayNameFromISODayNumber ([TMT_Horario:166]NumeroDia:1)
	$t_hora:=String:C10([TMT_Horario:166]NumeroHora:2)+__ ("ª hora")
	$t_mensaje:=__ ("¿Liberar la sala ^0 utilizada para ^1 los días ^2 en la ^3?")
	$t_nombreSala:=KRL_GetTextFieldData (->[TMT_Salas:167]ID_Sala:1;->[TMT_Horario:166]ID_Sala:6;->[TMT_Salas:167]NombreSala:2)
	$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreSala)
	$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_asignatura)
	$t_mensaje:=Replace string:C233($t_mensaje;"^2";$t_dia)
	$t_mensaje:=Replace string:C233($t_mensaje;"^3";$t_hora)
	$l_OpcionUsuario:=CD_Dlog (0;$t_mensaje;"";__ ("Aceptar");__ ("Cancelar"))
	If ($l_OpcionUsuario=1)
		[TMT_Horario:166]ID_Sala:6:=0
		[TMT_Horario:166]Sala:8:=""
		SAVE RECORD:C53([TMT_Horario:166])
		$t_registroLog:=__ ("La sala ^0 asociada a ^1 los días ^2 en la ^3 fue liberada previa confirmación del usuario.")
		$t_registroLog:=Replace string:C233($t_registroLog;"^0";$t_nombreSala)
		$t_registroLog:=Replace string:C233($t_registroLog;"^1";$t_asignatura)
		$t_registroLog:=Replace string:C233($t_registroLog;"^2";$t_dia)
		$t_registroLog:=Replace string:C233($t_registroLog;"^3";$t_hora)
		LOG_RegisterEvt ($t_registroLog)
		$b_salaLiberada:=True:C214
	End if 
	KRL_UnloadReadOnly (->[TMT_Horario:166])
Else 
	CD_Dlog (0;__ ("La sala no puede ser liberada en este momento.\rPor favor intente nuevamente mas tarde."))
End if 

$0:=$b_salaLiberada