//%attributes = {}
  //AS_CreaRegistroPlanDeClases
C_LONGINT:C283($nextDay;$horas)
READ ONLY:C145([TMT_Horario:166])

$lastObject:=Focus object:C278
RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldnum)
If ($varName="xALP_@")
	AL_ExitCell ($lastObject->)
End if 

  //looking for next date
QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1)
ORDER BY:C49([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Hasta:4;<)
If (Records in selection:C76([Asignaturas_PlanesDeClases:169])>0)
	If ([Asignaturas_PlanesDeClases:169]Hasta:4>=adSTR_Periodos_Desde{1})
		$lastDate:=[Asignaturas_PlanesDeClases:169]Hasta:4
		$lastDay:=Day number:C114($lastDate)-1
	Else 
		$lastDate:=Current date:C33(*)-1
		If ($lastDate<adSTR_Periodos_Desde{1})
			$lastDate:=adSTR_Periodos_Desde{1}
		End if 
		
		If ($lastDate>adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
			$lastDate:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
		End if 
		
		$lastDay:=Day number:C114($lastDate)-1
	End if 
Else 
	$lastDate:=Current date:C33(*)-1
	$lastDay:=Day number:C114($lastDate)-1
	
	If ($lastDate<adSTR_Periodos_Desde{1})
		$lastDate:=adSTR_Periodos_Desde{1}
	End if 
	
	If ($lastDate>adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
		$lastDate:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
	End if 
	
	$lastDay:=Day number:C114($lastDate)-1
End if 
$vb_continuar:=True:C214
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
If (Records in selection:C76([TMT_Horario:166])>0)
	ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1;>)
	SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$aDays;[TMT_Horario:166]SesionesDesde:12;$aDateFrom;[TMT_Horario:166]SesionesHasta:13;$aDateTo)
	
	$nextDay:=$lastDay
	For ($i;1;Size of array:C274($aDays))
		If ($aDays{$i}>$lastDay)
			$nextDay:=$aDays{$i}
			$i:=Size of array:C274($aDays)+1
		Else 
			$nextDay:=$aDays{1}
		End if 
	End for 
	Case of 
		: ($nextDay=1)
			$nextDate:=$lastDate-($lastDay)+8
		: ($nextDay>$lastDay)
			$nextDate:=$lastDate+($nextDay-$lastDay)
		: ($nextDay<$lastDay)
			$nextDate:=$lastDate+($lastDay-$nextDay)+1
		Else 
			$nextDate:=$lastDate+7
	End case 
	
	  //MONO TICKET 203783
	$b_buscarDia:=True:C214
	$nextDay:=DT_GetDayNumber_ISO8601 ($nextDate)
	
	While (($b_buscarDia) & ($nextDate<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}))
		
		$el:=Find in array:C230($aDays;$nextDay)
		
		If ($el>0)
			$dateIsValid:=DateIsValid ($nextDate;0)
			$dateIsInRange:=(($nextDate>=$aDateFrom{$el}) & ($nextDate<=$aDateTo{$el}))
			If (($dateIsValid) & ($dateIsInRange))
				$b_buscarDia:=False:C215
			Else 
				$nextDate:=$nextDate+1
				$nextDay:=DT_GetDayNumber_ISO8601 ($nextDate)
			End if 
		Else 
			$nextDate:=$nextDate+1
			$nextDay:=DT_GetDayNumber_ISO8601 ($nextDate)
		End if 
		
	End while 
	
	If ($b_buscarDia)  //Significa que sobrepasamos el rango de fechas de la configuración de periodos sin encontrar un día válido
		$nextDate:=!00-00-00!
		$nextDay:=0
	End if 
	
Else 
	
	$nextDate:=!00-00-00!
	$nextDay:=0
	$horas:=0
	ok:=1
	While (ok=1)
		SRACT_SelFecha (1)
		If (ok=1)
			$vb_continuar:=True:C214
			For ($i;1;Size of array:C274(adSTRas_Planes_Desde))
				If ((vd_fecha1>=adSTRas_Planes_Desde{$i}) & (vd_fecha1<=adSTRas_Planes_Hasta{$i}))
					$vb_continuar:=False:C215
					CD_Dlog (0;"El día "+String:C10(vd_fecha1)+" ya está incluido en un plan de clase. No puede ser creado o"+"tro plan de clase con esta fecha.")
				End if 
			End for 
			If ($vb_continuar)
				If (Not:C34(DateIsValid (vd_fecha1)))
					$vb_continuar:=False:C215
				Else 
					$nextDate:=vd_fecha1
				End if 
			End if 
			If ($nextDate=!00-00-00!)
				ok:=1
			Else 
				ok:=0
			End if 
		End if 
	End while 
End if 


If ($nextDay>0)
	  //counting hours
	SET QUERY DESTINATION:C396(Into variable:K19:4;$horas)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$nextDay)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 

If ($vb_continuar)
	If ($nextDate=!00-00-00!)
		$vb_continuar:=False:C215
		OK:=CD_Dlog (0;__ ("Ya se han creado planes de clases hasta el fin del año escolar.\r¿Desea añadir un plan de clase sin fecha de inicio y término para completarlas manualmente?");__ ("");__ ("Si");__ ("No"))
		If (OK=1)
			$vb_continuar:=True:C214
		End if 
	End if 
	
	If ($vb_continuar)
		  //ASM 20171129 Ticket 196450
		QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1)
		QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3=$nextDate;*)
		QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; | ;[Asignaturas_PlanesDeClases:169]Hasta:4=$nextDate)
		If (Records in selection:C76([Asignaturas_PlanesDeClases:169])=0)
			  //creating records
			CREATE RECORD:C68([Asignaturas_PlanesDeClases:169])
			[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=[Asignaturas:18]Numero:1
			[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
			[Asignaturas_PlanesDeClases:169]Desde:3:=$nextDate
			[Asignaturas_PlanesDeClases:169]Hasta:4:=$nextDate
			[Asignaturas_PlanesDeClases:169]NumeroHoras:5:=$horas
			SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
			$t_logmsj:="Planes de Clases: Modificación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
			$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
			$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
			LOG_RegisterEvt ($t_logmsj)
		Else 
			CD_Dlog (0;"El día "+String:C10($nextDate)+" ya está incluido en un plan de clase. No puede ser creado o"+"tro plan de clase con esta fecha.")
		End if 
		
	End if 
	
End if 
AS_PagePlanesDeClases 
