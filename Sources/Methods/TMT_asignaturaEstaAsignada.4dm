//%attributes = {}
  // TMT_asignaturaEstaAsignada()
  // Por: Alberto Bachler: 15/06/13, 11:00:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($l_idAsignatura;$l_IdProfesor;$l_numeroDeCiclo;$l_numeroDia_ISO;$l_numeroHora)

If (False:C215)
	C_BOOLEAN:C305(TMT_asignaturaEstaAsignada ;$0)
	C_LONGINT:C283(TMT_asignaturaEstaAsignada ;$1)
	C_LONGINT:C283(TMT_asignaturaEstaAsignada ;$2)
	C_LONGINT:C283(TMT_asignaturaEstaAsignada ;$3)
	C_LONGINT:C283(TMT_asignaturaEstaAsignada ;$4)
	C_LONGINT:C283(TMT_asignaturaEstaAsignada ;$5)
End if 

$l_idAsignatura:=$1
$l_IdProfesor:=$2
$l_numeroDia_ISO:=$3
$l_numeroHora:=$4
$l_numeroDeCiclo:=$5

QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]ID_Asignatura:5;=;$l_idAsignatura;*)
  //QUERY([TMT_Horario]; & ;[TMT_Horario]ID_Teacher;=;$l_IdProfesor;*) // ABK 20130830 una asignatura no debe ser asignada al mismo bloque independientemente del profesor
QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1;=;$l_numeroDia_ISO;*)
QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2;=;$l_numeroHora;*)
QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14;=;$l_numeroDeCiclo)

If (Records in selection:C76([TMT_Horario:166])=1)  //MONO ticket 216065
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>Current date:C33(*))
End if 

$0:=(Records in selection:C76([TMT_Horario:166])>0)
