//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 28-12-17, 15:48:53
  // ----------------------------------------------------
  // Método: STWA2_SuspensionesResponsiveDAO
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

READ ONLY:C145([Alumnos:2])
C_OBJECT:C1216($o_parametros;$ob_raiz)
ARRAY TEXT:C222($at_uuidSuspensiones;0)
C_TEXT:C284($t_uuid)
$y_Names:=$1
$y_Data:=$2
$t_accion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"accion")
$t_parametros:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"parametros")
$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$userName:=USR_GetUserName ($userID)
$o_parametros:=OB_JsonToObject ($t_parametros)


Case of 
	: ($t_accion="insert")
		
		ARRAY LONGINT:C221($al_alumnos;0)
		ARRAY TEXT:C222($at_uuidSuspensiones;0)
		
		$d_fecha_desde:=Date:C102(OB Get:C1224($o_parametros;"fecha_desde"))
		$d_fecha_hasta:=Date:C102(OB Get:C1224($o_parametros;"fecha_hasta"))
		$l_idprofesor:=Num:C11(OB Get:C1224($o_parametros;"idprofesor"))
		$t_obs:=OB Get:C1224($o_parametros;"observacion")
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$reginasist:=Num:C11(OB Get:C1224($o_parametros;"reginasist"))
		$reginasistfutura:=Num:C11(OB Get:C1224($o_parametros;"reginasistfutura"))
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		
		C_LONGINT:C283($feriados)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$feriados)
		QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1>=$d_fecha_desde;*)
		QUERY:C277([xShell_Feriados:71]; & [xShell_Feriados:71]Fecha:1<=$d_fecha_hasta)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$iDays:=$d_fecha_hasta-$d_fecha_desde+1-$feriados
		
		PREF_Set ($userID;"SuspencionCreaInasistencia";String:C10($reginasist))
		PREF_Set ($userID;"SuspencionCreaInasistenciaFutura";String:C10($reginasistfutura))
		
		For ($i;1;Size of array:C274($al_alumnos))
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_alumnos{$i})
			CREATE RECORD:C68([Alumnos_Suspensiones:12])
			[Alumnos_Suspensiones:12]Desde:5:=$d_fecha_desde
			[Alumnos_Suspensiones:12]Hasta:6:=$d_fecha_hasta
			[Alumnos_Suspensiones:12]Alumno_Numero:7:=[Alumnos:2]numero:1
			[Alumnos_Suspensiones:12]Nivel_Numero:10:=[Alumnos:2]nivel_numero:29
			[Alumnos_Suspensiones:12]Motivo:2:=$t_motivo
			[Alumnos_Suspensiones:12]Días_de_suspensión:3:=$iDays
			[Alumnos_Suspensiones:12]Profesor_Numero:4:=$l_idprofesor
			[Alumnos_Suspensiones:12]Observaciones:8:=$t_obs
			SAVE RECORD:C53([Alumnos_Suspensiones:12])
			APPEND TO ARRAY:C911($at_uuidSuspensiones;[Alumnos_Suspensiones:12]Auto_UUID:12)
			$t_mensaje:="Conducta: Registro de Suspensión para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo: "+$t_motivo+"\rDesde: "+String:C10($d_fecha_desde)+"- Hasta: "+String:C10($d_fecha_hasta)
			Log_RegisterEvtSTW ($t_mensaje;$userID)
			
			STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Suspensiones:12];->[Alumnos_Suspensiones:12]ID:9;$o_adjuntos)
			
		End for 
		
		If (($reginasist=1) | ($reginasistfutura=1))
			C_OBJECT:C1216($o_parametrosInasistencias)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia";$reginasist)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia_futura";$reginasistfutura)
			OB SET:C1220($o_parametrosInasistencias;"fecha_desde";$d_fecha_desde)
			OB SET:C1220($o_parametrosInasistencias;"fecha_hasta";$d_fecha_hasta)
			OB SET:C1220($o_parametrosInasistencias;"nivel_numero";[Alumnos:2]nivel_numero:29)
			OB SET:C1220($o_parametrosInasistencias;"motivo";$t_motivo)
			OB SET ARRAY:C1227($o_parametrosInasistencias;"uuidSuspensiones";$at_uuidSuspensiones)
			$l_process:=New process:C317("AL_CreaInasistenciaxSuspension";0;"CreaInasistenciaxSuspension";$o_parametrosInasistencias)
		End if 
		
		OB SET ARRAY:C1227($o_parametros;"alumnoClickIDArray";$al_alumnos)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="update")
		ARRAY LONGINT:C221($al_alumnos;0)
		$d_fecha_desde:=Date:C102(OB Get:C1224($o_parametros;"fecha_desde"))
		$d_fecha_hasta:=Date:C102(OB Get:C1224($o_parametros;"fecha_hasta"))
		$l_idprofesor:=Num:C11(OB Get:C1224($o_parametros;"idprofesor"))
		$t_obs:=OB Get:C1224($o_parametros;"observacion")
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$reginasist:=Num:C11(OB Get:C1224($o_parametros;"reginasist"))
		$reginasistfutura:=Num:C11(OB Get:C1224($o_parametros;"reginasistfutura"))
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		
		C_LONGINT:C283($feriados)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$feriados)
		QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1>=$d_fecha_desde;*)
		QUERY:C277([xShell_Feriados:71]; & [xShell_Feriados:71]Fecha:1<=$d_fecha_hasta)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$iDays:=$d_fecha_hasta-$d_fecha_desde+1-$feriados
		
		PREF_Set ($userID;"SuspencionCreaInasistencia";String:C10($reginasist))
		PREF_Set ($userID;"SuspencionCreaInasistenciaFutura";String:C10($reginasistfutura))
		
		READ WRITE:C146([Alumnos_Suspensiones:12])
		QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Auto_UUID:12=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Suspensiones:12]Alumno_Numero:7)
		[Alumnos_Suspensiones:12]Desde:5:=$d_fecha_desde
		[Alumnos_Suspensiones:12]Hasta:6:=$d_fecha_hasta
		[Alumnos_Suspensiones:12]Alumno_Numero:7:=[Alumnos:2]numero:1
		[Alumnos_Suspensiones:12]Nivel_Numero:10:=[Alumnos:2]nivel_numero:29
		[Alumnos_Suspensiones:12]Motivo:2:=$t_motivo
		[Alumnos_Suspensiones:12]Días_de_suspensión:3:=$iDays
		[Alumnos_Suspensiones:12]Profesor_Numero:4:=$l_idprofesor
		[Alumnos_Suspensiones:12]Observaciones:8:=$t_obs
		SAVE RECORD:C53([Alumnos_Suspensiones:12])
		APPEND TO ARRAY:C911($at_uuidSuspensiones;[Alumnos_Suspensiones:12]Auto_UUID:12)
		
		KRL_ReloadAsReadOnly (->[Alumnos_Suspensiones:12])
		STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Suspensiones:12];->[Alumnos_Suspensiones:12]ID:9;$o_adjuntos)
		STWA2_ResponsiveAdjuntos ("delete";->[Alumnos_Suspensiones:12];->[Alumnos_Suspensiones:12]ID:9;$o_adjuntos)
		
		$t_mensaje:="Conducta: Modificación de Suspensión para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
		$t_mensaje:=$t_mensaje+"Motivo: "+$t_motivo+"\rDesde: "+String:C10($d_fecha_desde)+" Hasta: "+String:C10($d_fecha_hasta)
		Log_RegisterEvtSTW ($t_mensaje;$userID)
		
		If (($reginasist=1) | ($reginasistfutura=1))
			C_OBJECT:C1216($o_parametrosInasistencias)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia";$reginasist)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia_futura";$reginasistfutura)
			OB SET:C1220($o_parametrosInasistencias;"fecha_desde";$d_fecha_desde)
			OB SET:C1220($o_parametrosInasistencias;"fecha_hasta";$d_fecha_hasta)
			OB SET:C1220($o_parametrosInasistencias;"nivel_numero";[Alumnos:2]nivel_numero:29)
			OB SET:C1220($o_parametrosInasistencias;"motivo";$t_motivo)
			OB SET ARRAY:C1227($o_parametrosInasistencias;"uuidSuspensiones";$at_uuidSuspensiones)
			$l_process:=New process:C317("AL_CreaInasistenciaxSuspension";0;"CreaInasistenciaxSuspension";$o_parametrosInasistencias)
		End if 
		
		OB SET:C1220($o_parametros;"alumnoClickID";[Alumnos:2]numero:1)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="delete")
		READ WRITE:C146([Alumnos_Suspensiones:12])
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Auto_UUID:12=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Suspensiones:12]Alumno_Numero:7)
		$l_alumnoClickID:=[Alumnos_Suspensiones:12]Alumno_Numero:7
		$t_CursoProfJefe:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
		$t_motivo:=[Alumnos_Suspensiones:12]Motivo:2
		$d_fecha_desde:=[Alumnos_Suspensiones:12]Desde:5
		$d_fecha_hasta:=[Alumnos_Suspensiones:12]Hasta:6
		If ((USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)) | ($t_CursoProfJefe=[Alumnos:2]curso:20))
			$t_mensaje:="Conducta: Eliminación de Suspensión para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo: "+$t_motivo+"\rDesde: "+String:C10($d_fecha_desde)+" Hasta: "+String:C10($d_fecha_hasta)
			Log_RegisterEvtSTW ($t_mensaje;$userID)
			DELETE RECORD:C58([Alumnos_Suspensiones:12])
		End if 
		
		OB SET:C1220($o_parametros;"alumnoClickID";$l_alumnoClickID)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
End case 
