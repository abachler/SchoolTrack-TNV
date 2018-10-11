//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 02-05-18, 09:10:07
  // ----------------------------------------------------
  // Método: Calendario_ObtieneEventos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_TEXT:C284($t_uuidAs;$t_fechaInicio;$t_fechaFin;$t_uuidUser)
C_DATE:C307($d_fechaInicio;$d_fechaFin)
C_TEXT:C284($t_year;$t_mes;$t_dia)
C_LONGINT:C283($l_idUsuario;$rn)
C_LONGINT:C283($l_recNumAsignaturas;$l_idUsuario;$l_idProfesor)
C_DATE:C307($d_fechaInicio;$d_fechaFin)
C_TEXT:C284($t_uuidAs)
ARRAY TEXT:C222($at_json;0)
ARRAY OBJECT:C1221($ao_objetos;0)
ARRAY OBJECT:C1221($ao_objetosBloqueos;0)
C_LONGINT:C283($i)
C_LONGINT:C283($l_error)
C_BOOLEAN:C305($b_desdeSTWA)
C_TEXT:C284($evento_text;$json;$t_delimitador;$t_id)
C_LONGINT:C283($l_indice)

READ ONLY:C145([xShell_Users:47])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Asignaturas_Eventos:170])

$b_desdeSTWA:=True:C214

$rn:=$1  // rn >=0 se asume que viene desde STWA y se devuelve el json con el mismo formato. De lo contrario, se retorna como arreglo.
$d_fechaInicio:=$2
$d_fechaFin:=$3
$l_idUsuario:=$4
If (Count parameters:C259>=5)
	$b_desdeSTWA:=$5
End if 

If ($l_idUsuario>0)
	$l_idProfesor:=KRL_GetNumericFieldData (->[xShell_Users:47]No:1;->$l_idUsuario;->[xShell_Users:47]NoEmployee:7)
End if 

  //validaciones
If ($l_error=0)
	If ($rn<0)
		$l_error:=-1
	End if 
End if 

If ($l_error=0)
	If ($d_fechaInicio=!00-00-00!)
		$l_error:=-2
	End if 
End if 

If ($l_error=0)
	If ($d_fechaFin=!00-00-00!)
		$l_error:=-3
	End if 
End if 

If ($l_error=0)
	If ($d_fechaInicio>$d_fechaFin)
		$l_error:=-4
	End if 
End if 

If ($l_error=0)
	If ($l_idProfesor=0)
		$l_error:=-5
	End if 
End if 

  //procesamiento
