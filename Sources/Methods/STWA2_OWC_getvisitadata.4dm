//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:30:00
  // ----------------------------------------------------
  // Método: STWA2_OWC_getvisitadata
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_afeccion)
$ob_afeccion:=OB_Create 
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
If (KRL_GotoRecord (->[Alumnos_EventosEnfermeria:14];$rn;False:C215))
	$fechatxt:=STWA2_MakeDate4JS ([Alumnos_EventosEnfermeria:14]Fecha:2)
	$horavisita:=String:C10([Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;HH MM:K7:2)
	$procedencia:=[Alumnos_EventosEnfermeria:14]Procedencia:4
	$ingresador:=[Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16
	$ingresadorNombre:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$ingresador;->[Profesores:4]Apellidos_y_nombres:28)
	$autorizador:=[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13
	$autorizadorNombre:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$autorizador;->[Profesores:4]Apellidos_y_nombres:28)
	$asignatura:=[Alumnos_EventosEnfermeria:14]Asignatura:11
	$profesorid:=[Alumnos_EventosEnfermeria:14]ID_Profesor:12
	$profesorNombre:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$profesorid;->[Profesores:4]Apellidos_y_nombres:28)
	$fueradehorario:=[Alumnos_EventosEnfermeria:14]Fuera_de_horario:14
	$afeccion:=[Alumnos_EventosEnfermeria:14]Afeccion:6
	$tratamiento:=[Alumnos_EventosEnfermeria:14]Tratamiento:7
	$obsinterna:=[Alumnos_EventosEnfermeria:14]obs_privada:18
	$obs:=[Alumnos_EventosEnfermeria:14]Observaciones:10
	$ob_afeccion:=[Alumnos_EventosEnfermeria:14]OB_Afeccion:20
	$ob_evolucion:=[Alumnos_EventosEnfermeria:14]OB_evolucion:21
	$ob_medicamentos:=[Alumnos_EventosEnfermeria:14]OB_medicamentos:22
	$ob_derivacion:=[Alumnos_EventosEnfermeria:14]OB_derivacion:23
	ARRAY TEXT:C222($atRecomendaciones;0)
	AT_Text2Array (->$atRecomendaciones;[Alumnos_EventosEnfermeria:14]Recomendaciones:17;";")
	$horasalida:=String:C10([Alumnos_EventosEnfermeria:14]Hora_de_Salida:8;HH MM:K7:2)
	$destino:=[Alumnos_EventosEnfermeria:14]Destino:9
	C_OBJECT:C1216($ob_raiz)
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$fechatxt;"fecha")
	OB_SET ($ob_raiz;->$horavisita;"horavisita")
	OB_SET ($ob_raiz;->$procedencia;"procedencia")
	OB_SET ($ob_raiz;->$ingresadorNombre;"ingresadorNombre")
	OB_SET ($ob_raiz;->$autorizadorNombre;"autorizadorNombre")
	OB_SET ($ob_raiz;->$asignatura;"asignatura")
	OB_SET ($ob_raiz;->$afeccion;"afeccion")
	OB_SET ($ob_raiz;->$tratamiento;"tratamiento")
	OB_SET ($ob_raiz;->$obsinterna;"obsprivada")
	OB_SET ($ob_raiz;->$obs;"obs")
	OB_SET ($ob_raiz;->$horasalida;"horasalida")
	OB_SET ($ob_raiz;->$destino;"destino")
	OB_SET ($ob_raiz;->$profesorNombre;"profesorNombre")
	OB_SET ($ob_raiz;->$ingresador;"ingresador")
	OB_SET ($ob_raiz;->$autorizador;"autorizador")
	OB_SET ($ob_raiz;->$profesorid;"profesor")
	OB_SET ($ob_raiz;->$fueradehorario;"fuerahorario")
	OB_SET ($ob_raiz;->$atRecomendaciones;"recomendaciones")
	OB_SET ($ob_raiz;->$ob_afeccion;"afeccionOB")
	OB_SET ($ob_raiz;->$ob_evolucion;"evolucion")
	OB_SET ($ob_raiz;->$ob_medicamentos;"medicamentos")
	OB_SET ($ob_raiz;->$ob_derivacion;"derivacion")
	$json:=OB_Object2Json ($ob_raiz)
	
Else 
	  //ERROR
End if 

$0:=$json
