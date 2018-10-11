  // [xShell_BatchRequests].TareasProgramadas.lb_Tareas()
  // Por: Alberto Bachler K.: 14-12-13, 16:22:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_opcionUsuario;$l_tareasEliminadas)
C_TEXT:C284($t_popupItems;$t_tipoTareasEliminadas)

ARRAY TEXT:C222($at_tareas;0)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Records in set:C195("tareasSeleccionadas")=0)
			OBJECT SET TITLE:C194(*;"textoCola";__ ("Tareas en cola: ")+String:C10(Records in selection:C76([xShell_BatchRequests:48])))
		Else 
			OBJECT SET TITLE:C194(*;"textoCola";String:C10(Records in set:C195("tareasSeleccionadas"))+__ (" sobre ")+String:C10(Records in selection:C76([xShell_BatchRequests:48]))+__ (" tareas en cola:"))
		End if 
		
		If (Contextual click:C713)
			If (USR_IsGroupMember_by_GrpID (-15001))
				If (Records in selection:C76([xShell_BatchRequests:48])>0)
					$t_popupItems:=__ ("Actualizar lista de tareas")+";(-;"+__ ("Eliminar tareas seleccionadas")+";"+__ ("Eliminar todas las tareas")
				Else 
					$t_popupItems:=__ ("Actualizar lista de tareas")+";(-;"+"("+__ ("Eliminar tareas seleccionadas")+";"+__ ("Eliminar todas las tareas")
				End if 
			End if 
			$l_opcionUsuario:=Pop up menu:C542($t_popupItems)
			Case of 
				: ($l_opcionUsuario=1)
					POST KEY:C465(Character code:C91("*");256;Current process:C322)
				: ($l_opcionUsuario>=3)
					If ($l_opcionUsuario=3)
						USE SET:C118("tareasSeleccionadas")
					End if 
					$l_tareasEliminadas:=Records in selection:C76([xShell_BatchRequests:48])
					AT_DistinctsFieldValues (->[xShell_BatchRequests:48]Action:1;->$at_tareas)
					$t_tipoTareasEliminadas:=AT_array2text (->$at_tareas;", ")
					READ WRITE:C146([xShell_BatchRequests:48])
					DELETE SELECTION:C66([xShell_BatchRequests:48])
					LOG_RegisterEvt ("Tareas Programadas: Han sido eliminadas "+String:C10($l_tareasEliminadas)+" tareas. Los tipo de tareas son los siguientes:"+"\r"+$t_tipoTareasEliminadas)
					POST KEY:C465(Character code:C91("*");256;Current process:C322)
			End case 
		End if 
End case 

