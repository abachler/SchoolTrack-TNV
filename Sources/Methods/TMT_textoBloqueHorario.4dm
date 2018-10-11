//%attributes = {}
  // TMT_textoBloqueHorario()
  // Por: Alberto Bachler: 10/06/13, 08:07:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_DATE:C307($5)
C_DATE:C307($6)
C_LONGINT:C283($7)

C_BOOLEAN:C305($b_FechaInicioValida;$b_FechaTerminoValida)
C_DATE:C307($d_fechaInicio;$d_FechaTermino;$d_inicioSesiones;$d_terminoSesiones)
C_LONGINT:C283($l_numeroDia_ISO)
C_TEXT:C284($t_asignatura;$t_contenidoCelda;$t_Curso;$t_profesor;$t_sala)

If (False:C215)
	C_TEXT:C284(TMT_textoBloqueHorario ;$0)
	C_TEXT:C284(TMT_textoBloqueHorario ;$1)
	C_TEXT:C284(TMT_textoBloqueHorario ;$2)
	C_TEXT:C284(TMT_textoBloqueHorario ;$3)
	C_TEXT:C284(TMT_textoBloqueHorario ;$4)
	C_DATE:C307(TMT_textoBloqueHorario ;$5)
	C_DATE:C307(TMT_textoBloqueHorario ;$6)
	C_LONGINT:C283(TMT_textoBloqueHorario ;$7)
End if 

$t_asignatura:=$1
$t_Curso:=$2
$t_sala:=$3
$t_profesor:=$4
$d_fechaInicio:=$5
$d_FechaTermino:=$6
$l_numeroDia_ISO:=$7

  // determino la primera fecha válida para el día despues de la fecha de inicio de aplicación
$d_inicioSesiones:=vdSTR_Periodos_InicioEjercicio
$b_FechaInicioValida:=(DateIsValid ($d_inicioSesiones;0))
$b_FechaInicioValida:=$b_FechaInicioValida & (DT_GetDayNumber_ISO8601 ($d_InicioSesiones)=$l_numeroDia_ISO)
While ((Not:C34($b_FechaInicioValida)) | ($d_inicioSesiones>vdSTR_Periodos_FinEjercicio))
	$d_inicioSesiones:=$d_inicioSesiones+1
	$b_FechaInicioValida:=(DateIsValid ($d_inicioSesiones;0))
	$b_FechaInicioValida:=$b_FechaInicioValida & (DT_GetDayNumber_ISO8601 ($d_inicioSesiones)=$l_numeroDia_ISO)
End while 

  // determino la última fecha valida para el día antes de la fecha de término de aplicacion
$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
$b_FechaTerminoValida:=(DateIsValid ($d_terminoSesiones;0))
$b_FechaTerminoValida:=$b_FechaTerminoValida & (DT_GetDayNumber_ISO8601 ($d_terminoSesiones)=$l_numeroDia_ISO)
While ((Not:C34($b_FechaTerminoValida)) | ($d_terminoSesiones<$d_inicioSesiones))
	$d_terminoSesiones:=$d_terminoSesiones-1
	$b_FechaTerminoValida:=(DateIsValid ($d_terminoSesiones;0))
	$b_FechaTerminoValida:=$b_FechaTerminoValida & (DT_GetDayNumber_ISO8601 ($d_terminoSesiones)=$l_numeroDia_ISO)
End while 

If (($d_fechaInicio>$d_inicioSesiones) | ($d_FechaTermino<$d_terminoSesiones))
	If (($t_Curso#vs_SelectedClass) & ($t_Curso#""))
		$t_contenidoCelda:=$t_asignatura+", "+$t_Curso+"\r"+$t_profesor+"\r"+$t_sala+"\r("+String:C10($d_fechaInicio;Internal date short:K1:7)+" - "+String:C10($d_FechaTermino;Internal date short:K1:7)+")"
	Else 
		$t_contenidoCelda:=$t_asignatura+"\r"+$t_profesor+"\r"+$t_sala+"\r("+String:C10($d_fechaInicio;Internal date short:K1:7)+" - "+String:C10($d_FechaTermino;Internal date short:K1:7)+")"
	End if 
Else 
	If (($t_Curso#vs_SelectedClass) & ($t_Curso#""))
		$t_contenidoCelda:=$t_asignatura+", "+$t_Curso+"\r"+$t_profesor+"\r"+$t_sala
	Else 
		$t_contenidoCelda:=$t_asignatura+"\r"+$t_profesor+"\r"+$t_sala
	End if 
End if 

$0:=$t_contenidoCelda
