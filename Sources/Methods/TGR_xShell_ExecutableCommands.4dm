//%attributes = {}
  // Método: TGR_xShell_ExecutableCommands
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:38:53
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones

vb_Modificado_4Dv11:=True:C214
  //método modificado para v11
  //NO COPIAR A STX

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				  //If ([xShell_ExecutableCommands]ID=0)
				  //[xShell_ExecutableCommands]ID:=SQ_SeqNumber (->[xShell_ExecutableCommands]ID)
				  //End if 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				  //If ([xShell_ExecutableCommands]ID=0)
				  //[xShell_ExecutableCommands]ID:=SQ_SeqNumber (->[xShell_ExecutableCommands]ID)
				  //End if 
				
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ WRITE:C146([xShell_ExecCommands_Localized:232])
				QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6=[xShell_ExecutableCommands:19]ID:10)
				DELETE SELECTION:C66([xShell_ExecCommands_Localized:232])
				
				
		End case 
	End if 
End if 



