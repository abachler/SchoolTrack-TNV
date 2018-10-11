Case of 
	: (alProEvt=0)
		AL_GetCurrCell (Self:C308->;$Col;$Row)
		If (($col>0) & ($row>0))
			AL_ExitCell (Self:C308->)
		End if 
		
	: (alProEVt=1)
		$line:=AL_GetLine (xALP_planes)
		If ($line>0)
			AS_SetSesionObjectsStatus 
			
		End if 
		
	: (alProEvt=AL Single Control Click)
		
		If (USR_IsGroupMember_by_GrpID (-15001))
			$row:=AL_GetClickedRow (xALP_planes)
			$result:=Pop up menu:C542("Replicar plan de clases de "+String:C10(adSTRas_Planes_Desde{$row};2)+" a "+String:C10(adSTRas_Planes_Hasta{$row};2)+";(-;Replicar todos los "+"planes de clases")
			Case of 
				: ($result=1)
					OK:=CD_Dlog (0;__ ("Los planes de clases definidos en el resto de las asignaturas ")+[Asignaturas:18]Asignatura:3+__ (" serán reemplazados por el plan de clases seleccionado.\r\r¿Desea realmente replicar este plan de clases?");__ ("");__ ("No");__ ("Si. Replicar"))
					If (OK=2)
						$idAsignatura:=[Asignaturas:18]Numero:1
						$recNumAsignatura:=Record number:C243([Asignaturas:18])
						$recNumPlan:=Find in field:C653([Asignaturas_PlanesDeClases:169]ID_Plan:1;alSTRas_Planes_ID{$row})
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=[Asignaturas:18]Asignatura:3;*)
						QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;[Asignaturas:18]Numero_del_Nivel:6;*)
						QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215;*)
						QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion_por_sexo:24=[Asignaturas:18]Seleccion_por_sexo:24;*)
						QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$idAsignatura)
						SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIds)
						KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
						QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3=adSTRas_Planes_Desde{$row};*)
						QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; & [Asignaturas_PlanesDeClases:169]Hasta:4=adSTRas_Planes_Hasta{$row})
						KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169])
						For ($i;1;Size of array:C274($aIds))
							KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNumPlan)
							DUPLICATE RECORD:C225([Asignaturas_PlanesDeClases:169])
							[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=$aIds{$i}
							[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
							[Asignaturas_PlanesDeClases:169]Auto_UUID:15:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
						End for 
						KRL_GotoRecord (->[Asignaturas:18];$recNumAsignatura)
						LOG_RegisterEvt ("Plan de clase "+String:C10(adSTRas_Planes_Desde{$row})+" a "+String:C10(adSTRas_Planes_Hasta{$row})+"de "+[Asignaturas:18]Asignatura:3+", "+[Asignaturas:18]Curso:5+" replicados en todas las asignaturas "+[Asignaturas:18]Asignatura:3+" del nivel")
					End if 
					
				: ($result=3)
					OK:=CD_Dlog (0;__ ("Los planes de clases definidos en el resto de las asignaturas ")+[Asignaturas:18]Asignatura:3+__ (" serán reemplazados por el plan de clases seleccionado.\r\r¿Desea realmente replicar este plan de clases?");__ ("");__ ("No");__ ("Si. Replicar"))
					If (OK=2)
						For ($row;1;Size of array:C274(adSTRas_Planes_Desde))
							$idAsignatura:=[Asignaturas:18]Numero:1
							$recNumAsignatura:=Record number:C243([Asignaturas:18])
							$recNumPlan:=Find in field:C653([Asignaturas_PlanesDeClases:169]ID_Plan:1;alSTRas_Planes_ID{$row})
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=[Asignaturas:18]Asignatura:3;*)
							QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;[Asignaturas:18]Numero_del_Nivel:6;*)
							QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215;*)
							QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion_por_sexo:24=[Asignaturas:18]Seleccion_por_sexo:24;*)
							QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$idAsignatura)
							SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIds)
							KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
							QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3=adSTRas_Planes_Desde{$row};*)
							QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; & [Asignaturas_PlanesDeClases:169]Hasta:4=adSTRas_Planes_Hasta{$row})
							KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169])
							For ($i;1;Size of array:C274($aIds))
								KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNumPlan)
								DUPLICATE RECORD:C225([Asignaturas_PlanesDeClases:169])
								[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=$aIds{$i}
								[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
								[Asignaturas_PlanesDeClases:169]Auto_UUID:15:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
							End for 
							KRL_GotoRecord (->[Asignaturas:18];$recNumAsignatura)
						End for 
						LOG_RegisterEvt ("Planes de clase de "+[Asignaturas:18]Asignatura:3+", "+[Asignaturas:18]Curso:5+" replicados en todas las asignaturas "+[Asignaturas:18]Asignatura:3+" del nivel")
					End if 
			End case 
			
			$recNum:=Find in field:C653([Asignaturas_PlanesDeClases:169]ID_Plan:1;alSTRas_Planes_ID{1})
			READ WRITE:C146([Asignaturas_PlanesDeClases:169])
			QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=alSTRas_Planes_ID{1})
		End if 
End case 