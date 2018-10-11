//%attributes = {}
  //xALCB_EX_PlanesdeClases

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$col;$row)
C_BOOLEAN:C305($fechaIncorrecta)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	$areaRef:=$1
	$modified:=AL_GetCellMod ($areaRef)
	If ($modified=1)
		AL_GetCurrCell ($areaRef;$col;$row)
		$IDplan:=alSTRas_Planes_ID{$row}
		
		  //verifico que las fechas del plan de clases no se traslapen
		$dDesde:=adSTRas_Planes_Desde{$row}
		$dHasta:=adSTRas_Planes_Hasta{$row}
		
		If ($dDesde#!00-00-00!)
			If ($dHasta#!00-00-00!)
				COPY ARRAY:C226(adSTRas_Planes_Desde;$aDesde)
				COPY ARRAY:C226(adSTRas_Planes_Hasta;$aHasta)
				AT_Delete ($row;1;->$aDesde;->$aHasta)
				SORT ARRAY:C229($aDesde;$aHasta;>)
				$date:=$dDesde
				Repeat 
					For ($i;1;Size of array:C274($aDesde))
						If (($date>=$aDesde{$i}) & ($date<=$aHasta{$i}))  //la fecha está incluida en otro plan de clases 
							$fechaIncorrecta:=True:C214
							$date:=$dHasta
							$i:=Size of array:C274($aDesde)
						End if 
					End for 
					$date:=$date+1
				Until ($date>$dHasta)
				
				ARRAY DATE:C224($aSesionesDesde;0)
				ARRAY DATE:C224($aSesionesHasta;0)
				If (Size of array:C274(adSTR_Periodos_Desde)>0)
					READ ONLY:C145([TMT_Horario:166])
					QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
					  //QUERY([TMT_Horario]; & [TMT_Horario]SesionesDesde>=vdSTR_Periodos_InicioEjercicio;*)
					  //QUERY([TMT_Horario]; & [TMT_Horario]SesionesHasta<=vdSTR_Periodos_FinEjercicio)
					QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]SesionesDesde:12>=adSTR_Periodos_Desde{1};*)
					QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]SesionesHasta:13<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
					SELECTION TO ARRAY:C260([TMT_Horario:166]SesionesDesde:12;$aSesionesDesde;[TMT_Horario:166]SesionesHasta:13;$aSesionesHasta)
					SORT ARRAY:C229($aSesionesDesde;>)
					SORT ARRAY:C229($aSesionesHasta;<)
				End if 
				
				Case of 
					: (($dDesde=!00-00-00!) | ($dHasta=!00-00-00!))
						  //nada no hay controles mientras no se ingresen las dos fechas
						
					: (Size of array:C274($aSesionesDesde)=0)
						  //OK:=CD_Dlog (0;"No hay asignaciones horario creados para esta asignatura en las fechas registrada"+"s, no será posible contabi"+"lizar las horas de clases.\r\r¿Desea usted crear el plan de clases de con estas fec"+"has"+"?";"";"No";"Si")
						  //If (OK<2)
						  //$fechaIncorrecta:=True
						  //End if 
						
					: ($fechaIncorrecta)
						CD_Dlog (0;__ ("La fecha ingresadas presentan conflictos con otros planes de clases.\r\rLas fechas de inicio y término de un plan de clases no pueden traslaparse con las fechas de otro plan."))
						
					: (adSTRas_Planes_Hasta{$row}<adSTRas_Planes_Desde{$row})
						CD_Dlog (0;__ ("La fecha de término no puede ser inferior a la fecha de inicio."))
						$fechaIncorrecta:=True:C214
						
					: ((adSTRas_Planes_Desde{$row}>=vdSTR_Periodos_InicioEjercicio) & (adSTRas_Planes_Hasta{$row}>vdSTR_Periodos_FinEjercicio))
						CD_Dlog (0;__ ("Las fechas ingresadas son incorrectas: un plan de clases no puede extenderse sobre dos ciclos anuales."))
						$fechaIncorrecta:=True:C214
						
					: ((adSTRas_Planes_Desde{$row}<vdSTR_Periodos_InicioEjercicio) & (adSTRas_Planes_Hasta{$row}<=vdSTR_Periodos_FinEjercicio))
						CD_Dlog (0;__ ("Las fechas ingresadas son incorrectas: un plan de clases no puede extenderse sobre dos ciclos anuales."))
						$fechaIncorrecta:=True:C214
						
					: (adSTRas_Planes_Desde{$row}<vdSTR_Periodos_InicioEjercicio)
						OK:=CD_Dlog (0;__ ("La fecha ingresada corresponde a un año escolar anterior al actual.\r¿Está usted seguro(a) que desea crear un plan de clases en una fecha anterior al inicio de este año escolar?");__ ("");__ ("No");__ ("Si"))
						If (OK<2)
							$fechaIncorrecta:=True:C214
						End if 
						
					: (adSTRas_Planes_Hasta{$row}>vdSTR_Periodos_FinEjercicio)
						OK:=CD_Dlog (0;__ ("La fecha ingresada corresponde a un año escolar posterior al actual.\r¿Está usted seguro(a) que desea crear un plan de clases en una fecha posterior al térmiono de este año escolar?");__ ("");__ ("No");__ ("Si"))
						If (OK<2)
							$fechaIncorrecta:=True:C214
						End if 
						
					: (adSTRas_Planes_Desde{$row}<$aSesionesDesde{1})
						OK:=CD_Dlog (0;__ ("Las asignaciones de horario para esta asignatura son posteriores a la fecha registrada.\r\r¿Desea usted crear el plan de clases de con estas fechas o ajustar a horario?");__ ("");__ ("Ajustar a horario");__ ("Usar fecha registrada");__ ("Cancelar"))
						Case of 
							: (OK=3)
								$fechaIncorrecta:=True:C214
							: (OK=2)
								  //mantener fechas
							Else 
								adSTRas_Planes_Desde{$row}:=$aSesionesDesde{1}
						End case 
						
					: (adSTRas_Planes_Hasta{$row}>$aSesionesHasta{1})
						OK:=CD_Dlog (0;__ ("Las asignaciones de horario para esta asignatura finalizan antes de la fecha registrada.\r\r¿Desea usted crear el plan de clases de con estas fechas o ajustar al horario?");__ ("");__ ("Ajustar a horario");__ ("Usar fecha registrada");__ ("Cancelar"))
						Case of 
							: (OK=3)
								$fechaIncorrecta:=True:C214
							: (OK=2)
								  //mantener fechas
							Else 
								adSTRas_Planes_Hasta{$row}:=$aSesionesHasta{1}
						End case 
				End case 
				
				
				If (Not:C34($fechaIncorrecta))
					KRL_FindAndLoadRecordByIndex (->[Asignaturas_PlanesDeClases:169]ID_Plan:1;->$IDplan;True:C214)
					If (OK=1)
						If (adSTRas_Planes_Hasta{$row}=!00-00-00!)
							adSTRas_Planes_Hasta{$row}:=adSTRas_Planes_Desde{$row}
						End if 
						[Asignaturas_PlanesDeClases:169]Desde:3:=adSTRas_Planes_Desde{$row}
						[Asignaturas_PlanesDeClases:169]Hasta:4:=adSTRas_Planes_Hasta{$row}
						[Asignaturas_PlanesDeClases:169]NumeroHoras:5:=aiSTRas_Planes_Horas{$row}
						SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
						  //MONO 193174
						$t_logmsj:="Planes de Clases: Modificación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
						$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
						$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
						LOG_RegisterEvt ($t_logmsj)
						aiSTRas_Planes_Horas{$row}:=[Asignaturas_PlanesDeClases:169]NumeroHoras:5
					Else 
						CD_Dlog (0;__ ("No fue posible modificar el registro de plan de clases. Por favor intente nuevamente más tarde."))
					End if 
					AL_UpdateArrays ($areaRef;-2)
				Else 
					adSTRas_Planes_Desde{$row}:=adSTRas_Planes_Desde{0}
					adSTRas_Planes_Hasta{$row}:=adSTRas_Planes_Hasta{0}
					AL_UpdateArrays ($areaRef;-2)
					AL_GotoCell ($areaRef;$col;$row)
				End if 
				
			Else 
				adSTRas_Planes_Hasta{$row}:=adSTRas_Planes_Hasta{0}
			End if 
		Else 
			adSTRas_Planes_Desde{$row}:=adSTRas_Planes_Desde{0}
		End if 
	End if 
	
	
End if 