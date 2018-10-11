//%attributes = {}
  // MÉTODO: ASev2_registraEsfuerzo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/03/12, 18:01:15
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_registraEsfuerzo()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_BOOLEAN:C305($0)


C_LONGINT:C283($l_recNumCalificaciones)
C_TEXT:C284($t_valorEditadoLiteral)
C_POINTER:C301($y_campoCalificaciones_literal)
C_REAL:C285($r_valorEditadoReal)

  // CODIGO PRINCIPAL
$l_recNumCalificaciones:=$1
$t_valorEditadoLiteral:=$2
$y_campoCalificaciones_literal:=$3

$b_calificacionAceptada:=EV2_validaIndicadorEsfuerzo ($t_valorEditadoLiteral;->$t_valorEditadoLiteral;->$r_valorEditadoReal)
If ($b_calificacionAceptada)
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
	$y_campoCalificaciones_literal->:=$t_valorEditadoLiteral
	SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
	KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
End if 
$0:=$b_calificacionAceptada