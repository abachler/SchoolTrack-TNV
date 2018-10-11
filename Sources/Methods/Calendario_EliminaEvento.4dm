//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 07-05-18, 20:35:34
  // ----------------------------------------------------
  // Método: Calendario_EliminaEvento
  // Descripción
  // Elimina evento
  //
  // Parámetros
  // ----------------------------------------------------
C_OBJECT:C1216($ob_raiz)
C_TEXT:C284($t_uuidEvento;$t_evento)
C_LONGINT:C283($l_idUsuario;$l_profID)
C_BOOLEAN:C305($b_permisoEliminar;$b_desdeSTWA)
C_DATE:C307($d_fechaEvento)

$t_uuidEvento:=$1
$l_idUsuario:=$2
$b_desdeSTWA:=$3
$l_profID:=KRL_GetNumericFieldData (->[xShell_Users:47]No:1;->$l_idUsuario;->[xShell_Users:47]NoEmployee:7)

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Asignaturas_Eventos:170])

KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]Auto_UUID:18;->$t_uuidEvento;False:C215)
If (Records in selection:C76([Asignaturas_Eventos:170])=1)
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Eventos:170]ID_asignatura:1;False:C215)
	If (Records in selection:C76([Asignaturas:18])=1)
		$b_permisoEliminar:=(USR_checkRights ("M";->[Asignaturas:18];$l_idUsuario)) | ([Asignaturas:18]profesor_numero:4=$l_profID) | ([Asignaturas:18]profesor_firmante_numero:33=$l_profID)
		If ($b_permisoEliminar)
			If (KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]Auto_UUID:18;->$t_uuidEvento;True:C214)>=0)
				$t_evento:=[Asignaturas_Eventos:170]Evento:3
				$d_fechaEvento:=[Asignaturas_Eventos:170]Fecha:2
				If (KRL_DeleteRecord (->[Asignaturas_Eventos:170])=0)
					OB SET:C1220($ob_raiz;"resultado";"0")
					OB SET:C1220($ob_raiz;"error";"-1")
					OB SET:C1220($ob_raiz;"mensaje";"El evento no pudo ser eliminado.")
				Else 
					OB SET:C1220($ob_raiz;"resultado";"1")
					OB SET:C1220($ob_raiz;"mensaje";"Evento eliminado con éxito.")
					OB SET:C1220($ob_raiz;"error";"0")
					If ($b_desdeSTWA)
						Log_RegisterEvtSTW ("Se elimina evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10($d_fechaEvento;7)+", "+$t_evento+"]";$l_idUsuario)
					Else 
						LOG_RegisterEvt ("Se elimina evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10($d_fechaEvento;7)+", "+$t_evento+"]")
					End if 
				End if 
			Else 
				OB SET:C1220($ob_raiz;"resultado";"0")
				OB SET:C1220($ob_raiz;"error";"-2")
				OB SET:C1220($ob_raiz;"mensaje";"El evento no pudo ser cargado en modo lectura/ecritura.")
			End if 
		Else 
			OB SET:C1220($ob_raiz;"resultado";"0")
			OB SET:C1220($ob_raiz;"error";"-3")
			OB SET:C1220($ob_raiz;"permiso";"notiene")
			OB SET:C1220($ob_raiz;"mensaje";"El usuario no tiene permisos sobre la tabla Asignaturas o no es profesor de la asignatura.")
		End if 
	Else 
		OB SET:C1220($ob_raiz;"resultado";"0")
		OB SET:C1220($ob_raiz;"error";"-4")
		OB SET:C1220($ob_raiz;"mensaje";"Asignatura asociada no encontrado.")
	End if 
Else 
	OB SET:C1220($ob_raiz;"resultado";"0")
	OB SET:C1220($ob_raiz;"error";"-5")
	OB SET:C1220($ob_raiz;"mensaje";"Evento no encontrado.")
End if 
$0:=JSON Stringify:C1217($ob_raiz)