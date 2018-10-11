//%attributes = {}


  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 08-01-18, 16:53:15
  // ----------------------------------------------------
  // Método: STWA2_LicenciasResponsiveDAO
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


READ ONLY:C145([Alumnos:2])
C_OBJECT:C1216($o_parametros;$ob_raiz)
C_TEXT:C284($t_uuid)
ARRAY TEXT:C222($at_uuidLicencias;0)

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
		ARRAY TEXT:C222($at_uuidLicencias;0)
		
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$d_fecha_desde:=Date:C102(OB Get:C1224($o_parametros;"fecha_desde"))
		$d_fecha_hasta:=Date:C102(OB Get:C1224($o_parametros;"fecha_hasta"))
		$t_obs:=OB Get:C1224($o_parametros;"observacion")
		$reginasist:=Num:C11(OB Get:C1224($o_parametros;"reginasist"))
		$reginasistfutura:=Num:C11(OB Get:C1224($o_parametros;"reginasistfutura"))
		$t_motivoEspecial:=OB Get:C1224($o_parametros;"motivoespecial")
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		
		For ($i;1;Size of array:C274($al_alumnos))
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_alumnos{$i})
			CREATE RECORD:C68([Alumnos_Licencias:73])
			[Alumnos_Licencias:73]Fecha_registro:8:=Current date:C33(*)
			[Alumnos_Licencias:73]Desde:2:=$d_fecha_desde
			[Alumnos_Licencias:73]Hasta:3:=$d_fecha_hasta
			[Alumnos_Licencias:73]Alumno_numero:1:=[Alumnos:2]numero:1
			[Alumnos_Licencias:73]Motivo_especial:13:=$t_motivoEspecial
			[Alumnos_Licencias:73]Tipo_licencia:4:=$t_motivo
			[Alumnos_Licencias:73]Observaciones:5:=$t_obs
			[Alumnos_Licencias:73]RegistradaPor_Numero:7:=$userID
			[Alumnos_Licencias:73]Nivel_Numero:10:=[Alumnos:2]nivel_numero:29
			SAVE RECORD:C53([Alumnos_Licencias:73])
			APPEND TO ARRAY:C911($at_uuidLicencias;[Alumnos_Licencias:73]Auto_UUID:12)
			
			$t_mensaje:="Conducta: Registro de Licencia  Nº "+String:C10([Alumnos_Licencias:73]ID:6)+" para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo: "+$t_motivo+"\rDesde: "+String:C10($d_fecha_desde)+"- Hasta: "+String:C10($d_fecha_hasta)
			Log_RegisterEvtSTW ($t_mensaje;$userID)
			
			  //manejo los datos adjuntos de
			STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Licencias:73];->[Alumnos_Licencias:73]ID:6;$o_adjuntos)
			
			
		End for 
		
		If (($reginasist=1) | ($reginasistfutura=1))
			
			C_OBJECT:C1216($o_parametrosInasistencias)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia";$reginasist)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia_futura";$reginasistfutura)
			OB SET:C1220($o_parametrosInasistencias;"fecha_desde";$d_fecha_desde)
			OB SET:C1220($o_parametrosInasistencias;"fecha_hasta";$d_fecha_hasta)
			OB SET:C1220($o_parametrosInasistencias;"nivel_numero";[Alumnos:2]nivel_numero:29)
			OB SET:C1220($o_parametrosInasistencias;"motivo";$t_motivo)
			OB SET ARRAY:C1227($o_parametrosInasistencias;"licenciasUUID";$at_uuidLicencias)
			$l_process:=New process:C317("Al_CreaInasistenciaxLicencia";0;"CreaInasistenciaxLicencia";$o_parametrosInasistencias)
			
		End if 
		
		PREF_Set ($userID;"LicenciaCreaInasistencia";String:C10($reginasist))
		PREF_Set ($userID;"LicenciaCreaInasistenciaFutura";String:C10($reginasistfutura))
		
		
		OB SET ARRAY:C1227($o_parametros;"alumnoClickIDArray";$al_alumnos)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="update")
		
		ARRAY LONGINT:C221($al_alumnos;0)
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$d_fecha_desde:=Date:C102(OB Get:C1224($o_parametros;"fecha_desde"))
		$d_fecha_hasta:=Date:C102(OB Get:C1224($o_parametros;"fecha_hasta"))
		$t_obs:=OB Get:C1224($o_parametros;"observacion")
		$reginasist:=Num:C11(OB Get:C1224($o_parametros;"reginasist"))
		$reginasistfutura:=Num:C11(OB Get:C1224($o_parametros;"reginasistfutura"))
		$t_motivoEspecial:=OB Get:C1224($o_parametros;"motivoespecial")
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		
		READ WRITE:C146([Alumnos_Licencias:73])
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Auto_UUID:12=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
		[Alumnos_Licencias:73]Desde:2:=$d_fecha_desde
		[Alumnos_Licencias:73]Hasta:3:=$d_fecha_hasta
		[Alumnos_Licencias:73]Motivo_especial:13:=$t_motivoEspecial
		[Alumnos_Licencias:73]Tipo_licencia:4:=$t_motivo
		[Alumnos_Licencias:73]Observaciones:5:=$t_obs
		[Alumnos_Licencias:73]Fecha_registro:8:=Current date:C33(*)
		[Alumnos_Licencias:73]Nivel_Numero:10:=[Alumnos:2]numero:1
		SAVE RECORD:C53([Alumnos_Licencias:73])
		APPEND TO ARRAY:C911($at_uuidLicencias;[Alumnos_Licencias:73]Auto_UUID:12)
		
		If (($reginasist=1) | ($reginasistfutura=1))
			
			C_OBJECT:C1216($o_parametrosInasistencias)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia";$reginasist)
			OB SET:C1220($o_parametrosInasistencias;"crear_inasistencia_futura";$reginasistfutura)
			OB SET:C1220($o_parametrosInasistencias;"fecha_desde";$d_fecha_desde)
			OB SET:C1220($o_parametrosInasistencias;"fecha_hasta";$d_fecha_hasta)
			OB SET:C1220($o_parametrosInasistencias;"nivel_numero";[Alumnos:2]nivel_numero:29)
			OB SET:C1220($o_parametrosInasistencias;"motivo";$t_motivo)
			OB SET ARRAY:C1227($o_parametrosInasistencias;"licenciasUUID";$at_uuidLicencias)
			$l_process:=New process:C317("Al_CreaInasistenciaxLicencia";0;"CreaInasistenciaxLicencia";$o_parametrosInasistencias)
			
		End if 
		
		PREF_Set ($userID;"LicenciaCreaInasistencia";String:C10($reginasist))
		PREF_Set ($userID;"LicenciaCreaInasistenciaFutura";String:C10($reginasistfutura))
		
		OB SET:C1220($o_parametros;"alumnoClickID";[Alumnos_Licencias:73]Alumno_numero:1)
		STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Licencias:73];->[Alumnos_Licencias:73]ID:6;$o_adjuntos)
		STWA2_ResponsiveAdjuntos ("delete";->[Alumnos_Licencias:73];->[Alumnos_Licencias:73]ID:6;$o_adjuntos)
		KRL_UnloadReadOnly (->[Alumnos_Licencias:73])
		
		$t_mensaje:="Conducta: Modificación de Licencia Nº "+String:C10([Alumnos_Licencias:73]ID:6)+" para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
		$t_mensaje:=$t_mensaje+"Motivo: "+$t_motivo+"\rDesde: "+String:C10($d_fecha_desde)+"- Hasta: "+String:C10($d_fecha_hasta)
		Log_RegisterEvtSTW ($t_mensaje;$userID)
		
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="delete")
		READ WRITE:C146([Alumnos_Licencias:73])
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Auto_UUID:12=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
		$l_alumnoClickID:=[Alumnos_Licencias:73]Alumno_numero:1
		$t_CursoProfJefe:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
		$t_motivo:=[Alumnos_Licencias:73]Tipo_licencia:4
		$d_fecha_desde:=[Alumnos_Licencias:73]Desde:2
		$d_fecha_hasta:=[Alumnos_Licencias:73]Hasta:3
		$l_noLicencia:=[Alumnos_Licencias:73]ID:6
		If ((USR_checkRights ("D";->[Alumnos_Licencias:73];$userID)) | ($t_CursoProfJefe=[Alumnos:2]curso:20))
			DELETE RECORD:C58([Alumnos_Licencias:73])
			$t_mensaje:="Conducta: Eliminación de Licencia Nº "+String:C10($l_noLicencia)+" para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo: "+$t_motivo+"\rDesde: "+String:C10($d_fecha_desde)+"- Hasta: "+String:C10($d_fecha_hasta)
			Log_RegisterEvtSTW ($t_mensaje;$userID)
		End if 
		
		OB SET:C1220($o_parametros;"alumnoClickID";$l_alumnoClickID)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
End case 


