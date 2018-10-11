//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 28-05-18, 17:10:15
  // ----------------------------------------------------
  // Método: TMT_TopeHorarioAlumno
  // Descripción Validación para cuando quiero inscribir un alumno en una asignatura y que esta no tope en el horario
  // con las otras que el alumno ya tiene inscritas. 
  //
  // ----------------------------------------------------


ARRAY LONGINT:C221($al_rnHorario;0)
ARRAY TEXT:C222($atMensajeTopeHorario;0)
ARRAY DATE:C224($ad_SesioneHasta;0)

ARRAY INTEGER:C220($al_nCiclo;0)
ARRAY INTEGER:C220($al_nDia;0)
ARRAY INTEGER:C220($al_nHora;0)

C_BOOLEAN:C305($b_tope)
C_OBJECT:C1216($ob_result;$0)
C_LONGINT:C283($l_idAlu;$1;$l_idAsig;$2;$i;$t)
C_POINTER:C301($y_arrayAsig;$3)

$ob_result:=OB_Create 
OB SET:C1220($ob_result;"topeHorario";False:C215)
OB SET NULL:C1233($ob_result;"atMensajeTopeHorario")

$l_idAlu:=$1
$l_idAsig:=$2  //asignatura donde quiero entrar
$y_arrayAsig:=$3  //asignaturas del alumno
$b_tope:=False:C215

READ ONLY:C145([TMT_Horario:166])

QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$l_idAsig;*)
QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>Current date:C33(*))

SELECTION TO ARRAY:C260([TMT_Horario:166]No_Ciclo:14;$al_nCiclo;[TMT_Horario:166]NumeroDia:1;$al_nDia;[TMT_Horario:166]NumeroHora:2;$al_nHora)

QUERY WITH ARRAY:C644([TMT_Horario:166]ID_Asignatura:5;$y_arrayAsig->)
CREATE SET:C116([TMT_Horario:166];"$horario")

For ($i;1;Size of array:C274($al_nCiclo))
	
	USE SET:C118("$horario")
	
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]No_Ciclo:14=$al_nCiclo{$i};*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$al_nDia{$i};*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=$al_nHora{$i};*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]ID_Asignatura:5#$l_idAsig;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$ad_SesioneHasta{$i})
	
	If (Records in selection:C76([TMT_Horario:166])>0)
		$b_tope:=True:C214
		LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_rnHorario;"")
		
		For ($t;1;Size of array:C274($al_rnHorario))
			GOTO RECORD:C242([TMT_Horario:166];$al_rnHorario{$t})
			$t_asig:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16;True:C214)
			$t_asigCurso:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Curso:5;True:C214)
			$t_msg:=__ ("^0 ^1, para el ciclo ^2 en el día, ^3, la hora ^4";$t_asig;$t_asigCurso;String:C10([TMT_Horario:166]No_Ciclo:14);String:C10([TMT_Horario:166]NumeroDia:1);String:C10([TMT_Horario:166]NumeroHora:2))
			APPEND TO ARRAY:C911($atMensajeTopeHorario;$t_msg)
		End for 
		
	End if 
	
End for 


If ($b_tope)
	OB SET:C1220($ob_result;"topeHorario";True:C214)
	OB SET ARRAY:C1227($ob_result;"atMensajeTopeHorario";$atMensajeTopeHorario)
End if 

CLEAR SET:C117("$horario")
REDUCE SELECTION:C351([TMT_Horario:166];0)
$0:=$ob_result