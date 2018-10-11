  // [xShell_BatchRequests].TareasProgramadas()
  // Por: Alberto Bachler K.: 14-12-13, 15:54:33
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$b_actualizar:=False:C215

Case of 
		
	: (Form event:C388=On Load:K2:1)
		  //ALL RECORDS([xShell_BatchRequests])
		POST KEY:C465(Character code:C91("*");256;Current process:C322)
		SET TIMER:C645(300)
		$b_actualizar:=True:C214
		
	: (Form event:C388=On Activate:K2:9)
		$b_actualizar:=True:C214
		SET TIMER:C645(300)
		
		
	: (Form event:C388=On Timer:K2:25)
		If (Records in set:C195("tareasSeleccionadas")=0)
			$b_actualizar:=True:C214
		Else 
			$b_actualizar:=False:C215
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		$b_actualizar:=False:C215
		SET TIMER:C645(0)
		HIDE PROCESS:C324(Current process:C322)
		PAUSE PROCESS:C319(Current process:C322)
End case 

If ($b_actualizar)
	READ ONLY:C145([xShell_BatchRequests:48])  //20140404 RCH Al abrir la ventana quedaba una tarea tomada por el proceso.
	QUERY:C277([xShell_BatchRequests:48];[xShell_BatchRequests:48]Action:1#"")
	ORDER BY:C49([xShell_BatchRequests:48];[xShell_BatchRequests:48]DTS:10;>)
	If (Records in set:C195("tareasSeleccionadas")=0)
		OBJECT SET TITLE:C194(*;"textoCola";__ ("Tareas en cola: ")+String:C10(Records in selection:C76([xShell_BatchRequests:48])))
	Else 
		OBJECT SET TITLE:C194(*;"textoCola";String:C10(Records in set:C195("tareasSeleccionadas"))+__ (" sobre ")+String:C10(Records in selection:C76([xShell_BatchRequests:48]))+__ (" tareas en cola:"))
	End if 
Else 
	  // El usuario ha seleccionado tareas en la lista suspendemos la actualización.
End if 

