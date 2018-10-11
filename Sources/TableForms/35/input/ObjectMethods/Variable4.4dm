Case of 
	: (alProEvt=AL Row drag event)
		AL_GetDrgArea (xALP_Trans1;$destArea)
		If ($destArea=xalp_Inscritos)
			AL_GetDrgSrcRow (xALP_Trans1;$srcRow)
			AL_GetDrgDstRow (xalp_Inscritos;$dstRow)
			$pos:=Find in array:C230(alBU_ALID;<>aStdId{$srcRow})
			
			  //Validación por Día y Hora de Recorrido
			  //Valida que el alumno seleccionado no se encuentre inscrito en un recorrido que tenga el mismo día y la misma hora
			  //que el recorrido seleccionado 
			
			$line:=AL_GetLine (xalp_ListaRec)
			ARRAY LONGINT:C221($al_recNumber;0)
			ARRAY LONGINT:C221($al_AlNumber;0)
			ARRAY TEXT:C222($at_RecName;0)
			QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]Dia_Semana:6;=;atBU_Dia{$line};*)
			QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Hora:5;=;Time:C179(Time string:C180(alBU_Hora{$line})))
			SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;$al_recNumber;[BU_Rutas_Recorridos:33]Nombre:3;$at_RecName)
			For ($i;1;Size of array:C274($al_recNumber))
				
				QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=$al_recNumber{$i};*)
				QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2#0)
				SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Alumno:2;$al_AlNumber)
				$exist:=Find in array:C230($al_AlNumber;<>aStdId{$srcRow})
				If ($exist>0)
					$vt_RecName:=$at_RecName{$i}
					$i:=Size of array:C274($al_recNumber)+1
				End if 
				
			End for 
			
			  //Fin de validación por Día y Hora de Recorrido
			
			  //Validación por cupo
			
			QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;alBU_Ruta{$line})
			$vl_CupoRuta:=[BU_Rutas:26]Cupo_Total:3
			QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;alBU_IdRecorrido{$line})
			If ($vl_CupoRuta>Records in selection:C76([BU_Rutas_Inscripciones:35]))
				If ($exist<0)
					If ($pos=-1)
						QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=alBU_IdRecorrido{$line};*)
						QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2#0)
						$vl_TotalAL:=Records in selection:C76([BU_Rutas_Inscripciones:35])+1
						ARRAY LONGINT:C221($alumnos;0)
						  //Se inserta la fila arrastrada en la lista de destino
						AL_UpdateArrays (xalp_Inscritos;0)
						AT_Insert (0;1;->atBU_ALNom;->atBU_ALCurso;->atBU_ALTipoServ;->atBU_ALDesciende;->atBU_ALAcompañado;->alBU_ALID;->ap_Acompañado)
						atBU_ALNom{Size of array:C274(atBU_ALNom)}:=<>aStdWhNme{$srcRow}
						atBU_ALCurso{Size of array:C274(atBU_ALCurso)}:=<>aCursos{<>acursos}
						atBU_ALTipoServ{Size of array:C274(atBU_ALTipoServ)}:=""
						atBU_ALDesciende{Size of array:C274(atBU_ALDesciende)}:=False:C215
						atBU_ALAcompañado{Size of array:C274(atBU_ALAcompañado)}:=""
						alBU_ALID{Size of array:C274(alBU_ALID)}:=<>aStdId{$srcRow}
						APPEND TO ARRAY:C911(at_observacion;"")
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_Acompañado{Size of array:C274(ap_Acompañado)})
						
						READ WRITE:C146([BU_Rutas_Inscripciones:35])
						CREATE RECORD:C68([BU_Rutas_Inscripciones:35])
						[BU_Rutas_Inscripciones:35]Numero_Inscripcion:1:=SQ_SeqNumber (->[BU_Rutas_Inscripciones:35]Numero_Inscripcion:1)
						[BU_Rutas_Inscripciones:35]Alumno_o_Profesor:8:="Alumno"
						[BU_Rutas_Inscripciones:35]Numero_Alumno:2:=<>aStdId{$srcRow}
						[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9:=<>aStdWhNme{$srcRow}
						[BU_Rutas_Inscripciones:35]Numero_Recorrido:4:=alBU_IdRecorrido{$line}
						[BU_Rutas_Inscripciones:35]Tipo_Servicio:6:=""
						[BU_Rutas_Inscripciones:35]solo_o_acompañado:5:=False:C215
						[BU_Rutas_Inscripciones:35]Acompañado_por:7:=""
						SAVE RECORD:C53([BU_Rutas_Inscripciones:35])
						UNLOAD RECORD:C212([BU_Rutas_Inscripciones:35])
						READ ONLY:C145([BU_Rutas_Inscripciones:35])
						
						  //Cada vez que se incribe un alumno se aumenta el total de alumnos del recorrido
						READ WRITE:C146([BU_Rutas_Recorridos:33])
						QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;alBU_IdRecorrido{$line})
						[BU_Rutas_Recorridos:33]Total_Alumnos:10:=$vl_TotalAL
						SAVE RECORD:C53([BU_Rutas_Recorridos:33])
						UNLOAD RECORD:C212([BU_Rutas_Recorridos:33])
						READ ONLY:C145([BU_Rutas_Recorridos:33])
						
					End if 
					
					AL_UpdateArrays (xalp_Inscritos;-2)
					AL_SetLine (xalp_Inscritos;0)
					  //Se elimina la fila arrastrada en la lista de origen
					AL_UpdateArrays (xALP_Trans1;0)
					AT_Delete ($srcRow;1;-><>aStdWhNme)
					AT_Delete ($srcRow;1;-><>aStdId)
					AL_UpdateArrays (xALP_Trans1;-2)
					
				Else 
					OK:=CD_Dlog (1;__ ("El Alumno ya se encuentra inscrito en el recorrido ")+$vt_RecName+__ ("\rque tiene la misma hora y día del recorrido seleccionado.");__ ("");__ ("Ok"))
				End if 
				
			Else 
				OK:=CD_Dlog (1;__ ("No quedan vacantes en el recorrido.\rSe han inscrito ")+String:C10($vl_CupoRuta)+__ (" personas entre Alumnos y Funcionarios");__ ("");__ ("Ok"))
				
			End if 
			  //Fin Validación por cupo
			
		End if 
		
End case 

