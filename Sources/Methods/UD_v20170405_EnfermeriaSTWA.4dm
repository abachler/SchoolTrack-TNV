//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 05-04-17, 17:26:32
  // ----------------------------------------------------
  // Método: UD_v20170405_EnfermeriaSTWA
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$i_registros;$l_IDTrata;$l_progress;$l_registros;$l_therm)
C_PICTURE:C286($p_icon)
C_POINTER:C301($y_tabla)
C_OBJECT:C1216($o_temporal;$o_temporalTrat;$o_tratamiento)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_afecciones;0)
ARRAY TEXT:C222($at_iniciaObjeto;0)
ARRAY TEXT:C222($at_temporal;0)
ARRAY OBJECT:C1221($ao_Afecciones;0)

READ WRITE:C146([Alumnos_FichaMedica:13])
ALL RECORDS:C47([Alumnos:2])
$o_tratamiento:=OB_Create 

$l_progress:=Progress New 
Progress SET TITLE ($l_progress;"Inicializando nuevos campos en ficha médica de alumnos…")
Progress SET ICON ($l_progress;<>p_iconoColegium)
$y_tabla:=->[Alumnos:2]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ WRITE:C146($y_tabla->)
$l_registros:=Records in selection:C76($y_tabla->)
For ($i_registros;1;$l_registros)
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	Progress SET PROGRESS ($l_progress;$i_registros/$l_registros)
	QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
	If ([Alumnos_FichaMedica:13]Tratamientos:18#"")
		$o_tratamiento:=[Alumnos_FichaMedica:13]OB_tratamiento:23
		$l_IDTrata:=ST_ObtieneID ("obtieneID")
		$d_fecha:=Current date:C33(*)
		$o_temporalTrat:=OB_Create 
		OB_SET ($o_temporalTrat;->[Alumnos_FichaMedica:13]Tratamientos:18;"tratObservacion")
		OB_SET ($o_temporalTrat;->$l_IDTrata;"tratID")
		OB_SET ($o_temporalTrat;->$d_fecha;"tratNotificacion")
		OB_SET ($o_tratamiento;->$o_temporalTrat;String:C10($l_IDTrata))
		[Alumnos_FichaMedica:13]OB_tratamiento:23:=$o_tratamiento
	Else 
		[Alumnos_FichaMedica:13]OB_tratamiento:23:=OB_Create 
	End if 
	SAVE RECORD:C53([Alumnos_FichaMedica:13])
End for 
Progress QUIT ($l_progress)
KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])



ALL RECORDS:C47([Alumnos_EventosEnfermeria:14])
$y_tabla:=->[Alumnos_EventosEnfermeria:14]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ WRITE:C146($y_tabla->)
$l_registros:=Records in selection:C76($y_tabla->)
$l_progress:=Progress New 
Progress SET TITLE ($l_progress;"Inicializando nuevos campos en eventos enfermería...")
Progress SET ICON ($l_progress;<>p_iconoColegium)

$o_evolucion:=OB_Create 
OB_SET ($o_evolucion;->$at_iniciaObjeto;"evolucion")
$o_medicamentos:=OB_Create 
OB_SET ($o_medicamentos;->$at_iniciaObjeto;"medicamentos")
$o_derivacion:=OB_Create 
OB_SET ($o_derivacion;->$at_iniciaObjeto;"derivacion")

For ($i_registros;1;$l_registros)
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	Progress SET PROGRESS ($l_progress;$i_registros/$l_registros)
	AT_Initialize (->$at_temporal)
	APPEND TO ARRAY:C911($at_temporal;[Alumnos_EventosEnfermeria:14]Afeccion:6)
	OB SET ARRAY:C1227([Alumnos_EventosEnfermeria:14]OB_Afeccion:20;"OB";$at_temporal)
	[Alumnos_EventosEnfermeria:14]OB_derivacion:23:=$o_derivacion
	[Alumnos_EventosEnfermeria:14]OB_medicamentos:22:=$o_medicamentos
	[Alumnos_EventosEnfermeria:14]OB_evolucion:21:=$o_evolucion
	SAVE RECORD:C53([Alumnos_EventosEnfermeria:14])
End for 
Progress QUIT ($l_progress)





