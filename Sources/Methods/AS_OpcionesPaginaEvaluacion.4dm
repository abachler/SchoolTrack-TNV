//%attributes = {}
  // AS_OpcionesPaginaEvaluacion()
  // Por: Alberto Bachler K.: 03-02-14, 18:50:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_arriba;$l_derecha;$l_Error;$l_izquierda)
C_TEXT:C284($t_modoActual)

ARRAY LONGINT:C221($al_Ordenamientos;0)
ARRAY TEXT:C222($at_encabezados;0)

$l_ColorSinFoco:=0x0000 | (120 << 16) | (120 << 8) | 120
OBJECT SET RGB COLORS:C628(*;"$botonMenu@";$l_ColorSinFoco;Background color:K23:2)

  // establezco los botones de la barra de menus de la planilla de calificaciones
OBJECT SET TITLE:C194(*;"$botonMenu_Periodos";Replace string:C233(sPeriodo;"/";" | "))
OBJECT GET BEST SIZE:C717(*;"$botonMenu_Periodos";$l_ancho;$l_alto)
OBJECT GET COORDINATES:C663(*;"$botonMenu_Periodos";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_derecha:=$l_izquierda+$l_ancho+20
OBJECT SET COORDINATES:C1248(*;"$botonMenu_Periodos";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)

  // modo de visualizacion
Case of 
	: (vi_lastGradeView=Notas)
		$t_modoActual:=__ ("Notas")
	: (vi_lastGradeView=Puntos)
		$t_modoActual:=__ ("Puntos")
	: (vi_lastGradeView=Porcentaje)
		$t_modoActual:=__ ("Porcentaje")
	: (vi_lastGradeView=Simbolos)
		$t_modoActual:=__ ("Símbolo")
End case 
OBJECT SET TITLE:C194(*;"$botonMenu_Modo";__ ("Ver como: ")+$t_modoActual)
OBJECT GET BEST SIZE:C717(*;"$botonMenu_Modo";$l_ancho;$l_alto)
If ($l_ancho>200)
	$l_ancho:=200
End if 
$l_izquierda:=$l_derecha+10
$l_derecha:=$l_izquierda+$l_ancho+20
OBJECT SET COORDINATES:C1248(*;"$botonMenu_Modo";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)

  // ordenamiento
$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_SortList;$al_Ordenamientos)
$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_HeaderText;$at_encabezados)

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
  //If (<>viSTR_AgruparPorSexo=1)
If (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
	$at_encabezados{Size of array:C274($at_encabezados)-1}:="Sexo"
End if 

OBJECT SET TITLE:C194(*;"$botonMenu_Ordenamiento";"Ordenar por "+$at_encabezados{Abs:C99($al_Ordenamientos{1})})
OBJECT GET BEST SIZE:C717(*;"$botonMenu_Ordenamiento";$l_ancho;$l_alto)
If ($l_ancho>400)
	$l_ancho:=400
End if 
$l_izquierda:=$l_derecha+10
$l_derecha:=$l_izquierda+$l_ancho+20
OBJECT SET COORDINATES:C1248(*;"$botonMenu_Ordenamiento";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)



