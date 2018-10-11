//%attributes = {}
  // Método: AS_RegistroActividades
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 16-12-10, 16:24:32
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
  //AS_RegistroActividades

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

Case of 
	: ($vt_accion="ComentarioAsignatura")
		  //tiene que estar cargado alumnos_complementoEvaluacion...
		  //$ptr1 Observacion antigua string
		  //$ptr2 Observacion nueva string
		  //$ptr3 Periodo en string
		  //$ptr4 id Usuario (para web access) numero
		$vt_actividad:="Comentario de asignatura "+ST_Qte ([Asignaturas:18]denominacion_interna:16)+" (curso "+[Asignaturas:18]Curso:5+", ID "+String:C10([Asignaturas:18]Numero:1)+") "
		Case of 
			: ($ptr1->="")
				$vt_actividad:=$vt_actividad+"ingresado"
			: ($ptr2->#"")
				$vt_actividad:=$vt_actividad+"modificado"
			Else 
				$vt_actividad:=$vt_actividad+"eliminado"
		End case 
		$vt_actividad:=$vt_actividad+", para el período: "+$ptr3->+", para el alumno(a): "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;->[Alumnos:2]apellidos_y_nombres:40)+"."
		
		If (Not:C34(Is nil pointer:C315($ptr4)))
			Log_RegisterEvtSTW ($vt_actividad;$ptr4->)
		Else 
			LOG_RegisterEvt ($vt_actividad)
		End if 
End case 

  // Código principal




