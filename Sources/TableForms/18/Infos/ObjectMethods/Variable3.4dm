If (False:C215)
	  //Object Method: xAL_Infos
	  //Written by  Alberto Bachler on 15/3/98
	  //Module: 
	  //Purpose: 
	  //Syntax: Object  xAL_Infos()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
End if 


  //DECLARATIONS


  //INITIALIZATION


  //MAIN CODE
$err:=AL_SetArraysNam (xALP_Infos;1;4;"atLogDesc";"adLogDate";"alLogTime";"atLogUser")

AL_SetSort (xALP_Infos;-2;-3)
AL_SetFormat (xALP_Infos;3;"&/1")
AL_SetWidths (xALP_Infos;1;4;160;60;60;110)
AL_SetHeaders (xALP_Infos;1;4;__ ("Evento");__ ("Fecha");__ ("Hora");__ ("Usuario"))
AL_SetStyle (xALP_Infos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_Infos;0;"Tahoma";9;0)
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 