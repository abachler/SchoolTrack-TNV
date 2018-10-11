//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-12-16, 12:05:25
  // ----------------------------------------------------
  // Método: AL_TratamientoEnfermeria
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


$t_accion:=$1
Case of 
	: ($t_accion="ELiminaTratamiento")
		C_LONGINT:C283($l_columna;$l_fila)
		C_POINTER:C301($y_punteroVarColumna)
		$l_fila:=0
		$l_columna:=0
		LISTBOX GET CELL POSITION:C971(lb_tratamientos;$l_columna;$l_fila;$y_punteroVarColumna)
		If ((Size of array:C274($y_punteroVarColumna->)>0) & ($l_fila<=Size of array:C274($y_punteroVarColumna->)) & ($l_fila>0))
			OB REMOVE:C1226([Alumnos_FichaMedica:13]OB_tratamiento:23;String:C10(al_idTratamiento{$l_fila}))
			DELETE FROM ARRAY:C228(ad_fechaTratamiento;$l_fila)
			DELETE FROM ARRAY:C228(al_idTratamiento;$l_fila)
			DELETE FROM ARRAY:C228(at_observacion;$l_fila)
		End if 
		vl_ModSalud:=vl_ModSalud ?+ 6
		
	: ($t_accion="CargaTratamientos")
		C_OBJECT:C1216($ob_tratamientos;$ob_temporal)
		C_TEXT:C284($t_observacion;$t_fecha)
		C_LONGINT:C283($l_idTratamiento)
		C_DATE:C307($d_fecha)
		
		ARRAY DATE:C224(ad_fechaTratamiento;0)
		ARRAY TEXT:C222(at_observacion;0)
		ARRAY LONGINT:C221(al_idTratamiento;0)
		ARRAY TEXT:C222($at_nombreNodos;0)
		
		$ob_tratamientos:=[Alumnos_FichaMedica:13]OB_tratamiento:23
		OB_GetChildNodes ($ob_tratamientos;->$at_nombreNodos)
		
		For ($i;1;Size of array:C274($at_nombreNodos))
			OB_GET ($ob_tratamientos;->$ob_temporal;$at_nombreNodos{$i})
			OB_GET ($ob_temporal;->$l_idTratamiento;"tratID")
			OB_GET ($ob_temporal;->$t_observacion;"tratObservacion")
			OB_GET ($ob_temporal;->$t_fecha;"tratNotificacion")
			
			APPEND TO ARRAY:C911(ad_fechaTratamiento;Date:C102($t_fecha))
			APPEND TO ARRAY:C911(al_idTratamiento;$l_idTratamiento)
			APPEND TO ARRAY:C911(at_observacion;$t_observacion)
		End for 
		
		OBJECT SET ENABLED:C1123(*;"buttonsTratamientodelete";False:C215)
		vl_ModSalud:=vl_ModSalud ?+ 6
		
	: ($t_accion="agregaTratamiento")
		APPEND TO ARRAY:C911(ad_fechaTratamiento;Current date:C33(*))
		APPEND TO ARRAY:C911(al_idTratamiento;ST_ObtieneID ("obtieneID"))
		APPEND TO ARRAY:C911(at_observacion;"Ingrese observación...")
		OBJECT SET ENABLED:C1123(*;"buttonsTratamientodelete";True:C214)
		vl_ModSalud:=vl_ModSalud ?+ 6
End case 

