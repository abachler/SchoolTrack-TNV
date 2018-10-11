//%attributes = {}
  // TMT_CuentaHorasClases()
  // Por: Alberto Bachler: 10/05/13, 11:14:38
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_DATE:C307($d_fechaInicioSesiones)
C_LONGINT:C283($l_idAsignatura;$l_numeroDeDia_ISO;$l_numeroCiclo)

If (False:C215)
	C_LONGINT:C283(TMT_CuentaHorasClases ;$1)
End if 

$l_idAsignatura:=$1

READ WRITE:C146([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idAsignatura)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
[Asignaturas:18]Horas_Anuales:68:=0
While (Not:C34(End selection:C36([TMT_Horario:166])))
	$d_fechaInicioSesiones:=[TMT_Horario:166]SesionesDesde:12
	While ($d_fechaInicioSesiones<=[TMT_Horario:166]SesionesHasta:13)
		$l_numeroDeDia_ISO:=DT_GetDayNumber_ISO8601 ($d_fechaInicioSesiones)
		If ($l_numeroDeDia_ISO=[TMT_Horario:166]NumeroDia:1)
			$l_numeroCiclo:=TMT_retornaCiclo ($d_fechaInicioSesiones;PERIODOS_refConfiguracion ([TMT_Horario:166]Nivel:10))  // mono ticket 143138 
			If ($l_numeroCiclo=[TMT_Horario:166]No_Ciclo:14)
				If (DateIsValid ($d_fechaInicioSesiones;0))
					[Asignaturas:18]Horas_Anuales:68:=[Asignaturas:18]Horas_Anuales:68+1
				End if 
			End if 
		End if 
		$d_fechaInicioSesiones:=$d_fechaInicioSesiones+1
	End while 
	NEXT RECORD:C51([TMT_Horario:166])
End while 
SAVE RECORD:C53([Asignaturas:18])
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])