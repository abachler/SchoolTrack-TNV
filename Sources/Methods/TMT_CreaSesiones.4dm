//%attributes = {}
  // TMT_CreaSesiones()
  // Por: Alberto Bachler: 10/05/13, 11:11:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_DATE:C307($3)
C_DATE:C307($4)

C_DATE:C307($d_FechaSesion;$d_FinCreacionSesiones;$d_InicioCreacionSesiones)
C_LONGINT:C283($i;$l_IdProceso;$l_numeroDeCiclo;$l_numeroDia;$l_recNumCeldaHorario)

ARRAY DATE:C224($ad_fechasSesiones;0)
If (False:C215)
	C_LONGINT:C283(TMT_CreaSesiones ;$1)
	C_DATE:C307(TMT_CreaSesiones ;$3)
	C_DATE:C307(TMT_CreaSesiones ;$4)
End if 

$l_recNumCeldaHorario:=$1

READ ONLY:C145([TMT_Horario:166])
KRL_GotoRecord (->[TMT_Horario:166];$l_recNumCeldaHorario;False:C215)

READ ONLY:C145([Asignaturas:18])
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

$d_InicioCreacionSesiones:=[TMT_Horario:166]SesionesDesde:12
$d_FinCreacionSesiones:=Current date:C33(*)
Case of 
	: (Count parameters:C259=2)
		$d_InicioCreacionSesiones:=$2
		$d_FinCreacionSesiones:=[TMT_Horario:166]SesionesDesde:12
	: (Count parameters:C259=3)
		$d_InicioCreacionSesiones:=$2
		$d_FinCreacionSesiones:=$3
End case 
If ($d_FinCreacionSesiones>Current date:C33(*))
	$d_FinCreacionSesiones:=Current date:C33(*)
End if 

$d_FechaSesion:=$d_InicioCreacionSesiones
While ($d_FechaSesion<=$d_FinCreacionSesiones)
	If (DateIsValid ($d_FechaSesion;0))
		$l_numeroDeCiclo:=TMT_retornaCiclo ($d_FechaSesion;PERIODOS_refConfiguracion ([TMT_Horario:166]Nivel:10))
		$l_numeroDia:=DT_GetDayNumber_ISO8601 ($d_FechaSesion)
		If (($l_numeroDia=[TMT_Horario:166]NumeroDia:1) & ($l_numeroDeCiclo=[TMT_Horario:166]No_Ciclo:14))
			If (($d_FechaSesion>=[TMT_Horario:166]SesionesDesde:12) & ($d_FechaSesion<=[TMT_Horario:166]SesionesHasta:13))
				APPEND TO ARRAY:C911($ad_fechasSesiones;$d_FechaSesion)
			End if 
		End if 
	End if 
	$d_FechaSesion:=$d_FechaSesion+1
End while 

$l_IdProceso:=IT_Progress (1;0;0;"Creando sesiones de clases...")
For ($i;1;Size of array:C274($ad_fechasSesiones))
	ASrs_CreaRegistro ([TMT_Horario:166]ID_Asignatura:5;[TMT_Horario:166]NumeroHora:2;[TMT_Horario:166]No_Ciclo:14;$ad_fechasSesiones{$i})
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274($ad_fechasSesiones);"Creando sesiones de clases...\r"+String:C10($ad_fechasSesiones{$i};System date long:K1:3))
End for 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
