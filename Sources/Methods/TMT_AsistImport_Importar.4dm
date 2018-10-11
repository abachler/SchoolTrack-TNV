//%attributes = {"executedOnServer":true}
  //TMT_AsistImport_Importar
  //MONO
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([TMT_Horario:166])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])

C_DATE:C307($d_Desde;$d_Hasta)
C_TEXT:C284($t_denominacionInterna_IMP;$t_cursoasig_IMP;$msg_conflicto)
C_LONGINT:C283($i;$a;$d;$h;$l_idTermometro;$id_sala;$nivel_AsigIMP;$vl_aluconflicto;$id_profesor;$l_dia;$l_hora;$l_lastLoadNivAsig)
C_BOOLEAN:C305($1;$b_reemplazarBloque;$2;$b_reemplazarProfe;$3;$b_reemplazarProfeFirmante;$b_importar)
C_OBJECT:C1216($4;$o_horarioIMP)
C_TEXT:C284($t_progress1;$t_progress2)
C_REAL:C285($r_progress1;$r_progress2)
C_OBJECT:C1216($o_dias)

ARRAY TEXT:C222($at_childName;0)
ARRAY OBJECT:C1221($ao_childObj;0)
ARRAY TEXT:C222($at_asigIds;0)
ARRAY OBJECT:C1221($ao_AsigObj;0)
ARRAY TEXT:C222($at_dias;0)
ARRAY OBJECT:C1221($ao_diasObj;0)
ARRAY LONGINT:C221($al_horas;0)

ARRAY TEXT:C222($at_log;0)
ARRAY BOOLEAN:C223($ab_log;0)
$b_reemplazarBloque:=$1
$b_reemplazarProfe:=$2
$b_reemplazarProfeFirmante:=$3
$o_horarioIMP:=$4
$l_nodes:=OB_GetChildNodes ($o_horarioIMP;->$at_childName;->$ao_childObj)

$l_idTermometro:=IT_Progress (1;0;0;"Cargando Bloques al Horario ...")

