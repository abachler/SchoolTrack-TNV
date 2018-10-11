//%attributes = {}
  // MNU_4DChart()
  // Por: Alberto Bachler K.: 24-09-15, 10:08:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_refVentana;$i)
ARRAY LONGINT:C221($al_RefVentanas;0)


USR_RegisterUserEvent (UE_4DChart;vlBWR_SelectedTableRef)
WINDOW LIST:C442($al_RefVentanas)
For ($i;1;Size of array:C274($al_RefVentanas))
	$t_tituloVentana:=__ ("Graficador")+" ("+vsBWR_CurrentModule+")"
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
	$l_refVentana:=_O_Open external window:C309(5;60;795;520;8;__ ("Graficador");"_4D Chart")
	SET WINDOW TITLE:C213(__ ("Graficador")+" ("+vsBWR_CurrentModule+")";$l_refVentana)
End if 

  //
  //
  //USR_RegisterUserEvent (UE_4DChart;vlBWR_SelectedTableRef)
  //
  //C_LONGINT(<>vl4DChartArea)
  //If (<>vl4DChartArea=0)
  //PLATFORM PROPERTIES($platForm)
  //If ($platForm=3)
  //<>vl4DChartArea:=Open external window(5;60;795;520;8;"Graficador";"_4D Chart")
  //Else 
  //<>vl4DChartArea:=Open external window(5;40;795;540;8;"Graficador";"_4D Chart")
  //End if 
  //WDW_SetWindowIcon (Frontmost window)
  //WDW_AddRemoveWindow ("Add";<>vl4DChartArea)
  //Else 
  //If (Window process(<>vl4DChartArea)#0)
  //WDW_SetFrontmost (<>vl4DChartArea)
  //Else 
  //<>vl4DChartArea:=0
  //PLATFORM PROPERTIES($platForm)
  //If ($platForm=3)
  //<>vl4DChartArea:=Open external window(5;60;795;520;8;"Graficador";"_4D Chart")
  //Else 
  //<>vl4DChartArea:=Open external window(5;40;795;540;8;"Graficador";"_4D Chart")
  //End if 
  //WDW_SetWindowIcon (Frontmost window)
  //WDW_AddRemoveWindow ("Add";<>vl4DChartArea)
  //End if 
  //End if 