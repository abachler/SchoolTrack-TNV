  // [Asignaturas].EvStyleConverter()
  // Por: Alberto Bachler K.: 14-12-13, 14:51:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_asignaturas)
C_TEXT:C284($t_seleccionActual;$t_mensaje)


$y_Mensaje:=OBJECT Get pointer:C1124(Object named:K67:5;"mensaje")
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"barra@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		OBJECT SET RGB COLORS:C628(*;"lineaSeparador@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Borde)
		aStyleNames:=0
		aStyleNames_Old:=0
		aEvStyleReplaceWhere:=0
		vl_OldStyle:=0
		vl_NewStyle:=0
		
		_O_DISABLE BUTTON:C193(bOK)
		$y_mensaje->:=__ ("Seleccione el estilo de evaluación a reemplazar")
		
	: (Form event:C388=On Clicked:K2:4)
		If (aStyleNames_Old>0)
			vl_OldStyle:=aEvStyleID{Find in array:C230(aEvStyleName;aStyleNames_Old{aStyleNames_Old})}
		End if 
		
		If (aStyleNames>0)
			vl_NewStyle:=aEvStyleID{Find in array:C230(aEvStyleName;aStyleNames{aStyleNames})}
		End if 
		
		If (vl_OldStyle#0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_asignaturas)
			Case of 
				: (aEvStyleReplaceWhere=1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=vl_OldStyle)
				: (aEvStyleReplaceWhere=2)
					$t_seleccionActual:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					USE SET:C118($t_seleccionActual)
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=vl_OldStyle)
					
				: (aEvStyleReplaceWhere=3)
					$t_seleccionActual:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					USE SET:C118($t_seleccionActual)
					BWR_SearchRecords 
					QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=vl_OldStyle)
			End case 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End if 
		
		Case of 
			: (vl_OldStyle=0)
				$t_mensaje:=__ ("Seleccione el estilo de evaluación a reemplazar")
				_O_DISABLE BUTTON:C193(bOK)
				
			: (vl_NewStyle=0)
				$t_mensaje:=__ ("Seleccione el estilo de evaluación que desea asignar")
				_O_DISABLE BUTTON:C193(bOK)
				
			: (($l_asignaturas=0) & (aEvStyleReplaceWhere=0))
				$t_mensaje:=__ ("Seleccione en que asignatura(s) desea reemplazar el estilo de evaluación")
				_O_DISABLE BUTTON:C193(bOK)
				
			: (($l_asignaturas=0) & (aEvStyleReplaceWhere>0) & (vl_OldStyle#0))
				$t_mensaje:=__ ("Ninguna asignatura del universo seleccionado utiliza el estilo de evaluación ^0")
				$t_estiloEvaluacionActual:=aStyleNames_Old{aStyleNames_Old}
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_estiloEvaluacionActual))
				_O_DISABLE BUTTON:C193(bOK)
				
			: ((vl_OldStyle#0) & (vl_NewStyle#0) & ($l_asignaturas>0))
				$t_mensaje:=__ ("Se reemplazará el estilo de evaluacion en ^0 asignatura(s)")
				$t_numeroAsignaturas:=String:C10($l_asignaturas)
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_numeroAsignaturas))
				OBJECT SET TITLE:C194(*;"mensaje";$t_mensaje)
				_O_ENABLE BUTTON:C192(bOK)
		End case 
		$y_Mensaje->:=$t_mensaje
		
End case 