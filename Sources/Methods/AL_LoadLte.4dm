//%attributes = {}
  //AL_LoadLte

STR_LeePreferenciasAtrasos2 

ARRAY LONGINT:C221(al_hora_atraso;0)
ARRAY TEXT:C222(at_hora_atraso;0)
ARRAY LONGINT:C221($al_idAtrasoAsig;0)  //MONO 180505
ARRAY TEXT:C222(at_atrasoAsig;0)
ARRAY TEXT:C222(at_fraccion;0)
C_TEXT:C284($vt_hora_atraso)
C_LONGINT:C283($err;$vl_Total1;$vl_Total2;$modo_asistencia;$i)

$modo_asistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
AL_CargaEventosConducta ("Atrasos";->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos_Atrasos:55]Fecha:2;->[Alumnos_Atrasos:55]Año:6)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55];<>aCdtaRecNo;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;<>aCdtaDate;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Observaciones:3;<>aCdtaText1;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4;aCdtaBoolean1;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]MinutosAtraso:5;al_alMinutosAtraso;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]HoradeAtraso:12;al_hora_atraso;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]id_justificacion:13;al_idJustificacion;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]justificado:14;ab_justificado;*)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]ID_Asignatura:15;$al_idAtrasoAsig;*)  //MONO 180505
SELECTION TO ARRAY:C260

ARRAY TEXT:C222(at_hora_atraso;Size of array:C274(<>aCdtaRecNo))
ARRAY TEXT:C222(at_atrasoAsig;Size of array:C274($al_idAtrasoAsig))

  //REQ 159627 ABC / / 20180802
C_LONGINT:C283($m;$rango)
If (vi_RegistrarMinutosEnAtrasos=2)
	ARRAY TEXT:C222(at_fraccion;Size of array:C274(al_alMinutosAtraso))
	  //es fraccion por ende llenar arreglo de Fracciòn.
	For ($minuto;1;Size of array:C274(al_alMinutosAtraso))
		For ($rango;1;Size of array:C274(ATSTRAL_FALTAMINUTOSDESDE))
			If ((al_alMinutosAtraso{$minuto}>=ATSTRAL_FALTAMINUTOSDESDE{$rango}) & (al_alMinutosAtraso{$minuto}<=ATSTRAL_FALTAMINUTOSHASTA{$rango}))
				at_fraccion{$minuto}:=ATSTRAL_FALTATIPO{$rango}
				$rango:=Size of array:C274(ATSTRAL_FALTAMINUTOSDESDE)  //si ya encontre el rango al cual vale el minuto cortar el for
			End if 
		End for 
	End for 
End if 

  //cargo la justificacion
ST_JustificacionAtrasos ("cargaVariables")
ARRAY TEXT:C222(at_NombreJustificacion;Size of array:C274(al_idJustificacion))
For ($i;1;Size of array:C274(al_idJustificacion))
	QUERY:C277([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1=al_idJustificacion{$i})
	If (Records in selection:C76([xxSTR_JustificacionAtrasos:227])#-1)
		at_NombreJustificacion{$i}:=[xxSTR_JustificacionAtrasos:227]Motivo:2
	End if 
End for 

If ($modo_asistencia=2)  //Hora detallado
	For ($i;1;Size of array:C274(al_hora_atraso))
		$vt_hora_atraso:=Time string:C180(al_hora_atraso{$i})
		If ($vt_hora_atraso="00:00:00")
			$vt_hora_atraso:=""
		End if 
		at_hora_atraso{$i}:=$vt_hora_atraso
	End for 
End if 

For ($i;1;Size of array:C274($al_idAtrasoAsig))  //MONO 180505
	$id_asign:=$al_idAtrasoAsig{$i}
	at_atrasoAsig{$i}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$id_asign;->[Asignaturas:18]denominacion_interna:16)
End for 




AL_CdtaBehaviourFilter ("createListLte")
ARRAY POINTER:C280(<>aCdtaPtrs;5)
<>aCdtaPtrs{1}:=-><>aCdtaDate
<>aCdtaPtrs{2}:=-><>aCdtaText1
<>aCdtaPtrs{3}:=-><>aCdtaRecNo
<>aCdtaPtrs{4}:=->aCdtaBoolean1
<>aCdtaPtrs{5}:=->al_alMinutosAtraso  //rch
_O_DISABLE BUTTON:C193(bdelLine)

xALSet_AL_Atrasos ($modo_asistencia)