For ($i;1;Size of array:C274($at_childName))
	
	$t_progress1:="Cargando Bloques al Horario "+$at_childName{$i}
	$r_progress1:=$i/Size of array:C274($at_childName)
	
	$l_nodes:=OB_GetChildNodes ($ao_childObj{$i};->$at_asigIds;->$ao_AsigObj)
	
	For ($a;1;Size of array:C274($at_asigIds))
		$id_asignatura:=Num:C11($at_asigIds{$a})
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id_asignatura)
		$t_denominacionInterna_IMP:=[Asignaturas:18]denominacion_interna:16
		$t_cursoasig_IMP:=[Asignaturas:18]Curso:5
		$nivel_AsigIMP:=[Asignaturas:18]Numero_del_Nivel:6
		
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@";*)
		QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50#"Promovido@")
		CREATE SET:C116([Alumnos:2];"$ALUASIGIMPORT")
		
		$t_progress2:=[Asignaturas:18]denominacion_interna:16
		$r_progress2:=$a/Size of array:C274($at_asigIds)
		
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$r_progress1;$t_progress1;$r_progress2;$t_progress2)
		
		$id_profesor:=OB Get:C1224($ao_AsigObj{$a};"idProfesor")
		$o_dias:=OB Get:C1224($ao_AsigObj{$a};"dias")
		$l_nodes:=OB_GetChildNodes ($o_dias;->$at_dias;->$ao_diasObj)
		
		  //buscar los bloques de la asignaturas correspondientes al nivel de la asignatura del bloque que se está importando
		If ($nivel_AsigIMP#$l_lastLoadNivAsig)
			$l_lastLoadNivAsig:=$nivel_AsigIMP
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$nivel_AsigIMP)
			KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
			CREATE SET:C116([TMT_Horario:166];"$BloquesNivelAsignatura")
		End if 
		
		For ($d;1;Size of array:C274($at_dias))
			$l_dia:=Num:C11($at_dias{$d})
			OB GET ARRAY:C1229($ao_diasObj{$d};"horas";$al_horas)
			For ($h;1;Size of array:C274($al_horas))
				$b_importar:=True:C214
				USE SET:C118("$BloquesNivelAsignatura")
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*))
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$l_dia)
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2=$al_horas{$h})
				
				ARRAY LONGINT:C221($al_BloqueDestino;0)
				LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$al_BloqueDestino;"")
				ARRAY LONGINT:C221($al_idAsigBloqueConflicto;0)
				
				For ($i_bloque;1;Size of array:C274($al_BloqueDestino))
					
					GOTO RECORD:C242([TMT_Horario:166];$al_BloqueDestino{$i_bloque})
					APPEND TO ARRAY:C911($al_idAsigBloqueConflicto;[TMT_Horario:166]ID_Asignatura:5)
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[TMT_Horario:166]ID_Asignatura:5)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Status:50#"Promovido@")
					CREATE SET:C116([Alumnos:2];"$ALUASIGHORARIO")
					
					CREATE EMPTY SET:C140([Alumnos:2];"$ALUCONFLICTO")
					INTERSECTION:C121("$ALUASIGIMPORT";"$ALUASIGHORARIO";"$ALUCONFLICTO")
					$vl_aluconflicto:=Records in set:C195("$ALUCONFLICTO")
					$msg_conflicto:=""
					
					If ($id_asignatura#[TMT_Horario:166]ID_Asignatura:5)
						
						If ($vl_aluconflicto>0)
							USE SET:C118("$ALUCONFLICTO")
							ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
							ARRAY TEXT:C222($at_aluTope;0)
							SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_aluTope)
							
							$msg_conflicto:="El dia "+<>atXS_DayNames{$l_dia+1}+" a la hora "+String:C10($al_horas{$h})+" el importador quiere ingresar un bloque para "+$t_denominacionInterna_IMP+" ("+String:C10($id_asignatura)+") "+$t_cursoasig_IMP
							$msg_conflicto:=$msg_conflicto+", pero existe un bloque activo de "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)+" "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Curso:5)
							$msg_conflicto:=$msg_conflicto+" con "+String:C10($vl_aluconflicto)+" alumnos en común:"+"\r"
							$msg_conflicto:=$msg_conflicto+AT_array2text (->$at_aluTope;", ")
							
							If ($b_reemplazarBloque)
								
								KRL_ReloadInReadWriteMode (->[TMT_Horario:166])
								
								SET QUERY DESTINATION:C396(Into variable:K19:4;$l_sesiones)
								QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5;*)
								QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=[TMT_Horario:166]NumeroDia:1;*)
								QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=[TMT_Horario:166]NumeroHora:2;*)
								QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[TMT_Horario:166]No_Ciclo:14)
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								
								If ($l_sesiones=0)
									DELETE RECORD:C58([TMT_Horario:166])
									$msg_conflicto:=$msg_conflicto+". Es eliminado el bloque original y reemplazdo por el de la importación, debido a que no cuenta con sesiones registradas."
								Else 
									[TMT_Horario:166]SesionesHasta:13:=Current date:C33(*)
									SAVE RECORD:C53([TMT_Horario:166])
									$msg_conflicto:=$msg_conflicto+". El bloque orignal quedará disponible hasta el "+String:C10(Current date:C33(*))
								End if 
								
								KRL_UnloadReadOnly (->[TMT_Horario:166])
							Else 
								$b_importar:=False:C215
							End if 
						End if 
					Else 
						$b_importar:=False:C215
					End if 
					
					If (Not:C34($b_importar))
						$i_bloque:=Size of array:C274($al_BloqueDestino)
					End if 
					
					CLEAR SET:C117("$ALUASIGHORARIO")
					CLEAR SET:C117("$ALUCONFLICTO")
					
				End for 
				
				If ($b_importar)  //Inserción del bloque
					PERIODOS_LoadData ($nivel_AsigIMP)
					  //If (ai_ar_hora{$i}<=Size of array(alSTR_Horario_Desde))
					$d_Desde:=Current date:C33(*)
					If (adSTR_Periodos_Desde{1}>$d_Desde)
						$d_Desde:=adSTR_Periodos_Desde{1}
					End if 
					$d_Hasta:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
					
					READ WRITE:C146([TMT_Horario:166])
					CREATE RECORD:C68([TMT_Horario:166])
					[TMT_Horario:166]Curso:11:=$t_cursoasig_IMP
					[TMT_Horario:166]NumeroHora:2:=$al_horas{$h}
					[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{[TMT_Horario:166]NumeroHora:2}
					[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{[TMT_Horario:166]NumeroHora:2}
					[TMT_Horario:166]ID_Asignatura:5:=$id_asignatura
					[TMT_Horario:166]ID_Sala:6:=$id_sala
					[TMT_Horario:166]ID_Teacher:9:=$id_profesor
					[TMT_Horario:166]Nivel:10:=$nivel_AsigIMP
					[TMT_Horario:166]No_Ciclo:14:=1
					[TMT_Horario:166]NumeroDia:1:=$l_dia
					  //[TMT_Horario]Sala:=$y_at_sala->{$i}
					[TMT_Horario:166]SesionesDesde:12:=$d_Desde
					[TMT_Horario:166]SesionesHasta:13:=$d_Hasta
					[TMT_Horario:166]TipoHora:16:=1
					SAVE RECORD:C53([TMT_Horario:166])
					KRL_ReloadAsReadOnly (->[TMT_Horario:166])
					TMT_CreaSesiones (Record number:C243([TMT_Horario:166]))
					KRL_UnloadReadOnly (->[TMT_Horario:166])
					$msg_imp:="Bloque importado, asignatura ID "+String:C10($id_asignatura)+" "+$t_denominacionInterna_IMP+" "+$t_cursoasig_IMP+", "+<>atXS_DayNames{$l_dia+1}+" a la hora "+String:C10($al_horas{$h})
					If ($msg_conflicto#"")
						$msg_imp:=$msg_imp+". "+$msg_conflicto
					End if 
					  //Else 
					  //$b_importar:=True
					  //$msg_imp:="Bloque No importado, asignatura ID "+String($y_al_id_asignatura->{$i})+" "+$t_denominacionInterna_IMP+" "+$t_cursoasig_IMP+", bloque "+String($y_ai_numhora->{i})+" no existe en la configuración del horario dentro de la configuración de periodos para el nivel de la asignatura."
					  //End if 
				Else 
					$msg_imp:="Bloque No importado, asignatura ID "+String:C10($id_asignatura)+" "+$t_denominacionInterna_IMP+" "+$t_cursoasig_IMP+" día "+String:C10($l_dia)+" a la hora "+String:C10($al_horas{$h})
					If ($msg_conflicto#"")
						$msg_imp:=$msg_imp+". "+$msg_conflicto
					Else 
						$msg_imp:=$msg_imp+" ya existía en el horario."
					End if 
					
				End if 
				
				APPEND TO ARRAY:C911($ab_log;$b_importar)
				APPEND TO ARRAY:C911($at_log;$msg_imp)
				
			End for 
			
		End for 
		
		CLEAR SET:C117("$ALUASIGIMPORT")
		
		  //Reemplazo de los profesores
		If ((($b_reemplazarProfe) | ($b_reemplazarProfeFirmante)) & ($id_profesor>0))
			KRL_ReloadInReadWriteMode (->[Asignaturas:18])
			If ($b_reemplazarProfe)
				[Asignaturas:18]profesor_numero:4:=$id_profesor
				[Asignaturas:18]profesor_nombre:13:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$id_profesor;->[Profesores:4]Apellidos_y_nombres:28)
			End if 
			If ($b_reemplazarProfeFirmante)
				[Asignaturas:18]profesor_firmante_numero:33:=$id_profesor
				[Asignaturas:18]profesor_firmante_Nombre:34:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$id_profesor;->[Profesores:4]Apellidos_y_nombres:28)
			End if 
			SAVE RECORD:C53([Asignaturas:18])
			KRL_ReloadAsReadOnly (->[Asignaturas:18])
		End if 
		
	End for 
	
	  //Sala o lugar de la clase
	  //$id_sala:=0
	  //If ($y_at_sala->{$i}#"")  //revisar la sala si viene en el registro 
	  //READ ONLY([TMT_Salas])
	  //QUERY([TMT_Salas];[TMT_Salas]NombreSala=$y_at_sala->{$i})
	  //If (Records in selection([TMT_Salas])=0)
	  //READ WRITE([ACT_Apoderados_de_Cuenta])
	  //CREATE RECORD([TMT_Salas])
	  //[TMT_Salas]NombreSala:=$y_at_sala->{$i}
	  //SAVE RECORD([TMT_Salas])
	  //$id_sala:=[TMT_Salas]ID_Sala
	  //KRL_UnloadReadOnly (->[TMT_Salas])
	  //Else 
	  //$id_sala:=[TMT_Salas]ID_Sala
	  //UNLOAD RECORD([TMT_Salas])
	  //End if 
	  //End if 
	
End for 

CLEAR SET:C117("$BloquesNivelAsignatura")
TMT_AsistImport_Log (->$ab_log;->$at_log)

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)