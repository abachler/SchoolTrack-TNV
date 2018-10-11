//%attributes = {}
  // CIM_GotoPage_LogActividades()
  // Por: Alberto Bachler K.: 08-10-15, 19:15:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_abajo;$l_altoOptimo;$l_anchoOptimo;$l_arriba;$l_colorFondo;$l_colorTexto;$l_derecha;$l_izquierda)
C_POINTER:C301($y_refMenuModulos;$y_refMenuUsuarios)

ARRAY LONGINT:C221($al_Paginas;0)
ARRAY POINTER:C280($ay_objetos;0)
ARRAY TEXT:C222($at_modulos;0)
ARRAY TEXT:C222($at_objetos;0)
ARRAY TEXT:C222($at_usuarios;0)

GOTO OBJECT:C206(*;"SearchBox")


OBJECT SET FONT STYLE:C166(*;"bPeriodo_@";Plain:K14:1)
OBJECT SET COLOR:C271(*;"bPeriodo_@";-Dark grey:K11:12)
OBJECT SET FONT STYLE:C166(*;"bPeriodo_hoy";Bold:K14:2)
OBJECT GET COORDINATES:C663(*;"bPeriodo_hoy";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
IT_SetNamedObjectRect ("fondoFiltro";$l_izquierda-8;$l_arriba-5;$l_derecha+8;$l_abajo+5)
$l_colorFondo:=(210 << 16)+(228 << 8)+248
$l_colorTexto:=(31 << 16)+(102 << 8)+177
OBJECT SET RGB COLORS:C628(*;"fondoFiltro";$l_colorFondo;$l_colorFondo)
OBJECT SET RGB COLORS:C628(*;"bPeriodo_hoy";$l_colorTexto;$l_colorFondo)

QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;=;Current date:C33(*))
ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
OBJECT SET TITLE:C194(*;"totalEventos";String:C10(Records in selection:C76([xShell_Logs:37]))+__ (" sobre ")+String:C10(Records in table:C83([xShell_Logs:37]))+" "+__ ("eventos"))
LB_FijaColorAlterno ("lb_logActividades")


AT_DistinctsFieldValues (->[xShell_Logs:37]Module:8;->$at_modulos)
$y_refMenuModulos:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuModulos")
RELEASE MENU:C978($y_refMenuModulos->)
$y_refMenuModulos->:=MNU_ArrayToMenu (->$at_modulos)


AT_DistinctsFieldValues (->[xShell_Logs:37]UserName:2;->$at_usuarios)
$y_refMenuUsuarios:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuUsuarios")
RELEASE MENU:C978($y_refMenuUsuarios->)
$y_refMenuUsuarios->:=MNU_ArrayToMenu (->$at_usuarios)



