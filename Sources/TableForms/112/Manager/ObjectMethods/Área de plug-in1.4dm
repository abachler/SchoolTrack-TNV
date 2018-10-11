C_BLOB:C604($blob)

Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$line:=AL_GetLine (Self:C308->)
		If ($line>0)
			READ ONLY:C145([xxADT_PostulacionesHistoricas:112])
			QUERY:C277([xxADT_PostulacionesHistoricas:112];[xxADT_PostulacionesHistoricas:112]ID:4=alADT_IDPH{$line})
			If (Records in selection:C76([xxADT_PostulacionesHistoricas:112])=1)
				$blob:=BLOB_ExpandBlob ([xxADT_PostulacionesHistoricas:112]xData:3)
				$otRef:=OT BLOBToObject ($blob)
				vsADT_Padre:=OT GetString ($otRef;"NombrePadre")
				vsADT_Madre:=OT GetString ($otRef;"NombreMadre")
				vdADT_Fecha_Inscripcion:=OT GetDate ($otRef;"FechaInscripcion")
				vsADT_Inscriptor:=OT GetString ($otRef;"Inscriptor")
				vsADT_Cal_Inscripcion:=OT GetString ($otRef;"CalInscripcion")
				vtADT_Obs_Inscripcion:=OT GetText ($otRef;"ObsInscripcion")
				vtADT_Recomendacion:=OT GetText ($otRef;"Recomendacion")
				vsADT_Entrevistador:=OT GetString ($otRef;"Entrevistador")
				vsADT_Cal_Entrevista:=OT GetString ($otRef;"CalEntrevista")
				vtADT_Obs_Entrevista:=OT GetText ($otRef;"ObsEntrevista")
				vsADT_Examinador:=OT GetString ($otRef;"Examinador")
				vrADT_Puntaje_Examen:=OT GetReal ($otRef;"PuntajeExamen")
				vtADT_Obs_Examen:=OT GetText ($otRef;"ObsExamen")
				vrADT_Ev_Conductual:=OT GetReal ($otRef;"EvConductual")
				vsADT_Sit_Final:=OT GetString ($otRef;"SitFinal")
				OT Clear ($otRef)
				vtADT_Apellidos_y_Nombres:=[xxADT_PostulacionesHistoricas:112]Apellidos_y_Nombres:2
				vsADT_RUT:=[xxADT_PostulacionesHistoricas:112]RUT:1
				_O_ENABLE BUTTON:C192(bObs)
				_O_ENABLE BUTTON:C192(bDeletePH)
			Else 
				PST_InitVariablesPH 
			End if 
		Else 
			PST_InitVariablesPH 
		End if 
End case 