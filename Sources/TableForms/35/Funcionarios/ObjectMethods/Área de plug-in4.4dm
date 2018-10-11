  //xalp_BUListaFunc --> Origen
  //xalp_BUFunc --> Destino

Case of 
	: (alProEvt=AL Row drag event)
		AL_GetDrgArea (xalp_BUListaFunc;$destArea)
		If ($destArea=xalp_BUFunc)
			AL_GetDrgSrcRow (xalp_BUListaFunc;$srcRow)
			AL_GetDrgDstRow (xalp_BUFunc;$dstRow)
			$pos:=Find in array:C230(alBU_PFID;alBU_PFIdGen{$srcRow})
			
			  //Validación por Día y Hora de Recorrido
			  //Valida que el funcionario seleccionado no se encuentre inscrito en un recorrido que tenga el mismo día y la misma hora
			  //que el recorrido seleccionado 
			
			$line:=AL_GetLine (xalp_BURec)
			ARRAY LONGINT:C221($al_recNumber;0)
			ARRAY LONGINT:C221($al_FuncNumber;0)
			ARRAY TEXT:C222($at_RecName;0)
			QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]Dia_Semana:6;=;atBU_Dia{$line};*)
			QUERY:C277([BU_Rutas_Recorridos:33]; & ;[BU_Rutas_Recorridos:33]Hora:5;=;Time:C179(Time string:C180(alBU_Hora{$line})))
			SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;$al_recNumber;[BU_Rutas_Recorridos:33]Nombre:3;$at_RecName)
			
			For ($i;1;Size of array:C274($al_recNumber))
				
				QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=$al_recNumber{$i};*)
				QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Profesor:3#0)
				SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Profesor:3;$al_FuncNumber)
				$exist:=Find in array:C230($al_FuncNumber;alBU_PFIdGen{$srcRow})
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
						QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Profesor:3#0)
						$vl_TotalPF:=Records in selection:C76([BU_Rutas_Inscripciones:35])+1
						  //Se inserta la fila arrastrada en la lista de destino
						AL_UpdateArrays (xalp_BUFunc;0)
						AT_Insert (0;1;->atBU_PFNom)
						AT_Insert (0;1;->atBU_PFCargo)
						AT_Insert (0;1;->alBU_PFID)
						
						atBU_PFNom{Size of array:C274(atBU_PFNom)}:=atBU_PFNomGen{$srcRow}
						atBU_PFCargo{Size of array:C274(atBU_PFCargo)}:=atBU_PFCargoGen{$srcRow}
						alBU_PFID{Size of array:C274(alBU_PFID)}:=alBU_PFIdGen{$srcRow}
						APPEND TO ARRAY:C911(at_observacion;"")
						
						READ WRITE:C146([BU_Rutas_Inscripciones:35])
						CREATE RECORD:C68([BU_Rutas_Inscripciones:35])
						[BU_Rutas_Inscripciones:35]Numero_Inscripcion:1:=SQ_SeqNumber (->[BU_Rutas_Inscripciones:35]Numero_Inscripcion:1)
						[BU_Rutas_Inscripciones:35]Numero_Profesor:3:=alBU_PFIdGen{$srcRow}
						[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9:=atBU_PFNomGen{$srcRow}
						[BU_Rutas_Inscripciones:35]Alumno_o_Profesor:8:="Profesor"
						[BU_Rutas_Inscripciones:35]Numero_Recorrido:4:=alBU_IdRecorrido{$line}
						[BU_Rutas_Inscripciones:35]Observacion_Inscripcion:10:=""
						SAVE RECORD:C53([BU_Rutas_Inscripciones:35])
						UNLOAD RECORD:C212([BU_Rutas_Inscripciones:35])
						READ ONLY:C145([BU_Rutas_Inscripciones:35])
						
						AL_UpdateArrays (xalp_BUFunc;-2)
						
						  //Cada vez que se incribe un funcionario se aumenta el total de alumnos del recorrido
						READ WRITE:C146([BU_Rutas_Recorridos:33])
						QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;alBU_IdRecorrido{$line})
						[BU_Rutas_Recorridos:33]Total_Profesores:11:=$vl_TotalPF
						SAVE RECORD:C53([BU_Rutas_Recorridos:33])
						UNLOAD RECORD:C212([BU_Rutas_Recorridos:33])
						READ ONLY:C145([BU_Rutas_Recorridos:33])
						
					End if 
					
					
					  //Se elimina la fila arrastrada en la lista de origen
					AL_UpdateArrays (xalp_BUListaFunc;0)
					AT_Delete ($srcRow;1;->atBU_PFNomGen)
					AT_Delete ($srcRow;1;->atBU_PFCargoGen)
					AT_Delete ($srcRow;1;->alBU_PFIdGen)
					AL_UpdateArrays (xalp_BUListaFunc;-2)
					
				Else 
					OK:=CD_Dlog (1;__ ("El Funcionario ya se encuentra inscrito en el Recorrido ")+$vt_RecName+__ ("\rque tiene la misma hora y día que el recorrido seleccionado");__ ("");__ ("Ok"))
					
				End if 
				
			Else 
				OK:=CD_Dlog (1;__ ("No quedan vacantes en el recorrido \rSe han inscrito ")+String:C10($vl_CupoRuta)+__ (" personas entre Alumnos y Funcionarios");__ ("");__ ("Ok"))
				
			End if 
			  //Fin Validación por cupo
		End if 
		
End case 
IT_SetButtonState (False:C215;->bDelFunc)
AL_SetLine (xalp_BUFunc;0)

