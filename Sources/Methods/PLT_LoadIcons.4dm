//%attributes = {}
  //PLT_LoadIcons
C_BOOLEAN:C305($ENTERABLE)
C_LONGINT:C283($i;$l_numeroBotones;$l_posicion)
C_TEXT:C284($t_nombreBoton)

ARRAY LONGINT:C221($al_refImagenes;0)
ARRAY TEXT:C222($at_nombreBotones;0)

ARRAY TEXT:C222(atPLT_ServicesMethods;0)
ARRAY TEXT:C222(atPLT_ServicesMethods;14)
ARRAY BOOLEAN:C223(abPLT_ServicesMenuItemsState;0)
ARRAY BOOLEAN:C223(abPLT_ServicesMenuItemsState;14)
ARRAY TEXT:C222(atPLT_ServicesTips;0)
ARRAY TEXT:C222(atPLT_ServicesTips;14)
OBJECT SET VISIBLE:C603(*;"bPLT_btn@";False:C215)
OBJECT SET VISIBLE:C603(*;"bPLT_BtnPopUp";True:C214)

  // Herramientas de la aplicación
QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;"ToolsMenuItem";*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=<>vlXS_CurrentModuleRef;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=<>vtXS_CountryCode;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=<>vtXS_langage;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]IconRef:10>0)
REDUCE SELECTION:C351([XShell_ExecutableObjects:280];14)
ORDER BY:C49([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11;>;[XShell_ExecutableObjects:280]Object_Alias:5)

SELECTION TO ARRAY:C260([XShell_ExecutableObjects:280]Object_Alias:5;$at_nombreBotones;[XShell_ExecutableObjects:280]Object_MethodName:3;atPLT_ServicesMethods;[XShell_ExecutableObjects:280]IconRef:10;$al_refImagenes;[XShell_ExecutableObjects:280]Tip:14;atPLT_ServicesTips)
$l_numeroBotones:=Size of array:C274($at_nombreBotones)
For ($i;1;$l_numeroBotones)
	$t_nombreBoton:="bPLT_Btn"+String:C10($i)
	OBJECT SET VISIBLE:C603(*;$t_nombreBoton;True:C214)
	OBJECT SET FORMAT:C236(*;$t_nombreBoton;";?"+String:C10($al_refImagenes{$i})+";;1;0;1;0;0;0;0;0;0;4")
	$l_posicion:=Find in array:C230(atXS_ServicesMenuItems;$at_nombreBotones{$i})
	If ($l_posicion>0)
		abPLT_ServicesMenuItemsState{$i}:=abXS_ToolMenuItemsState{$l_posicion}
		OBJECT SET ENABLED:C1123(*;$t_nombreBoton;abPLT_ServicesMenuItemsState{$i})
	End if 
End for 

$0:=$l_numeroBotones