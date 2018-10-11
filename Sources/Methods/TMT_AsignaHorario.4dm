//%attributes = {}
  // TMT_AsignaHorario()
  // Por: Alberto Bachler: 18/05/13, 17:19:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_DATE:C307($2)
C_DATE:C307($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)

C_BOOLEAN:C305($b_FechaInicioValida;$b_FechaTerminoValida)
C_DATE:C307($d_inicioSesiones;$d_terminoSesiones)
C_LONGINT:C283($l_elemento;$l_numeroDeCiclo;$l_numeroDia_ISO;$l_numeroHora;$l_recNumAsignatura)

If (False:C215)
	C_LONGINT:C283(TMT_AsignaHorario ;$1)
	C_DATE:C307(TMT_AsignaHorario ;$2)
	C_DATE:C307(TMT_AsignaHorario ;$3)
	C_LONGINT:C283(TMT_AsignaHorario ;$4)
	C_LONGINT:C283(TMT_AsignaHorario ;$5)
	C_LONGINT:C283(TMT_AsignaHorario ;$6)
End if 

$l_recNumAsignatura:=$1
$d_inicioSesiones:=$2
$d_terminoSesiones:=$3
$l_numeroDia_ISO:=$4
$l_numeroHora:=$5
If (Count parameters:C259=6)
	$l_numeroDeCiclo:=$6
End if 
KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

If ($d_inicioSesiones=!00-00-00!)
	$d_inicioSesiones:=vdSTR_Periodos_InicioEjercicio
End if 

If ($d_terminoSesiones=!00-00-00!)
	$d_terminoSesiones:=vdSTR_Periodos_FinEjercicio
End if 

  // determino la primera fecha válida para el día despues de la fecha de inicio de aplicación
$b_FechaInicioValida:=TMT_FechaDiaValidos (->$d_inicioSesiones;vdSTR_Periodos_FinEjercicio;$l_numeroDia_ISO)

  // determino la última fecha valida para el día antes de la fecha de términod de aplicacion
$b_FechaTerminoValida:=TMT_FechaDiaValidos (->$d_terminoSesiones;$d_inicioSesiones;$l_numeroDia_ISO)

If ($b_FechaInicioValida & $b_FechaTerminoValida)
	CREATE RECORD:C68([TMT_Horario:166])
	[TMT_Horario:166]ID_Asignatura:5:=[Asignaturas:18]Numero:1
	[TMT_Horario:166]ID_Sala:6:=0
	[TMT_Horario:166]NumeroDia:1:=$l_numeroDia_ISO
	[TMT_Horario:166]NumeroHora:2:=$l_numeroHora
	$l_elemento:=Find in array:C230(aiSTR_Horario_HoraNo;[TMT_Horario:166]NumeroHora:2)
	If ($l_elemento>0)
		[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{$l_elemento}
		[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{$l_elemento}
	End if 
	[TMT_Horario:166]Sala:8:=""
	[TMT_Horario:166]ID_Teacher:9:=[Asignaturas:18]profesor_numero:4
	[TMT_Horario:166]Nivel:10:=[Asignaturas:18]Numero_del_Nivel:6
	[TMT_Horario:166]Curso:11:=[Asignaturas:18]Curso:5
	[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesiones
	[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesiones
	[TMT_Horario:166]No_Ciclo:14:=$l_numeroDeCiclo
	[TMT_Horario:166]TipoHora:16:=1
	SAVE RECORD:C53([TMT_Horario:166])
	TMT_CreaSesiones (Record number:C243([TMT_Horario:166]);$d_inicioSesiones;$d_terminoSesiones)
	TMT_CuentaHorasClases ([TMT_Horario:166]ID_Asignatura:5)
	
	$0:=1
End if 