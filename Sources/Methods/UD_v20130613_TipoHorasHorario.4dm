//%attributes = {}
  // UD_v20130613_TipoHorasHorario()
  // Por: Alberto Bachler: 13/06/13, 17:52:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_FechaInicioValida;$b_FechaTerminoValida)
C_DATE:C307($d_inicioSesiones;$d_terminoSesiones)
_O_C_INTEGER:C282($i_horas;$i_registros)
C_LONGINT:C283($l_elemento;$l_IdProceso;$l_refObjetoOT)
C_TIME:C306($h_duracion)

ARRAY LONGINT:C221($al_niveles;0)
ARRAY LONGINT:C221($al_RecNums;0)

ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)

PERIODOS_Init 

ALL RECORDS:C47([xxSTR_Periodos:100])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Periodos:100];$al_RecNums;"")

LONGINT ARRAY FROM SELECTION:C647([xxSTR_Periodos:100];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([xxSTR_Periodos:100])
	GOTO RECORD:C242([xxSTR_Periodos:100];$al_RecNums{$i_registros})
	$l_refObjetoOT:=OT BLOBToObject ([xxSTR_Periodos:100]Horarios:8)
	OT GetArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
	If ([xxSTR_Periodos:100]Horas_Jornada:9#Size of array:C274(aiSTR_Horario_HoraNo))
		[xxSTR_Periodos:100]Horas_Jornada:9:=Size of array:C274(aiSTR_Horario_HoraNo)
	End if 
	If ([xxSTR_Periodos:100]Horas_Jornada:9>0)
		OT GetArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
		OT GetArray ($l_refObjetoOT;"alSTR_Horario_Desde";alSTR_Horario_Desde)
		OT GetArray ($l_refObjetoOT;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
		OT GetArray ($l_refObjetoOT;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
		vlSTR_Horario_TipoCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_TipoCiclos")
		vlSTR_Horario_NoCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_NoCiclos")
		vlSTR_Horario_DiasCiclo:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_DiasCiclo")
		vlSTR_Horario_DiaInicioCiclo:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_DiaInicioCiclo")
		vlSTR_Horario_SabadoLabor:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_SabadoLabor")
		vlSTR_Horario_ResetCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_ResetCiclos")
		OT GetArray ($l_refObjetoOT;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
		OT GetArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
		OT Clear ($l_refObjetoOT)
		ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;Size of array:C274(aiSTR_Horario_HoraNo))
		For ($i_horas;1;Size of array:C274(aiSTR_Horario_HoraNo))
			$h_duracion:=alSTR_Horario_Hasta{$i_horas}-alSTR_Horario_Desde{$i_horas}
			If ($h_duracion>?00:20:00?)
				alSTR_Horario_RefTipoHora{$i_horas}:=1
			Else 
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
				SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_niveles)
				QUERY WITH ARRAY:C644([TMT_Horario:166]Nivel:10;$al_niveles)
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2;=;aiSTR_Horario_HoraNo{$i_horas};*)
				QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]ID_Asignatura:5;>;0)
				If (Records in selection:C76([TMT_Horario:166])=0)
					alSTR_Horario_RefTipoHora{$i_horas}:=0
				Else 
					alSTR_Horario_RefTipoHora{$i_horas}:=1
				End if 
			End if 
		End for 
	End if 
	
	$l_refObjetoOT:=OT New 
	OT PutArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
	OT PutArray ($l_refObjetoOT;"alSTR_Horario_Desde";alSTR_Horario_Desde)
	OT PutArray ($l_refObjetoOT;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
	OT PutArray ($l_refObjetoOT;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
	OT PutLong ($l_refObjetoOT;"vlSTR_Horario_TipoCiclos";vlSTR_Horario_TipoCiclos)
	OT PutLong ($l_refObjetoOT;"vlSTR_Horario_NoCiclos";vlSTR_Horario_NoCiclos)
	OT PutLong ($l_refObjetoOT;"vlSTR_Horario_DiasCiclo";vlSTR_Horario_DiasCiclo)
	OT PutLong ($l_refObjetoOT;"vlSTR_Horario_DiaInicioCiclo";vlSTR_Horario_DiaInicioCiclo)
	OT PutLong ($l_refObjetoOT;"vlSTR_Horario_SabadoLabor";vlSTR_Horario_SabadoLabor)
	OT PutLong ($l_refObjetoOT;"vlSTR_Horario_ResetCiclos";vlSTR_Horario_ResetCiclos)
	OT PutArray ($l_refObjetoOT;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
	OT PutArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
	$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
	[xxSTR_Periodos:100]Horarios:8:=$x_blob
	OT Clear ($l_refObjetoOT)
	
	If (Size of array:C274(alSTR_Horario_Desde)>0)
		SORT ARRAY:C229(alSTR_Horario_Desde;>)
		[xxSTR_Periodos:100]HoraInicioJornada:6:=alSTR_Horario_Desde{1}
		[xxSTR_Periodos:100]DuracionHoraEstandar:12:=0
		$h_duracion:=0
		For ($i_horas;1;Size of array:C274(alSTR_Horario_Desde))
			$h_duracion:=alSTR_Horario_Hasta{$i_horas}-alSTR_Horario_Desde{$i_horas}
			If ($h_duracion>[xxSTR_Periodos:100]DuracionHoraEstandar:12)
				[xxSTR_Periodos:100]DuracionHoraEstandar:12:=$h_duracion
			End if 
		End for 
	Else 
		[xxSTR_Periodos:100]HoraInicioJornada:6:=0
	End if 
	SAVE RECORD:C53([xxSTR_Periodos:100])
End for 
KRL_UnloadReadOnly (->[xxSTR_Periodos:100])


CREATE EMPTY SET:C140([TMT_Horario:166];"$sabadoIncorrecto")
$l_IdProceso:=IT_Progress (1;0;0;"Normalizando registros de asignación de horario...")
ALL RECORDS:C47([TMT_Horario:166])
ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]Nivel:10;>)
LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([TMT_Horario:166])
	GOTO RECORD:C242([TMT_Horario:166];$al_RecNums{$i_registros})
	PERIODOS_LoadData ([TMT_Horario:166]Nivel:10)
	
	If (([TMT_Horario:166]NumeroDia:1=6) & (vlSTR_Horario_SabadoLabor=0))
		ADD TO SET:C119([TMT_Horario:166];"$sabadoIncorrecto")
	End if 
	
	If ([TMT_Horario:166]NumeroHora:2>0)
		$l_elemento:=Find in array:C230(aiSTR_Horario_HoraNo;[TMT_Horario:166]NumeroHora:2)
		If ($l_elemento>0)
			[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{$l_elemento}
			[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{$l_elemento}
		End if 
	End if 
	
	
	If ([TMT_Horario:166]SesionesDesde:12=!00-00-00!)
		[TMT_Horario:166]SesionesDesde:12:=vdSTR_Periodos_InicioEjercicio
	End if 
	If ([TMT_Horario:166]SesionesHasta:13=!00-00-00!)
		[TMT_Horario:166]SesionesHasta:13:=vdSTR_Periodos_FinEjercicio
	End if 
	
	  // determino la primera fecha válida para el día despues de la fecha de inicio de aplicación
	$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
	$b_FechaInicioValida:=TMT_FechaDiaValidos (->$d_inicioSesiones;vdSTR_Periodos_FinEjercicio;[TMT_Horario:166]NumeroDia:1)
	If ($b_FechaInicioValida)
		[TMT_Horario:166]SesionesDesde:12:=$d_inicioSesiones
	End if 
	$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
	$b_FechaTerminoValida:=TMT_FechaDiaValidos (->$d_terminoSesiones;$d_inicioSesiones;[TMT_Horario:166]NumeroDia:1)
	If ($b_FechaTerminoValida)
		[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesiones
	End if 
	
	If (([TMT_Horario:166]Hasta:4-[TMT_Horario:166]Desde:3<=1200) & ([TMT_Horario:166]ID_Asignatura:5=0))
		[TMT_Horario:166]TipoHora:16:=0
	Else 
		[TMT_Horario:166]TipoHora:16:=1
	End if 
	
	SAVE RECORD:C53([TMT_Horario:166])
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)

If (Records in set:C195("$sabadoIncorrecto")>0)
	USE SET:C118("$sabadoIncorrecto")
	KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[TMT_Horario:166]ID_Asignatura:5)
	QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]NumeroDia:15=6)
	KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
	KRL_DeleteSelection (->[Asignaturas_RegistroSesiones:168])
	KRL_DeleteSelection (->[TMT_Horario:166])
End if 

KRL_UnloadReadOnly (->[xxSTR_Periodos:100])
KRL_UnloadReadOnly (->[TMT_Horario:166])

