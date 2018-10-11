//%attributes = {}
C_LONGINT:C283($nextDay)
C_DATE:C307($1;$fecha)

If (Count parameters:C259=1)
	$fecha:=$1
	  //creating records
	CREATE RECORD:C68([Asignaturas_PlanesDeClases:169])
	[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=[Asignaturas:18]Numero:1
	[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
	[Asignaturas_PlanesDeClases:169]Desde:3:=$fecha
	[Asignaturas_PlanesDeClases:169]Hasta:4:=$fecha
	[Asignaturas_PlanesDeClases:169]NumeroHoras:5:=0
	SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
	  //MONO 193174
	$t_logmsj:="Planes de Clases: Creación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
	$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
	$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
	LOG_RegisterEvt ($t_logmsj)
	
	$ob_Json:=OB_Create 
	$b_creacion:=True:C214
	OB_SET ($ob_Json;->$b_creacion;"creacion")
	$0:=OB_Object2Json ($ob_Json)
Else 
	
	PERIODOS_Init 
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	
	READ ONLY:C145([TMT_Horario:166])
	
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
			$lastDay:=Day number:C114($lastDate)-1
		End if 
	Else 
		$lastDate:=Current date:C33(*)-1
		$lastDay:=Day number:C114($lastDate)-1
	End if 
	$vb_continuar:=True:C214
	
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
	If (Records in selection:C76([TMT_Horario:166])>0)
		SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$aDays;[TMT_Horario:166]SesionesDesde:12;$aDateFrom;[TMT_Horario:166]SesionesHasta:13;$aDateTo)
		SORT ARRAY:C229($aDays;>)
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
		
		If (Size of array:C274($aDays)>0)
			$nextDay:=Day number:C114($nextDate)-1
			$dateIsValid:=DateIsValid ($nextDate;0)
			$el:=Find in array:C230($aDays;$nextDay)
			If ($el>0)
				$isClassDay:=($el>0)
				$isInYear:=(Year of:C25($nextDate)=<>gYear)
				$dateIsInRange:=(($nextDate>=$aDateFrom{$el}) & ($nextDate<=$aDateTo{$el}))
				$isAValidClassDay:=($dateIsValid & $isClassDay & $dateIsInRange)
				If ($isAValidClassDay)
					While ((Not:C34($isAValidClassDay)) & ($isInYear))
						$nextDate:=$nextDate+1
						$nextDay:=Day number:C114($nextDate)-1
						$dateIsValid:=DateIsValid ($nextDate;0)
						$el:=Find in array:C230($aDays;$nextDay)
						If ($el>0)
							$isClassDay:=($el>0)
							$isInYear:=(Year of:C25($nextDate)=<>gYear)
							$dateIsInRange:=(($nextDate>=$aDateFrom{$el}) & ($nextDate<=$aDateTo{$el}))
							$isAValidClassDay:=($dateIsValid & $isClassDay & $dateIsInRange)
						End if 
					End while 
				End if 
			End if 
		End if 
		If ($nextDay>0)
			  //counting hours
			SET QUERY DESTINATION:C396(Into variable:K19:4;$horas)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$nextDay)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End if 
		If ($vb_continuar)
			  //creating records
			CREATE RECORD:C68([Asignaturas_PlanesDeClases:169])
			[Asignaturas_PlanesDeClases:169]ID_Asignatura:2:=[Asignaturas:18]Numero:1
			[Asignaturas_PlanesDeClases:169]ID_Plan:1:=SQ_SeqNumber (->[Asignaturas_PlanesDeClases:169]ID_Plan:1)
			[Asignaturas_PlanesDeClases:169]Desde:3:=$nextDate
			[Asignaturas_PlanesDeClases:169]Hasta:4:=$nextDate
			[Asignaturas_PlanesDeClases:169]NumeroHoras:5:=$horas
			SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
			  //MONO 193174
			$t_logmsj:="Planes de Clases: Creación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
			$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
			$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
			LOG_RegisterEvt ($t_logmsj)
		End if 
		$ob_Json:=OB_Create 
		OB_SET ($ob_Json;->$vb_continuar;"creacion")
		$0:=OB_Object2Json ($ob_Json)
		
	Else 
		$ob_Json:=OB_Create 
		OB_SET_Text ($ob_Json;"si";"necesitafecha")
		$0:=OB_Object2Json ($ob_Json)
	End if 
End if 
