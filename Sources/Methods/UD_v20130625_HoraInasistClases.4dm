//%attributes = {}
  // UD_v20130625_HoraInasistClases()
  // Por: Alberto Bachler: 25/06/13, 11:09:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_fechaInicioAño;$d_fechaTerminoAño)
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_ejecutado;$l_IdProceso)

ARRAY LONGINT:C221($al_RecNums;0)

$d_fechaInicioAño:=PERIODOS_InicioAñoSTrack 
$d_fechaTerminoAño:=PERIODOS_FinAñoPeriodosSTrack 
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaTerminoAño)

LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")

$l_IdProceso:=IT_Progress (1;0;0;"Normalizando registros de inasistencias a clases...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i_registros})
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Dia:7#[Asignaturas_RegistroSesiones:168]NumeroDia:15;*)
	QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; | ;[Asignaturas_Inasistencias:125]Hora:8#[Asignaturas_RegistroSesiones:168]Hora:4)
	If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
		ARRAY LONGINT:C221($al_numeroDia;Records in selection:C76([Asignaturas_Inasistencias:125]))
		ARRAY LONGINT:C221($al_numeroHora;Records in selection:C76([Asignaturas_Inasistencias:125]))
		AT_Populate (->$al_numeroDia;->[Asignaturas_RegistroSesiones:168]NumeroDia:15)
		AT_Populate (->$al_numeroHora;->[Asignaturas_RegistroSesiones:168]Hora:4)
		$l_ejecutado:=KRL_Array2Selection (->$al_numeroDia;->[Asignaturas_Inasistencias:125]Dia:7;->$al_numeroHora;->[Asignaturas_Inasistencias:125]Hora:8)
		If ($l_ejecutado=0)
			$i_registros:=Size of array:C274($al_RecNums)
		End if 
	End if 
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
If ($l_ejecutado=1)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 

