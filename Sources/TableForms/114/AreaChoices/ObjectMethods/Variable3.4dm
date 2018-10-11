If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script bReturn
	  //Autor: Alberto Bachler
	  //Creada el 25/11/96 a 9:04 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
  //choiceIdx:=AL_GetLine (xALP_Choices)
  //If (choiceIdx#0)
  //  `AL_SetSort (Self->;vi_indexCol)
  //ACCEPT
  //End if 

If (vb_AllowMultiLine)
	ARRAY INTEGER:C220(aLinesSelected;0)
	$result:=AL_GetSelect (xALP_Choices;aLinesSelected)
	If (Size of array:C274(aLinesSelected)>0)
		ACCEPT:C269
	End if 
Else 
	choiceIdx:=AL_GetLine (xALP_Choices)
	If (choiceIdx#0)
		  //AL_SetSort (xALP_Choices;vi_indexCol)
		ACCEPT:C269
	End if 
End if 