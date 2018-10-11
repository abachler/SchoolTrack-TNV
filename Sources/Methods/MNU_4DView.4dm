//%attributes = {}
  // MNU_4DView()
  // Por: Alberto Bachler K.: 24-09-15, 10:06:42
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_refVentana;$i)
ARRAY LONGINT:C221($al_RefVentanas;0)

USR_RegisterUserEvent (UE_4DView;vlBWR_SelectedTableRef)
WINDOW LIST:C442($al_RefVentanas)
For ($i;1;Size of array:C274($al_RefVentanas))
	$t_tituloVentana:=__ ("Planilla de cálculo")+" ("+vsBWR_CurrentModule+")"
	If (Get window title:C450($al_RefVentanas{$i})=$t_tituloVentana)
		$l_refVentana:=$al_RefVentanas{$i}
		$i:=Size of array:C274($al_RefVentanas)
	End if 
End for 

USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
If ($l_refVentana#0)
	BRING TO FRONT:C326(Window process:C446($l_refVentana))
	WDW_SetFrontmost ($l_refVentana)
Else 
	$l_refVentana:=_O_Open external window:C309(5;60;795;520;8;__ ("Planilla de cálculo");"_4D View")
	SET WINDOW TITLE:C213(__ ("Planilla de cálculo")+" ("+vsBWR_CurrentModule+")";$l_refVentana)
End if 


