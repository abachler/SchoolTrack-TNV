//%attributes = {}
  //ACTpgs_ArreglosCuentas

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArreglos")
		ARRAY PICTURE:C279(apACT_ASelectedAlumnos;0)
		ARRAY LONGINT:C221(alACT_AIdsCtas;0)
		ARRAY TEXT:C222(atACT_ANombresAlumnos;0)
		ARRAY REAL:C219(arACT_AMontoXAlumno;0)
		ARRAY BOOLEAN:C223(abACT_ASelectedAlumno;0)
		ARRAY REAL:C219(arACT_AMontoSeleccionadoXAl;0)
		
	: ($vt_accion="EliminaElementosNoSeleccionados")
		AT_Delete ($ptr1->;1;->apACT_ASelectedAlumnos;->alACT_AIdsCtas;->atACT_ANombresAlumnos;->arACT_AMontoXAlumno;->abACT_ASelectedAlumno;->arACT_AMontoSeleccionadoXAl)
		
	: ($vt_accion="SubirElemento")
		ACTit_MoveElementALP (ALP_AlumnosXPagar;1;->apACT_ASelectedAlumnos;->alACT_AIdsCtas;->atACT_ANombresAlumnos;->arACT_AMontoXAlumno;->abACT_ASelectedAlumno;->arACT_AMontoSeleccionadoXAl)
		
	: ($vt_accion="bajarElemento")
		ACTit_MoveElementALP (ALP_AlumnosXPagar;0;->apACT_ASelectedAlumnos;->alACT_AIdsCtas;->atACT_ANombresAlumnos;->arACT_AMontoXAlumno;->abACT_ASelectedAlumno;->arACT_AMontoSeleccionadoXAl)
		
	: ($vt_accion="InsertaElemento")
		AT_Insert ($ptr1->;1;->apACT_ASelectedAlumnos;->alACT_AIdsCtas;->atACT_ANombresAlumnos;->arACT_AMontoXAlumno;->abACT_ASelectedAlumno;->arACT_AMontoSeleccionadoXAl)
		
End case 