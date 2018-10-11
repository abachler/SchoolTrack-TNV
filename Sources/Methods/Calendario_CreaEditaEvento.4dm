//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 08-05-18, 09:05:07
  // ----------------------------------------------------
  // Método: Calendario_CreaEditaEvento
  // Descripción
  // Método que genera centraliza la creación de eventos de calendario.
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($l_recNumAsignatura)
C_LONGINT:C283($pos)
C_BOOLEAN:C305($permisocrear)
  //C_POINTER($y_refJson;$2)
C_OBJECT:C1216($ob_error)
C_TEXT:C284(vt_textoError)
C_DATE:C307($d_fecha)
C_BOOLEAN:C305($b_publicar;$b_privado)
C_TEXT:C284($t_tipoEvento;$t_evento;$t_descripcion)
C_TIME:C306($h_horaDesde;$h_horaHasta)
C_BOOLEAN:C305($b_desdeSTWA)
C_LONGINT:C283($l_userID;$l_profID)

READ ONLY:C145([Asignaturas:18])

$l_id:=$1
$l_recNumAsignatura:=$2
  //$y_refJson:=$2
$ob_error:=$3
vt_textoError:=""

$d_fecha:=$4
$b_publicar:=$5
$b_privado:=$6
$t_tipoEvento:=$7
$t_evento:=$8
$t_descripcion:=$9
$h_horaDesde:=$10
$h_horaHasta:=$11
$b_desdeSTWA:=$12
$l_userID:=$13

$l_profID:=KRL_GetNumericFieldData (->[xShell_Users:47]No:1;->$l_userID;->[xShell_Users:47]NoEmployee:7)

$0:=True:C214

KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
$pos:=Find in array:C230(adSTR_Calendario_Feriados;$d_fecha)
$permisocrear:=(USR_checkRights ("M";->[Asignaturas:18];$l_userID)) | ([Asignaturas:18]profesor_numero:4=$l_profID) | ([Asignaturas:18]profesor_firmante_numero:33=$l_profID)
If ($pos=-1)
	If ($permisocrear)
		If (KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215))
			$b_continuar:=AS_validaIngresoEventoCalendari ("validaCalendarioAsig";$d_fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
			If (($b_continuar) | ($l_id#-1))
				If ($l_id=-1)
					CREATE RECORD:C68([Asignaturas_Eventos:170])
					[Asignaturas_Eventos:170]ID_asignatura:1:=[Asignaturas:18]Numero:1
					[Asignaturas_Eventos:170]ID_Profesor:8:=[Asignaturas:18]profesor_numero:4
				Else 
					KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]ID_Event:11;->$l_id;True:C214)
				End if 
				[Asignaturas_Eventos:170]UserID:10:=$l_userID
				[Asignaturas_Eventos:170]Fecha:2:=$d_fecha
				[Asignaturas_Eventos:170]Publicar:5:=$b_publicar
				[Asignaturas_Eventos:170]Privado:9:=$b_privado
				[Asignaturas_Eventos:170]Tipo Evento:7:=$t_tipoEvento
				[Asignaturas_Eventos:170]Evento:3:=$t_evento
				[Asignaturas_Eventos:170]Descripción:4:=$t_descripcion
				[Asignaturas_Eventos:170]Hora_Inicio:13:=$h_horaDesde
				[Asignaturas_Eventos:170]Hora_Termino:14:=$h_horaHasta
				
				$continuar:=AS_validaIngresoEventoCalendari ("validaCantidadTipoEvento";$d_fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access;$t_tipoEvento)
				$continuar:=($continuar & AS_validaIngresoEventoCalendari ("verificaDiaDeClases";$d_fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access))
				$continuar:=($continuar & AS_validaIngresoEventoCalendari ("validaHoraEvento";$d_fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access))
				$continuar:=($continuar & AS_validaIngresoEventoCalendari ("validaPeriodoNivel";$d_fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access))
				
				If ($continuar)
					SAVE RECORD:C53([Asignaturas_Eventos:170])
					If ($l_id=-1)
						If ($b_desdeSTWA)
							Log_RegisterEvtSTW ("Nuevo evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";$l_userID)
						Else 
							LOG_RegisterEvt ("Nuevo evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]")
						End if 
					Else 
						If ($b_desdeSTWA)
							Log_RegisterEvtSTW ("Edición de evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";$l_userID)
						Else 
							LOG_RegisterEvt ("Edición de evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]")
						End if 
					End if 
					OB SET:C1220($ob_error;"idevento";String:C10([Asignaturas_Eventos:170]ID_Event:11))
					KRL_UnloadReadOnly (->[Asignaturas_Eventos:170])
				Else 
					OB SET:C1220($ob_error;"permiso";vt_textoError)
				End if 
				KRL_UnloadReadOnly (->[Asignaturas_Eventos:170])
			Else 
				OB SET:C1220($ob_error;"permiso";vt_textoError)
				If (vt_textoError="FechaLimiteParaEventosAsig")
					$t_msjerror:=__ ("El ingreso de Eventos fue bloqueado para después del ^0 en la sección Otras Preferencias.")
					$t_msjerror:=Replace string:C233($t_msjerror;"^0";String:C10(<>d_FechaLimiteParaEventosAsig))
				Else 
					$t_msjerror:=""
				End if 
				OB SET:C1220($ob_error;"mensaje_error";$t_msjerror)
			End if 
		Else 
			$0:=False:C215
		End if 
	Else 
		OB SET:C1220($ob_error;"permiso";"notiene")
	End if 
Else 
	OB SET:C1220($ob_error;"permiso";"feriado")
End if 