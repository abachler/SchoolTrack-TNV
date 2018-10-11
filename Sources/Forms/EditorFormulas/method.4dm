  // EditorFormulas()
  // Por: Alberto Bachler: 19/02/13, 10:02:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		HL_ClearList (hl_Operadores)
		hl_operadores:=New list:C375
		  //APPEND TO LIST(hl_Operadores;__ ("Asignación");1)
		  //SET LIST ITEM PARAMETER(hl_Operadores;0;"Operador";":=")
		  //SET LIST ITEM PROPERTIES(hl_Operadores;0;False;Plain;_o_Use PicRef+31992)
		  //APPEND TO LIST(hl_Operadores;__ ("Concatenación");2)
		  //SET LIST ITEM PARAMETER(hl_Operadores;0;"Operador";"+")
		  //SET LIST ITEM PROPERTIES(hl_Operadores;0;False;Plain;_o_Use PicRef+31993)
		  //APPEND TO LIST(hl_Operadores;__ ("Repetición");3)
		  //SET LIST ITEM PARAMETER(hl_Operadores;0;"Operador";"0")
		  //SET LIST ITEM PROPERTIES(hl_Operadores;0;False;Plain;_o_Use PicRef+31994)
		  //APPEND TO LIST(hl_Operadores;__ ("Índices");4)
		  //SET LIST ITEM PARAMETER(hl_Operadores;0;"Operador";"[[]]")
		  //SET LIST ITEM PROPERTIES(hl_Operadores;0;False;Plain;_o_Use PicRef+31995)
		  //APPEND TO LIST(hl_Operadores;__ ("Cadena vacía");5)
		  //SET LIST ITEM PARAMETER(hl_Operadores;0;"Operador";"\"\"")
		  //SET LIST ITEM PROPERTIES(hl_Operadores;0;False;Plain;_o_Use PicRef+31996)
		
		  //HL_ClearList (hl_comandos)
		  //hl_comandos:=New list
		ARRAY TEXT:C222($at_commandNames;0)
		ARRAY LONGINT:C221($al_commandIds;0)
		4D_CMD_Nombres_y_Ids (->$at_commandNames;->$al_commandIds)
		hl_comandos:=AT_Array2ReferencedList (->$at_commandNames;->$al_commandIds;hl_comandos)
		
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_Operadores)
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 



