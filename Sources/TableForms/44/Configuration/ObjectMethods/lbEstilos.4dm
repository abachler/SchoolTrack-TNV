  // [xxSTR_EstilosEvaluacion].Configuration.lbEstilos()
  // Por: Alberto Bachler K.: 29-12-14, 11:07:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_colum;$l_linea)
C_POINTER:C301($y_variableColumna)
C_BOOLEAN:C305($b_estiloEnUso;$b_estiloEnUsoAsig;$b_estiloEnUsoEvInt;$b_estiloEnUsoEvOf)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			
			  // ASM 20160223 Ticket 150340
			LISTBOX GET CELL POSITION:C971(lbEstilos;$l_colum;$l_linea;$y_variableColumna)
			KRL_GotoRecord (->[xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{$l_linea};True:C214)
			$b_estiloEnUso:=((Find in field:C653([xxSTR_Niveles:6]EvStyle_interno:33;[xxSTR_EstilosEvaluacion:44]ID:1)>No current record:K29:2) | (Find in field:C653([xxSTR_Niveles:6]EvStyle_oficial:23;[xxSTR_EstilosEvaluacion:44]ID:1)>No current record:K29:2))
			
			
			
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_asignaturas)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			$t_menu:=Create menu:C408
			APPEND MENU ITEM:C411($t_menu;__ ("Nuevo estilo"))
			SET MENU ITEM PARAMETER:C1004($t_menu;-1;"nuevo")
			If (aEvStyleName>0)
				APPEND MENU ITEM:C411($t_menu;__ ("Duplicar ")+"\""+aEvStyleName{aEvStyleName}+"\"")
				SET MENU ITEM PARAMETER:C1004($t_menu;-1;"duplicar")
				APPEND MENU ITEM:C411($t_menu;"(-")
				If ((aEvStyleId{aEvStyleId}<0) | ($l_asignaturas>0) | ($b_estiloEnUso))
					APPEND MENU ITEM:C411($t_menu;"("+__ ("Eliminar ")+"\""+aEvStyleName{aEvStyleName}+"\"")
					SET MENU ITEM PARAMETER:C1004($t_menu;-1;"eliminar")
				Else 
					APPEND MENU ITEM:C411($t_menu;__ ("Eliminar ")+"\""+aEvStyleName{aEvStyleName}+"\"")
					SET MENU ITEM PARAMETER:C1004($t_menu;-1;"eliminar")
				End if 
			Else 
				APPEND MENU ITEM:C411($t_menu;"(";__ ("Duplicar"))
				APPEND MENU ITEM:C411($t_menu;"(-")
				APPEND MENU ITEM:C411($t_menu;"(";__ ("Eliminar"))
			End if 
			APPEND MENU ITEM:C411($t_menu;"(-")
			APPEND MENU ITEM:C411($t_menu;__ ("Restaurar estilos estándar"))
			SET MENU ITEM PARAMETER:C1004($t_menu;-1;"restaurar")
			APPEND MENU ITEM:C411($t_menu;"(-")
			APPEND MENU ITEM:C411($t_menu;__ ("Rasgos de personalidad"))
			SET MENU ITEM PARAMETER:C1004($t_menu;-1;"rasgos")
			APPEND MENU ITEM:C411($t_menu;__ ("Actividades extra curriculares"))
			SET MENU ITEM PARAMETER:C1004($t_menu;-1;"actividades")
			
			$t_accion:=Dynamic pop up menu:C1006($t_menu)
			RELEASE MENU:C978($t_menu)
			
			EVS_EjecutaAccion ($t_accion)
			
		Else 
			
		End if 
		
		
	: (Form event:C388=On Selection Change:K2:29)
		If (Find in array:C230(lbEstilos;True:C214)>0)
			KRL_GotoRecord (->[xxSTR_EstilosEvaluacion:44];vl_LastEvStyleRecNum;True:C214)
			If (Find in array:C230(alEVS_ModifiedStyles;[xxSTR_EstilosEvaluacion:44]ID:1)>0)
				LOG_RegisterEvt ("Modificación del estilo de evaluación Nº "+String:C10([xxSTR_EstilosEvaluacion:44]ID:1)+": "+[xxSTR_EstilosEvaluacion:44]Name:2)
			End if 
			EVS_GuardaEstiloEvaluacion 
			UNLOAD RECORD:C212([xxSTR_EstilosEvaluacion:44])
		Else 
			$l_fila:=Find in array:C230(aEvStyleRecNo;vl_LastEvStyleRecNum)
			LISTBOX SELECT ROW:C912(*;"lbEstilos";$l_fila)
		End if 
		EVS_CargaEstiloEvaluacion (aEvStyleId{aEvStyleId})
		OBJECT SET VISIBLE:C603(*;"DescEsfuerzo";(cb_EvaluaEsfuerzo=1))
		vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
		
		
		
	: (Form event:C388=On Data Change:K2:15)
		$l_idEstilo:=aEvStyleId{aEvStyleId}
		EVS_GuardaEstiloEvaluacion 
		[xxSTR_EstilosEvaluacion:44]Name:2:=Get edited text:C655
		SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
		vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
		
End case 

