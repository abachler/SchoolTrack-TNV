//%attributes = {}
  // Método: AS_CreaSesionesAsignatura
  // código original de: ABK?
  // modificado por Alberto Bachler Klein, 02/10/18, 11:44:01
  // 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_LONGINT:C283($1)
C_DATE:C307($2)

C_DATE:C307($d_fechaSesion)
C_LONGINT:C283($i;$l_idAsignatura;$l_numeroCiclo;$l_numeroDia;$l_numeroNivel)

ARRAY INTEGER:C220($al_numeroCiclo;0)
ARRAY INTEGER:C220($al_numeroHora;0)

If (False:C215)
	C_LONGINT:C283(AS_CreaSesionesAsignatura ;$1)
	C_DATE:C307(AS_CreaSesionesAsignatura ;$2)
End if 

$d_fechaSesion:=Current date:C33(*)
$l_idAsignatura:=[Asignaturas:18]Numero:1  // por defecto $l_IdAsignatura corresponde al registro actual
Case of 
	: (Count parameters:C259=1)
		$l_idAsignatura:=$1
	: (Count parameters:C259=2)
		$l_idAsignatura:=$1
		$d_fechaSesion:=$2
End case 

$l_numeroNivel:=Choose:C955($l_idAsignatura#[Asignaturas:18]Numero:1;\
KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Numero_del_Nivel:6);\
[Asignaturas:18]Numero_del_Nivel:6)

If (Record number:C243([Asignaturas:18])>No current record:K29:2)  // nos aseguramos que el registro exista
	PERIODOS_LoadData ($l_numeroNivel)
	If (DateIsValid ($d_fechaSesion;0))
		$l_numeroDia:=Day number:C114($d_fechaSesion)-1
		$l_numeroCiclo:=TMT_retornaCiclo ($d_fechaSesion)
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_numeroDia;*)
		QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Asignatura:5=$l_idAsignatura;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=$l_numeroCiclo;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=$d_fechaSesion;*)  // ABK 20181002 se limita a las fecha de inicio y fin de asignacion a horario
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$d_fechaSesion)
		SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroHora:2;$al_numeroHora)
		For ($i;1;Size of array:C274($al_numeroHora))
			ASrs_CreaRegistro ($l_idAsignatura;$al_numeroHora{$i};$l_numeroCiclo;$d_fechaSesion)
		End for 
		UNLOAD RECORD:C212([Asignaturas_RegistroSesiones:168])
	End if 
End if 