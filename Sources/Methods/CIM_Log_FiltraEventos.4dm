//%attributes = {}
  // CIM_Log_FiltraEventos()
  // Por: Alberto Bachler Klein: 20-10-15, 19:14:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_abajo;$l_arriba;$l_colorFondo;$l_colorTexto;$l_derecha;$l_izquierda)
C_POINTER:C301($y_refMenuModulos;$y_refMenuUsuarios)
C_TEXT:C284($t_objeto;$t_Texto)

ARRAY TEXT:C222($at_modulos;0)
ARRAY TEXT:C222($at_Palabras;0)
ARRAY TEXT:C222($at_parametros;0)
ARRAY TEXT:C222($at_usuarios;0)


If (Count parameters:C259=1)
	$t_objeto:=$1
	OBJECT SET COLOR:C271(*;"bPeriodo_@";-Dark grey:K11:12)
	OBJECT SET FONT STYLE:C166(*;"bPeriodo_@";Plain:K14:1)
	OBJECT SET FONT STYLE:C166(*;$t_objeto;Bold:K14:2)
	OBJECT GET COORDINATES:C663(*;$t_objeto;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	IT_SetNamedObjectRect ("fondoFiltro";$l_izquierda-8;$l_arriba-5;$l_derecha+8;$l_abajo+5)
	$l_colorFondo:=(210 << 16)+(228 << 8)+248
	$l_colorTexto:=(31 << 16)+(102 << 8)+177
	OBJECT SET RGB COLORS:C628(*;"fondoFiltro";$l_colorFondo;$l_colorFondo)
	OBJECT SET RGB COLORS:C628(*;$t_objeto;$l_colorTexto;$l_colorFondo)
End if 

Case of 
	: (($t_objeto="bPeriodo_todo") | (OBJECT Get font style:C1071(*;"bPeriodo_todo")=Bold:K14:2))
		ALL RECORDS:C47([xShell_Logs:37])
		
	: (($t_objeto="bPeriodo_hoy") | (OBJECT Get font style:C1071(*;"bPeriodo_hoy")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;=;Current date:C33(*))
		
	: (($t_objeto="bPeriodo_ayer") | (OBJECT Get font style:C1071(*;"bPeriodo_ayer")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;>=;Add to date:C393(Current date:C33(*);0;0;-1))
		
	: (($t_objeto="bPeriodo_semana") | (OBJECT Get font style:C1071(*;"bPeriodo_semana")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;>=;Add to date:C393(Current date:C33(*);0;0;-7))
		
	: (($t_objeto="bPeriodo_quincena") | (OBJECT Get font style:C1071(*;"bPeriodo_quincena")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;>=;Add to date:C393(Current date:C33(*);0;0;-15))
		
	: (($t_objeto="bPeriodo_mes") | (OBJECT Get font style:C1071(*;"bPeriodo_mes")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;>=;Add to date:C393(Current date:C33(*);0;-1;0))
		
	: (($t_objeto="bPeriodo_trimestre") | (OBJECT Get font style:C1071(*;"bPeriodo_trimestre")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;>=;Add to date:C393(Current date:C33(*);0;-3;0))
		
	: (($t_objeto="bPeriodo_año") | (OBJECT Get font style:C1071(*;"bPeriodo_año")=Bold:K14:2))
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3;>=;Add to date:C393(Current date:C33(*);-1;0;0))
End case 



$t_Texto:=(OBJECT Get pointer:C1124(Object named:K67:5;"SearchBox"))->
If ($t_Texto#"")
	GET TEXT KEYWORDS:C1141($t_Texto;$at_Palabras)
	If (Size of array:C274($at_Palabras)>0)
		QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]Event_Description:5;%;"@"+$at_Palabras{1}+"@";*)
		QUERY SELECTION:C341([xShell_Logs:37]; | [xShell_Logs:37]UserName:2;%;"@"+$at_Palabras{1}+"@";*)
		For ($i;2;Size of array:C274($at_Palabras))
			QUERY SELECTION:C341([xShell_Logs:37]; | [xShell_Logs:37]Event_Description:5;%;"@"+$at_Palabras{$i}+"@";*)
			QUERY SELECTION:C341([xShell_Logs:37]; | [xShell_Logs:37]UserName:2;%;"@"+$at_Palabras{$i}+"@";*)
		End for 
		QUERY SELECTION:C341([xShell_Logs:37])
	End if 
End if 
ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
OBJECT SET TITLE:C194(*;"totalEventos";String:C10(Records in selection:C76([xShell_Logs:37]))+__ (" sobre ")+String:C10(Records in table:C83([xShell_Logs:37]))+" "+__ ("eventos"))


AT_DistinctsFieldValues (->[xShell_Logs:37]Module:8;->$at_modulos)
AT_RedimArrays (Size of array:C274($at_modulos);->$at_parametros)
For ($i;1;Size of array:C274($at_modulos))
	$at_parametros{$i}:="M&"+$at_modulos{$i}
End for 
$y_refMenuModulos:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuModulos")
RELEASE MENU:C978($y_refMenuModulos->)
$y_refMenuModulos->:=MNU_ArrayToMenu (->$at_modulos;->$at_parametros)


AT_DistinctsFieldValues (->[xShell_Logs:37]UserName:2;->$at_usuarios)
AT_RedimArrays (Size of array:C274($at_usuarios);->$at_parametros)
For ($i;1;Size of array:C274($at_usuarios))
	$at_parametros{$i}:="U&"+$at_usuarios{$i}
End for 
$y_refMenuUsuarios:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuUsuarios")
RELEASE MENU:C978($y_refMenuUsuarios->)
$y_refMenuUsuarios->:=MNU_ArrayToMenu (->$at_usuarios;->$at_parametros)