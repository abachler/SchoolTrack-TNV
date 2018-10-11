//%attributes = {"executedOnServer":true}
  // Método: ASrs_CreaRegistro
  // código original de: ABK ?
  // modificado por Alberto Bachler Klein, 02/10/18, 11:43:16
  // 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_DATE:C307($4)
C_LONGINT:C283($5)

C_DATE:C307($d_fechaSesion)
C_LONGINT:C283($l_año;$l_hora;$l_idAsignatura;$l_idSesion;$l_numeroCiclo)
If (False:C215)
	C_LONGINT:C283(ASrs_CreaRegistro ;$1)
	C_LONGINT:C283(ASrs_CreaRegistro ;$2)
	C_LONGINT:C283(ASrs_CreaRegistro ;$3)
	C_DATE:C307(ASrs_CreaRegistro ;$4)
	C_LONGINT:C283(ASrs_CreaRegistro ;$5)
End if 

  // CÓDIGO
$l_idAsignatura:=$1
$l_hora:=$2
$l_numeroCiclo:=$3
$d_fechaSesion:=$4

$l_año:=<>gYear
If (Count parameters:C259=5)
	$l_año:=$5
End if 

$l_numeroDia:=DT_GetDayNumber_ISO8601 ($d_fechaSesion)

READ ONLY:C145([Asignaturas_RegistroSesiones:168])
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$l_idAsignatura;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fechaSesion;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=$l_numeroCiclo)
If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$l_idAsignatura;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$l_numeroDia;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=$l_hora)
	  // ABK 20181002 solo se crean sesiones entre las fechas de inicio y fin de asignación a horario
	If (([TMT_Horario:166]SesionesDesde:12<=$d_fechaSesion) & ([TMT_Horario:166]SesionesHasta:13>=$d_fechaSesion))
		CREATE RECORD:C68([Asignaturas_RegistroSesiones:168])
		$l_idSesion:=SQ_SeqNumber (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
		[Asignaturas_RegistroSesiones:168]ID_Sesion:1:=$l_idSesion
		[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3:=$d_fechaSesion
		[Asignaturas_RegistroSesiones:168]ID_Asignatura:2:=$l_idAsignatura
		[Asignaturas_RegistroSesiones:168]NumeroDia:15:=$l_numeroDia
		[Asignaturas_RegistroSesiones:168]Hora:4:=$l_hora
		[Asignaturas_RegistroSesiones:168]Impartida:5:=True:C214
		[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9:=$l_numeroCiclo
		[Asignaturas_RegistroSesiones:168]Año:13:=$l_año
		[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]profesor_numero:4)
		[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]profesor_nombre:13)
		SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
	End if 
End if 

KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])

$0:=$l_idSesion