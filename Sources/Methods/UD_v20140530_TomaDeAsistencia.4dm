//%attributes = {}
  // UD_v20140530_TomaDeAsistencia()
  // Por: Alberto Bachler K.: 30-05-14, 18:14:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_inicioAño)
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_asistenciasRegistradas;$l_idTermometro)

ARRAY LONGINT:C221($al_RecNums;0)

$d_inicioAño:=PERIODOS_InicioAñoSTrack 
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_inicioAño)

LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Evaluando toma de asistencia a clases...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Asignaturas_RegistroSesiones:168])
	GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i_registros})
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_asistenciasRegistradas)
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($l_asistenciasRegistradas>0)
		[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
		[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;ISO date GMT:K1:10;?00:00:00?)
		[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:="Actualización a ScholTrack 11.8"
		SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])

