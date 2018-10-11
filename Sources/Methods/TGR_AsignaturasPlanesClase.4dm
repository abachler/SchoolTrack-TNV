//%attributes = {}
  // TGR_AsignaturasPlanesClase()
  // Por: Alberto Bachler: 23/08/13, 11:30:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

C_DATE:C307($d_fecha)
_O_C_INTEGER:C282($i_dias)
C_LONGINT:C283($l_diaFecha;$l_numeroHoras)

ARRAY INTEGER:C220($al_DiaEnHorario;0)



If (Not:C34(<>vb_ImportHistoricos_STX))
	SN3_MarcarRegistros (SN3_DTi_PlanesClase;SN3_SDTx_Planes)
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: ((Trigger event:C369=On Saving Existing Record Event:K3:2) | (Trigger event:C369=On Saving New Record Event:K3:1))
				  // MOD Ticket N° 218128 20181010 Patricio Aliaga
				If ([Asignaturas_PlanesDeClases:169]Desde:3#Old:C35([Asignaturas_PlanesDeClases:169]Desde:3)) | ([Asignaturas_PlanesDeClases:169]Hasta:4#Old:C35([Asignaturas_PlanesDeClases:169]Hasta:4))
					READ ONLY:C145([Asignaturas:18])
					RELATE ONE:C42([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
					PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
					READ ONLY:C145([TMT_Horario:166])
					QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
					SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$al_DiaEnHorario;[TMT_Horario:166]SesionesDesde:12;$ad_DesdeEnHorario;[TMT_Horario:166]SesionesHasta:13;$ad_hastaEnHorario)  //20150408 ASM Ticket 143499 
					$d_fecha:=[Asignaturas_PlanesDeClases:169]Desde:3
					$l_numeroHoras:=0
					While (($d_fecha<=[Asignaturas_PlanesDeClases:169]Hasta:4) & ([Asignaturas_PlanesDeClases:169]Hasta:4#!00-00-00!))
						If (DateIsValid ($d_fecha;0))
							$l_diaFecha:=DT_GetDayNumber_ISO8601 ($d_fecha)
							$al_DiaEnHorario{0}:=$l_diaFecha
							For ($i_dias;1;Size of array:C274($al_DiaEnHorario))
								If ($al_DiaEnHorario{$i_dias}=$l_diaFecha)
									If (($d_fecha>=$ad_DesdeEnHorario{$i_dias}) & ($d_fecha<=$ad_hastaEnHorario{$i_dias}))
										$l_numeroHoras:=$l_numeroHoras+1
									End if 
								End if 
							End for 
						End if 
						$d_fecha:=$d_fecha+1
					End while 
					[Asignaturas_PlanesDeClases:169]NumeroHoras:5:=$l_numeroHoras
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				AS_EliminaAdjuntoPlanesDeClases ([Asignaturas_PlanesDeClases:169]ID_Plan:1;Table:C252(->[Asignaturas_PlanesDeClases:169]))
		End case 
		
	End if 
End if 

