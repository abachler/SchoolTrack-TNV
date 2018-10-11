//%attributes = {}
  //AL_PageEgreso

Case of 
	: ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
		READ ONLY:C145([Alumnos_Historico:25])
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=(-[Alumnos:2]numero:1);*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]SituacionFinal:8="P";*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]NumeroNivel:6=12)
		OBJECT SET ENTERABLE:C238([Alumnos:2]AgnoEgreso:91;(Records in selection:C76([Alumnos_SintesisAnual:210])=0))
		QUERY:C277([Alumnos_EventosPostEgreso:135];[Alumnos_EventosPostEgreso:135]ID_Alumno:1=[Alumnos:2]numero:1)
		SELECTION TO ARRAY:C260([Alumnos_EventosPostEgreso:135]Fecha:2;ad_EventosEgreso_Fecha;[Alumnos_EventosPostEgreso:135]Tipo_Evento:3;at_EventosEgreso_Tipo;[Alumnos_EventosPostEgreso:135]Titulo_o_Cargo:6;at_EventosEgreso_Carrera;[Alumnos_EventosPostEgreso:135];al_EventosEgreso_RecNum)
		AL_UpdateArrays (xALP_EventosPostEgreso;-2)
		AL_SetLine (xALP_EventosPostEgreso;0)
		AL_SetSort (xALP_EventosPostEgreso;-1)
		READ WRITE:C146([Alumnos_ResultadosEgreso:130])
		QUERY:C277([Alumnos_ResultadosEgreso:130];[Alumnos_ResultadosEgreso:130]ID_Alumno:1=[Alumnos:2]numero:1)
		If (Records in selection:C76([Alumnos_ResultadosEgreso:130])=0)
			READ ONLY:C145([Alumnos_Historico:25])
			CREATE RECORD:C68([Alumnos_ResultadosEgreso:130])
			[Alumnos_ResultadosEgreso:130]ID_Alumno:1:=[Alumnos:2]numero:1
			[Alumnos_ResultadosEgreso:130]Year:11:=[Alumnos_SintesisAnual:210]Año:2
			SAVE RECORD:C53([Alumnos_ResultadosEgreso:130])
		End if 
		If ([Alumnos_ResultadosEgreso:130]Year:11<2005)
			OBJECT SET ENTERABLE:C238([Alumnos:2]Chile_PuntajePromedioEM:92;True:C214)
		End if 
		$0:=1
		OBJECT SET VISIBLE:C603(*;"Situacionfinal@";False:C215)
		OBJECT SET VISIBLE:C603(*;"NoEgresado@";False:C215)
		OBJECT SET VISIBLE:C603(*;"AgnoEgreso@";True:C214)
		
	: ([Alumnos:2]nivel_numero:29=12)
		$0:=1
		REDUCE SELECTION:C351([Alumnos_ResultadosEgreso:130];0)
		QUERY:C277([Alumnos_EventosPostEgreso:135];[Alumnos_EventosPostEgreso:135]ID_Alumno:1=[Alumnos:2]numero:1)
		SELECTION TO ARRAY:C260([Alumnos_EventosPostEgreso:135]Fecha:2;ad_EventosEgreso_Fecha;[Alumnos_EventosPostEgreso:135]Tipo_Evento:3;at_EventosEgreso_Tipo;[Alumnos_EventosPostEgreso:135]Titulo_o_Cargo:6;at_EventosEgreso_Carrera;[Alumnos_EventosPostEgreso:135];al_EventosEgreso_RecNum)
		AL_UpdateArrays (xALP_EventosPostEgreso;-2)
		AL_SetLine (xALP_EventosPostEgreso;0)
		AL_SetSort (xALP_EventosPostEgreso;-1)
		OBJECT SET VISIBLE:C603(*;"Situacionfinal@";True:C214)
		OBJECT SET VISIBLE:C603(*;"NoEgresado@";True:C214)
		OBJECT SET VISIBLE:C603(*;"AgnoEgreso@";False:C215)
		For ($i;1;Get last field number:C255(->[Alumnos_ResultadosEgreso:130]))
			  //20130321 RCH
			If (Is field number valid:C1000(Table:C252(->[Alumnos_ResultadosEgreso:130]);$i))
				OBJECT SET ENTERABLE:C238(Field:C253(Table:C252(->[Alumnos_ResultadosEgreso:130]);$i)->;False:C215)
			End if 
		End for 
	Else 
		$0:=0
		  //$ignore:=CD_Dlog (0;"Este alumno no ha egresado.")
End case 