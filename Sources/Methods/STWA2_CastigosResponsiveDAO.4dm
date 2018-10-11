//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 28-12-17, 08:22:37
  // ----------------------------------------------------
  // Método: STWA2_CastigosResponsiveDAO
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
READ ONLY:C145([Alumnos:2])
C_OBJECT:C1216($o_parametros;$ob_raiz)
C_TEXT:C284($t_uuid)
C_BOOLEAN:C305($b_cumplido)

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
		$l_hora:=Num:C11(OB Get:C1224($o_parametros;"hora"))
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$d_fecha:=Date:C102(OB Get:C1224($o_parametros;"fecha"))
		$l_idprofesor:=Num:C11(OB Get:C1224($o_parametros;"idprofesor"))
		$t_obs:=OB Get:C1224($o_parametros;"observacion")
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		$b_cumplido:=OB Get:C1224($o_parametros;"cumplido")
		
		For ($i;1;Size of array:C274($al_alumnos))
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_alumnos{$i})
			CREATE RECORD:C68([Alumnos_Castigos:9])
			[Alumnos_Castigos:9]Fecha:9:=$d_fecha
			[Alumnos_Castigos:9]Alumno_Numero:8:=[Alumnos:2]numero:1
			[Alumnos_Castigos:9]Motivo:2:=$t_motivo
			[Alumnos_Castigos:9]Horas_de_castigo:7:=$l_hora
			[Alumnos_Castigos:9]Profesor_Numero:6:=$l_idprofesor
			[Alumnos_Castigos:9]Observaciones:3:=$t_obs
			[Alumnos_Castigos:9]Nivel_Numero:11:=[Alumnos:2]nivel_numero:29
			[Alumnos_Castigos:9]Castigo_cumplido:4:=$b_cumplido
			SAVE RECORD:C53([Alumnos_Castigos:9])
			$t_mensaje:="Conducta: Registro de Medidas disciplinarias para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo : "+$t_motivo
			Log_RegisterEvtSTW ($t_mensaje;$userID)
			
			  //manejo los datos adjuntos de
			STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Castigos:9];->[Alumnos_Castigos:9]ID:10;$o_adjuntos)
		End for 
		
		OB SET ARRAY:C1227($o_parametros;"alumnoClickIDArray";$al_alumnos)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="update")
		$l_hora:=Num:C11(OB Get:C1224($o_parametros;"hora"))
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$d_fecha:=Date:C102(OB Get:C1224($o_parametros;"fecha"))
		$l_idprofesor:=Num:C11(OB Get:C1224($o_parametros;"idprofesor"))
		$t_obs:=OB Get:C1224($o_parametros;"observacion")
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		$b_cumplido:=OB Get:C1224($o_parametros;"cumplido")
		
		READ WRITE:C146([Alumnos_Castigos:9])
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Auto_UUID:12=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Castigos:9]Alumno_Numero:8)
		[Alumnos_Castigos:9]Fecha:9:=$d_fecha
		[Alumnos_Castigos:9]Motivo:2:=$t_motivo
		[Alumnos_Castigos:9]Horas_de_castigo:7:=$l_hora
		[Alumnos_Castigos:9]Profesor_Numero:6:=$l_idprofesor
		[Alumnos_Castigos:9]Observaciones:3:=$t_obs
		[Alumnos_Castigos:9]Nivel_Numero:11:=[Alumnos:2]nivel_numero:29
		[Alumnos_Castigos:9]Castigo_cumplido:4:=$b_cumplido
		SAVE RECORD:C53([Alumnos_Castigos:9])
		OB SET:C1220($o_parametros;"alumnoClickID";[Alumnos_Castigos:9]Alumno_Numero:8)
		STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Castigos:9];->[Alumnos_Castigos:9]ID:10;$o_adjuntos)
		STWA2_ResponsiveAdjuntos ("delete";->[Alumnos_Castigos:9];->[Alumnos_Castigos:9]ID:10;$o_adjuntos)
		KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
		
		$t_mensaje:="Conducta: Modificación de Medidas disciplinarias para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
		$t_mensaje:=$t_mensaje+"Motivo : "+$t_motivo+"\rFecha: "+String:C10($d_fecha)
		Log_RegisterEvtSTW ($t_mensaje;$userID)
		
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="delete")
		READ WRITE:C146([Alumnos_Castigos:9])
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Auto_UUID:12=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Castigos:9]Alumno_Numero:8)
		$l_alumnoClickID:=[Alumnos_Castigos:9]Alumno_Numero:8
		$t_CursoProfJefe:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
		$t_motivo:=[Alumnos_Castigos:9]Motivo:2
		$d_fecha:=[Alumnos_Castigos:9]Fecha:9
		If ((USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)) | ($t_CursoProfJefe=[Alumnos:2]curso:20))
			DELETE RECORD:C58([Alumnos_Castigos:9])
			$t_mensaje:="Conducta: Eliminación de Medidas disciplinarias para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo : "+$t_motivo+"\rFecha: "+String:C10($d_fecha)
			Log_RegisterEvtSTW ($t_mensaje;$userID)
		End if 
		
		OB SET:C1220($o_parametros;"alumnoClickID";$l_alumnoClickID)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
End case 