If ($l_error=0)
	KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215)
	
	If ($t_uuidAs#"")
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]auto_uuid:12;->$t_uuidAs)
	End if 
	
	ARRAY LONGINT:C221($aID_asig;0)
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@")
	AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$aID_asig)
	QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_asignatura:1;$aID_asig)
	QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2>=$d_fechaInicio)
	QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2<=$d_fechaFin)
	CREATE SET:C116([Asignaturas_Eventos:170];"Eventos")
	QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10=$l_idUsuario)
	CREATE SET:C116([Asignaturas_Eventos:170];"EventosUsuario")
	USE SET:C118("Eventos")
	If ($l_idUsuario>=0)
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10#$l_idUsuario;*)
		QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215)
	End if 
	CREATE SET:C116([Asignaturas_Eventos:170];"OtrosEventos")
	CREATE EMPTY SET:C140([Asignaturas_Eventos:170];"resultado")
	UNION:C120("EventosUsuario";"OtrosEventos";"resultado")
	USE SET:C118("resultado")
	  //$jsonT:=JSON New 
	ARRAY LONGINT:C221($aRNs;0)
	ARRAY LONGINT:C221($aRNs;Records in selection:C76([Asignaturas_Eventos:170]))
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Eventos:170];$aRNs)
	For ($i;1;Size of array:C274($aRNs))
		KRL_GotoRecord (->[Asignaturas_Eventos:170];$aRNs{$i};False:C215)
		C_OBJECT:C1216($ob_nodo)
		$ob_nodo:=OB_Create 
		Calendario_ObtieneEvento ($ob_nodo;[Asignaturas_Eventos:170]ID_Event:11;$l_idUsuario;$l_idProfesor;$b_desdeSTWA)
		APPEND TO ARRAY:C911($at_json;OB_Object2Json ($ob_nodo))
		APPEND TO ARRAY:C911($ao_objetos;$ob_nodo)
	End for 
	
	  //verifico las horas bloqueadas
	CU_cargaDiasBloqueados ([Asignaturas:18]Numero:1)
	If (Size of array:C274(at_curso)=0)
		AT_DimArrays (Size of array:C274(at_HorasBloqueadasMotivo);->at_curso)
	End if 
	
	  //SORT ARRAY(at_HorasBloqueadasMotivo;al_HoraDesde;al_HoraHasta;at_curso;>)
	If ($b_desdeSTWA)
		For ($i;1;Size of array:C274(at_HorasBloqueadasMotivo))
			C_OBJECT:C1216($ob_nodo)
			$ob_nodo:=OB_Create 
			$evento_text:=at_HorasBloqueadasMotivo{$i}+" - "+Time string:C180(al_HoraDesde{$i})+">>"+Time string:C180(al_HoraHasta{$i})
			$t_id:="-2"
			OB_SET_Text ($ob_nodo;"-2";"id")
			OB_SET_Text ($ob_nodo;$evento_text;"title")
			  //OB_SET_Text ($ob_nodo;String(ad_HorasBloqueadasFechas{$i};ISO date);"start")
			If ($b_desdeSTWA)
				OB_SET_Text ($ob_nodo;String:C10(ad_HorasBloqueadasFechas{$i};ISO date:K1:8);"start")
			Else 
				OB_SET_Text ($ob_nodo;SN3_MakeDateInmune2LocalFormat2 (ad_HorasBloqueadasFechas{$i});"start")
			End if 
			OB_SET_Text ($ob_nodo;"";"desc")
			OB_SET_Text ($ob_nodo;$evento_text+" ["+at_curso{$i}+"]";"tipo")
			OB_SET_Text ($ob_nodo;"";"evento")
			OB_SET_Text ($ob_nodo;at_curso{$i};"curso")
			OB_SET_Text ($ob_nodo;"Hora Bloqueada";"asignatura")
			OB_SET_Text ($ob_nodo;"";"abrev")
			OB_SET_Text ($ob_nodo;"-";"profesor")
			OB_SET_Boolean ($ob_nodo;False:C215;"privado")
			OB_SET_Boolean ($ob_nodo;False:C215;"publicar")
			OB_SET_Boolean ($ob_nodo;False:C215;"editable")
			OB_SET_Text ($ob_nodo;Time string:C180(al_HoraDesde{$i});"horadesde")
			OB_SET_Text ($ob_nodo;Time string:C180(al_HoraHasta{$i});"horahasta")
			APPEND TO ARRAY:C911($at_json;OB_Object2Json ($ob_nodo))
		End for 
	Else 
		C_OBJECT:C1216($ob_nodo;$ob_nodoDia;$ob_2array)
		C_LONGINT:C283($l_indiceD)
		ARRAY OBJECT:C1221($ao_horasbloqueo;0)
		ARRAY DATE:C224($ad_fechas;0)
		$ob_nodo:=OB_Create 
		COPY ARRAY:C226(ad_HorasBloqueadasFechas;$ad_fechas)
		AT_DistinctsArrayValues (->$ad_fechas)
		
		For ($l_indiceD;1;Size of array:C274($ad_fechas))
			ARRAY OBJECT:C1221($ao_horasbloqueo;0)
			
			OB SET:C1220($ob_nodo;"motivo";"")
			OB SET:C1220($ob_nodo;"fecha";SN3_MakeDateInmune2LocalFormat2 ($ad_fechas{$l_indiceD}))
			OB SET:C1220($ob_nodo;"todo_el_dia";False:C215)
			
			ARRAY LONGINT:C221($al_pos;0)
			ad_HorasBloqueadasFechas{0}:=$ad_fechas{$l_indiceD}
			AT_SearchArray (->ad_HorasBloqueadasFechas;"=";->$al_pos)
			For ($i;1;Size of array:C274($al_pos))
				OB SET:C1220($ob_nodoDia;"desde";Time string:C180(al_HoraDesde{$al_pos{$i}}))
				OB SET:C1220($ob_nodoDia;"hasta";Time string:C180(al_HoraHasta{$al_pos{$i}}))
				OB SET:C1220($ob_nodoDia;"motivo";at_HorasBloqueadasMotivo{$al_pos{$i}})
				$ob_2array:=OB Copy:C1225($ob_nodoDia)
				APPEND TO ARRAY:C911($ao_horasbloqueo;$ob_2array)
			End for 
			OB SET ARRAY:C1227($ob_nodo;"horas";$ao_horasbloqueo)
			$ob_2array:=OB Copy:C1225($ob_nodo)
			APPEND TO ARRAY:C911($ao_objetosBloqueos;$ob_2array)
		End for 
	End if 
	
	
	  //SORT ARRAY(at_fechasBloqueadasMotivo;ad_fechasBloqueadas;>)
	If ($b_desdeSTWA)
		For ($i;1;Size of array:C274(ad_fechasBloqueadas))
			C_OBJECT:C1216($ob_nodo)
			$ob_nodo:=OB_Create 
			$evento_text:="Motivo Bloqueo: "+at_fechasBloqueadasMotivo{$i}
			$t_id:="-2"
			OB_SET_Text ($ob_nodo;"-2";"id")
			OB_SET_Text ($ob_nodo;$evento_text;"title")
			  //OB_SET_Text ($ob_nodo;String(ad_fechasBloqueadas{$i};ISO date);"start")
			If ($b_desdeSTWA)
				OB_SET_Text ($ob_nodo;String:C10(ad_fechasBloqueadas{$i};ISO date:K1:8);"start")
			Else 
				OB_SET_Text ($ob_nodo;SN3_MakeDateInmune2LocalFormat2 (ad_fechasBloqueadas{$i});"start")
			End if 
			OB_SET_Text ($ob_nodo;"";"desc")
			OB_SET_Text ($ob_nodo;"";"tipo")
			OB_SET_Text ($ob_nodo;"";"evento")
			OB_SET_Text ($ob_nodo;"";"curso")
			OB_SET_Text ($ob_nodo;"Día Bloqueado";"asignatura")
			OB_SET_Text ($ob_nodo;"";"abrev")
			OB_SET_Text ($ob_nodo;"-";"profesor")
			OB_SET_Boolean ($ob_nodo;False:C215;"privado")
			OB_SET_Boolean ($ob_nodo;False:C215;"publicar")
			OB_SET_Boolean ($ob_nodo;False:C215;"editable")
			OB_SET_Text ($ob_nodo;Time string:C180(Time:C179("00:00:01"));"horadesde")
			OB_SET_Text ($ob_nodo;Time string:C180(Time:C179("23:59:59"));"horahasta")
			APPEND TO ARRAY:C911($at_json;OB_Object2Json ($ob_nodo))
		End for 
	Else 
		C_OBJECT:C1216($ob_nodo;$ob_2array)
		C_LONGINT:C283($l_indiceD)
		ARRAY OBJECT:C1221($ao_horasbloqueo;0)
		$ob_nodo:=OB_Create 
		For ($l_indiceD;1;Size of array:C274(ad_fechasBloqueadas))
			OB SET:C1220($ob_nodo;"motivo";at_fechasBloqueadasMotivo{$l_indiceD})
			OB SET:C1220($ob_nodo;"fecha";SN3_MakeDateInmune2LocalFormat2 (ad_fechasBloqueadas{$l_indiceD}))
			OB SET:C1220($ob_nodo;"todo_el_dia";True:C214)
			OB SET ARRAY:C1227($ob_nodo;"horas";$ao_horasbloqueo)
			$ob_2array:=OB Copy:C1225($ob_nodo)
			APPEND TO ARRAY:C911($ao_objetosBloqueos;$ob_2array)
		End for 
	End if 
	
	If ($b_desdeSTWA)
		$json:="["
		For ($i;1;Size of array:C274($at_json))
			If ($i=Size of array:C274($at_json))
				$t_delimitador:=""
			Else 
				$t_delimitador:=","
			End if 
			$json:=$json+$at_json{$i}+$t_delimitador
		End for 
		$0:=$json+"]"
	Else 
		
		C_OBJECT:C1216($ob_respuesta)
		
		OB SET:C1220($ob_respuesta;"error_cod";0)
		OB SET:C1220($ob_respuesta;"error_mensaje";"")
		
		OB SET ARRAY:C1227($ob_respuesta;"eventos";$ao_objetos)
		  ///Si no es STWA se retorna un arreglo con los feriados y una propiedad con los permisos del usuario
		C_DATE:C307($d_fechaI)
		C_BOOLEAN:C305($b_tienePermiso)
		ARRAY TEXT:C222($at_feriados;0)
		C_OBJECT:C1216($ob_nodo;$ob_prop)
		C_TEXT:C284($t_fechaLimite)
		$ob_nodo:=OB_Create 
		
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		$d_fechaI:=$d_fechaInicio
		While ($d_fechaI<=$d_fechaFin)
			If (Find in array:C230(adSTR_Calendario_Feriados;$d_fechaI)>0)
				APPEND TO ARRAY:C911($at_feriados;SN3_MakeDateInmune2LocalFormat2 ($d_fechaI))
			End if 
			$d_fechaI:=Add to date:C393($d_fechaI;0;0;1)
		End while 
		OB SET ARRAY:C1227($ob_respuesta;"feriados";$at_feriados)
		
		C_OBJECT:C1216($ob_periodo;$ob_2array)
		ARRAY OBJECT:C1221($ao_objPeriodos;0)
		For ($l_indice;1;Size of array:C274(adSTR_Periodos_Desde))
			OB SET:C1220($ob_periodo;"nombre";atSTR_Periodos_Nombre{$l_indice})
			OB SET:C1220($ob_periodo;"fecha_inicio";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Desde{$l_indice}))
			OB SET:C1220($ob_periodo;"fecha_termino";SN3_MakeDateInmune2LocalFormat2 (adSTR_Periodos_Hasta{$l_indice}))
			$ob_2array:=OB Copy:C1225($ob_periodo)
			APPEND TO ARRAY:C911($ao_objPeriodos;$ob_2array)
		End for 
		
		OB SET ARRAY:C1227($ob_respuesta;"periodos";$ao_objPeriodos)
		OB SET ARRAY:C1227($ob_respuesta;"dias_bloqueados";$ao_objetosBloqueos)
		$b_tienePermiso:=(($l_idUsuario<0) | (USR_IsGroupMember_by_GrpID (-15001;$l_idUsuario)) | ([Asignaturas:18]profesor_numero:4=$l_idProfesor) | ([Asignaturas:18]profesor_firmante_numero:33=$l_idProfesor))
		$b_tienePermiso:=$b_tienePermiso & (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$l_idUsuario)) | (USR_checkRights ("M";->[Asignaturas:18];$l_idUsuario))
		$t_fechaLimite:=SN3_MakeDateInmune2LocalFormat2 (<>d_FechaLimiteParaEventosAsig)
		
		OB SET ARRAY:C1227($ob_respuesta;"dias_bloqueados";$ao_objetosBloqueos)
		
		OB SET:C1220($ob_respuesta;"usuariopuedecreareventos";$b_tienePermiso)
		OB SET:C1220($ob_respuesta;"fechalimiteparaingresoeventos";$t_fechaLimite)
		OB SET:C1220($ob_respuesta;"pertenecegrupoadministracion";USR_IsGroupMember_by_GrpID (-15001;$l_idUsuario))
		OB SET ARRAY:C1227($ob_respuesta;"tiposdeeventos";<>at_EventosAsignatura)
		
		$0:=JSON Stringify:C1217($ob_respuesta)
	End if 
Else 
	C_TEXT:C284($t_msg)
	C_OBJECT:C1216($ob)
	$ob:=OB_Create 
	$t_msg:=Choose:C955(Abs:C99($l_error+1);"Asignatura no encontrada";"Fecha inicio no válida";"Fecha fin no válida";"Fecha fin menor a fecha inicio";"Profesor no encontrado")
	OB SET:C1220($ob;"error_cod";$l_error)
	OB SET:C1220($ob;"error_mensaje";$t_msg)
	$0:=JSON Stringify:C1217($ob)
End if 