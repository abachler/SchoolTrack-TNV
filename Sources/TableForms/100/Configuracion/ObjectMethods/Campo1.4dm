  // [xxSTR_Periodos].Configuracion.Campo1()
  // Por: Alberto Bachler: 14/06/13, 18:42:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

_O_C_INTEGER:C282($i_horas)
C_LONGINT:C283($l_Horas_a_añadir;$l_numeroHorasAntesCambio)
C_TIME:C306($h_duracionHoraEstandar;$h_InicioHoraSiguiente)

ARRAY LONGINT:C221($ai_niveles_config_per;0)



$l_numeroHorasAntesCambio:=Size of array:C274(aiSTR_Horario_HoraNo)
$h_duracionHoraEstandar:=[xxSTR_Periodos:100]DuracionHoraEstandar:12
Case of 
	: ([xxSTR_Periodos:100]Horas_Jornada:9<Size of array:C274(aiSTR_Horario_HoraNo))
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([TMT_Horario:166])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$ai_niveles_config_per)
		QUERY WITH ARRAY:C644([TMT_Horario:166]Nivel:10;$ai_niveles_config_per)
		QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2>[xxSTR_Periodos:100]Horas_Jornada:9;*)
		QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]TipoHora:16=1)
		If (Records in selection:C76([TMT_Horario:166])>0)
			CD_Dlog (0;__ ("Existen bloques asignados al horario en las horas que quiere quitar, si efectivamente desea quitar estas horas primero elimine los bloques que no utilizará en el  horario."))
			[xxSTR_Periodos:100]Horas_Jornada:9:=Size of array:C274(aiSTR_Horario_HoraNo)
			REDUCE SELECTION:C351([TMT_Horario:166];0)
		Else 
			AT_Delete ([xxSTR_Periodos:100]Horas_Jornada:9+1;$l_numeroHorasAntesCambio-[xxSTR_Periodos:100]Horas_Jornada:9;->aiSTR_Horario_HoraNo;->alSTR_Horario_Desde;->alSTR_Horario_Hasta;->alSTR_Horario_Duracion;->alSTR_Horario_RefTipoHora;->atSTR_Horario_TipoHora;->atSTR_Horario_HoraAlias)
		End if 
		SAVE RECORD:C53([xxSTR_Periodos:100])
		
	: ([xxSTR_Periodos:100]Horas_Jornada:9=Size of array:C274(aiSTR_Horario_HoraNo))
		SAVE RECORD:C53([xxSTR_Periodos:100])
		
	: ([xxSTR_Periodos:100]Horas_Jornada:9>Size of array:C274(aiSTR_Horario_HoraNo))
		If (Size of array:C274(aiSTR_Horario_HoraNo)=0)
			$h_InicioHoraSiguiente:=[xxSTR_Periodos:100]HoraInicioJornada:6
		Else 
			$h_InicioHoraSiguiente:=alSTR_Horario_Hasta{Size of array:C274(aiSTR_Horario_HoraNo)}
		End if 
		$l_Horas_a_añadir:=[xxSTR_Periodos:100]Horas_Jornada:9-$l_numeroHorasAntesCambio
		For ($i_horas;$l_numeroHorasAntesCambio+1;[xxSTR_Periodos:100]Horas_Jornada:9)
			APPEND TO ARRAY:C911(aiSTR_Horario_HoraNo;$i_horas)
			APPEND TO ARRAY:C911(alSTR_Horario_Desde;$h_InicioHoraSiguiente)
			APPEND TO ARRAY:C911(alSTR_Horario_Hasta;$h_InicioHoraSiguiente+$h_duracionHoraEstandar)
			APPEND TO ARRAY:C911(alSTR_Horario_Duracion;$h_duracionHoraEstandar)
			APPEND TO ARRAY:C911(alSTR_Horario_RefTipoHora;1)
			APPEND TO ARRAY:C911(atSTR_Horario_TipoHora;<>atSTR_Horario_TipoHora{1})
			APPEND TO ARRAY:C911(atSTR_Horario_HoraAlias;String:C10($i_horas))
			$h_InicioHoraSiguiente:=alSTR_Horario_Hasta{Size of array:C274(alSTR_Horario_Hasta)}
		End for 
		SAVE RECORD:C53([xxSTR_Periodos:100])
End case 



