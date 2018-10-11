//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 27-12-17, 15:06:49
  // ----------------------------------------------------
  // Método: STWA2_AnotacionResponsiveDAO
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
READ ONLY:C145([Alumnos:2])
C_OBJECT:C1216($o_parametros;$ob_raiz;$o_adjuntos)
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
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$t_categoria:=OB Get:C1224($o_parametros;"categoria")
		$l_idProfesor:=Num:C11(OB Get:C1224($o_parametros;"idprofesor"))
		$l_idasignatura:=Num:C11(OB Get:C1224($o_parametros;"idAsignatura"))
		$t_observacion:=OB Get:C1224($o_parametros;"observacion")
		$d_fecha:=Date:C102(OB Get:C1224($o_parametros;"fecha"))
		$l_idAsignaturaAnotacion:=Num:C11(OB Get:C1224($o_parametros;"idAsignaturaAnotacion"))
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		
		STR_LeePreferenciasConducta2 
		$l_indice:=Find in array:C230(<>atSTR_Anotaciones_motivo;$t_motivo)
		$matriz:=<>aiID_Matriz{$l_indice}
		$l_indice2:=Find in array:C230(aiSTR_IDCategoria;$matriz)
		
		Case of 
			: (ai_TipoAnotacion{$l_indice2}>0)
				$t_signo:="+"
				$l_puntajeMotivo:=<>aiSTR_Anotaciones_motivo_puntaj{$l_indice}
			: (ai_TipoAnotacion{$l_indice2}=0)
				$t_signo:="="
				$l_puntajeMotivo:=0
			: (ai_TipoAnotacion{$l_indice2}<0)
				$t_signo:="-"
				$l_puntajeMotivo:=<>aiSTR_Anotaciones_motivo_puntaj{$l_indice}*-1
		End case 
		
		If ($l_idasignatura#-1)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idasignatura)
			If ([Asignaturas:18]Asignatura:3=[Asignaturas:18]denominacion_interna:16)
				$t_asignatura:=[Asignaturas:18]Asignatura:3+" - ("+[Asignaturas:18]Curso:5+")"  //20180616 ASM Ticket 209368
			Else 
				$t_asignatura:=[Asignaturas:18]Asignatura:3+" "+"("+[Asignaturas:18]denominacion_interna:16+") - ("+[Asignaturas:18]Curso:5+")"  //20180616 ASM Ticket 209368
			End if 
		Else 
			$t_asignatura:="Sin Asignatura"
		End if 
		
		For ($i;1;Size of array:C274($al_alumnos))
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_alumnos{$i})
			
			CREATE RECORD:C68([Alumnos_Anotaciones:11])
			[Alumnos_Anotaciones:11]Fecha:1:=$d_fecha
			[Alumnos_Anotaciones:11]Alumno_Numero:6:=[Alumnos:2]numero:1
			[Alumnos_Anotaciones:11]Nivel_Numero:13:=[Alumnos:2]nivel_numero:29
			[Alumnos_Anotaciones:11]Motivo:3:=$t_motivo
			[Alumnos_Anotaciones:11]Profesor_Numero:5:=$l_idProfesor
			[Alumnos_Anotaciones:11]Observaciones:4:=$t_observacion
			[Alumnos_Anotaciones:11]Categoria:8:=$t_categoria
			[Alumnos_Anotaciones:11]Signo:7:=$t_signo
			[Alumnos_Anotaciones:11]Puntos:9:=$l_puntajeMotivo
			If ($t_asignatura#"")
				[Alumnos_Anotaciones:11]Observaciones:4:=$t_observacion+" ("+$t_asignatura+")"
				[Alumnos_Anotaciones:11]Asignatura:10:=$t_asignatura
			Else 
				[Alumnos_Anotaciones:11]Observaciones:4:=$t_observacion
			End if 
			SAVE RECORD:C53([Alumnos_Anotaciones:11])
			$t_mensaje:="Conducta: Registro de anotación para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Categoría: "+$t_categoria
			Log_RegisterEvtSTW ($t_mensaje;$userID)
			
			STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Anotaciones:11];->[Alumnos_Anotaciones:11]ID:12;$o_adjuntos)
			
		End for 
		OB SET:C1220($o_parametros;"idAsignatura";$l_idAsignaturaAnotacion)
		OB SET ARRAY:C1227($o_parametros;"alumnoClickIDArray";$al_alumnos)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="update")
		ARRAY LONGINT:C221($al_alumnos;0)
		$t_motivo:=OB Get:C1224($o_parametros;"motivo")
		$t_categoria:=OB Get:C1224($o_parametros;"categoria")
		$l_idProfesor:=Num:C11(OB Get:C1224($o_parametros;"idprofesor"))
		$l_idasignatura:=Num:C11(OB Get:C1224($o_parametros;"idAsignatura"))  //20180704 ASM ticket 211301
		$t_observacion:=OB Get:C1224($o_parametros;"observacion")
		$d_fecha:=Date:C102(OB Get:C1224($o_parametros;"fecha"))
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		$l_idAsignaturaAnotacion:=Num:C11(OB Get:C1224($o_parametros;"idAsignaturaAnotacion"))
		OB GET ARRAY:C1229($o_parametros;"alumnos";$al_alumnos)
		$o_adjuntos:=OB Get:C1224($o_parametros;"adjuntos")
		
		STR_LeePreferenciasConducta2 
		$l_indice:=Find in array:C230(<>atSTR_Anotaciones_motivo;$t_motivo)
		$matriz:=<>aiID_Matriz{$l_indice}
		$l_indice2:=Find in array:C230(aiSTR_IDCategoria;$matriz)
		
		Case of 
			: (ai_TipoAnotacion{$l_indice2}>0)
				$t_signo:="+"
				$l_puntajeMotivo:=<>aiSTR_Anotaciones_motivo_puntaj{$l_indice}
			: (ai_TipoAnotacion{$l_indice2}=0)
				$t_signo:="="
				$l_puntajeMotivo:=0
			: (ai_TipoAnotacion{$l_indice2}<0)
				$t_signo:="-"
				$l_puntajeMotivo:=<>aiSTR_Anotaciones_motivo_puntaj{$l_indice}*-1
		End case 
		
		If ($l_idasignatura#-1)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idasignatura)
			If ([Asignaturas:18]Asignatura:3=[Asignaturas:18]denominacion_interna:16)
				$t_asignatura:=[Asignaturas:18]Asignatura:3+" - ("+[Asignaturas:18]Curso:5+")"  //20180616 ASM Ticket 209368
			Else 
				$t_asignatura:=[Asignaturas:18]Asignatura:3+" "+"("+[Asignaturas:18]denominacion_interna:16+") - ("+[Asignaturas:18]Curso:5+")"  //20180616 ASM Ticket 209368
			End if 
		Else 
			$t_asignatura:="Sin Asignatura"
		End if 
		
		READ WRITE:C146([Alumnos_Anotaciones:11])
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Auto_UUID:15=$t_uuid)
		[Alumnos_Anotaciones:11]Fecha:1:=$d_fecha
		[Alumnos_Anotaciones:11]Motivo:3:=$t_motivo
		[Alumnos_Anotaciones:11]Profesor_Numero:5:=$l_idProfesor
		[Alumnos_Anotaciones:11]Observaciones:4:=$t_observacion
		[Alumnos_Anotaciones:11]Categoria:8:=$t_categoria
		[Alumnos_Anotaciones:11]Signo:7:=$t_signo
		[Alumnos_Anotaciones:11]Puntos:9:=$l_puntajeMotivo
		If ($t_asignatura#"")
			If ($t_observacion#$t_asignatura)  //ASM 20180827 ASM Ticket 215213
				[Alumnos_Anotaciones:11]Observaciones:4:=$t_observacion+" ("+$t_asignatura+")"
				[Alumnos_Anotaciones:11]Asignatura:10:=$t_asignatura
			End if 
		Else 
			If ($t_observacion#$t_asignatura)
				[Alumnos_Anotaciones:11]Observaciones:4:=$t_observacion
			End if 
		End if 
		SAVE RECORD:C53([Alumnos_Anotaciones:11])
		
		STWA2_ResponsiveAdjuntos ("insert";->[Alumnos_Anotaciones:11];->[Alumnos_Anotaciones:11]ID:12;$o_adjuntos)
		STWA2_ResponsiveAdjuntos ("delete";->[Alumnos_Anotaciones:11];->[Alumnos_Anotaciones:11]ID:12;$o_adjuntos)
		
		OB SET:C1220($o_parametros;"alumnoClickID";[Alumnos_Anotaciones:11]Alumno_Numero:6)
		
		$t_mensaje:="Conducta: Modificación de anotación para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
		$t_mensaje:=$t_mensaje+"Categoría: "+$t_categoria
		Log_RegisterEvtSTW ($t_mensaje;$userID)
		
		KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
		
		OB SET:C1220($o_parametros;"idAsignatura";$l_idAsignaturaAnotacion)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
	: ($t_accion="delete")
		
		READ WRITE:C146([Alumnos_Anotaciones:11])
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Auto_UUID:15=$t_uuid)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Anotaciones:11]Alumno_Numero:6)
		$l_alumnoClickID:=[Alumnos_Anotaciones:11]Alumno_Numero:6
		$t_CursoProfJefe:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
		$t_categoria:=[Alumnos_Anotaciones:11]Categoria:8
		$t_motivo:=[Alumnos_Anotaciones:11]Motivo:3
		$d_fecha:=[Alumnos_Anotaciones:11]Fecha:1
		If ((USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)) | ($t_CursoProfJefe=[Alumnos:2]curso:20))
			$t_mensaje:="Conducta: Eliminación de anotación para el alumno:  "+[Alumnos:2]apellidos_y_nombres:40+" , Curso:"+[Alumnos:2]curso:20+"\r"
			$t_mensaje:=$t_mensaje+"Motivo anotación: "+$t_motivo+"\rCategoría: "+$t_categoria+"\rFecha :"+String:C10($d_fecha)
			Log_RegisterEvtSTW ($t_mensaje;$userID)
			DELETE RECORD:C58([Alumnos_Anotaciones:11])
		End if 
		
		OB SET:C1220($o_parametros;"alumnoClickID";$l_alumnoClickID)
		STWA2_MO_BuildCargaAlumnoCond ($o_parametros;->$ob_raiz)
		$0:=$ob_raiz
		
End case 







