//%attributes = {}
  //MNU_DeleteSelection

  // mn_DeleteSelection
  // by: Alberto
  // 21/5/03
  // purpose:
If (False:C215)
	<>xShellModificationDate:=!1903-05-21!
	  // 
End if 

If (USR_checkRights ("D";yBWR_currentTable))
	If (Size of array:C274(abrSelect)>0)
		$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
		$err:=BWR_SearchRecords 
		If (Records in selection:C76(yBWR_currentTable->)>0)
			$deleted:=dhMNU_DeleteSelection 
			If ($deleted=-1)
				$r:=CD_Dlog (0;__ ("Los registros serán eliminados definitivamente sin ninguna verificación adicional.\r¿Desea realmente eliminar los registros seleccionados?");__ ("");__ ("No");__ ("Si"))
				If ($r=2)
					READ WRITE:C146(yBWR_currentTable->)
					DELETE SELECTION:C66(yBWR_currentTable->)
					LOG_RegisterEvt ("Eliminación de selección de registros de la tabla "+API Get Virtual Table Name (Table:C252(yBWR_currentTable));Table:C252(yBWR_currentTable))
				End if 
			End if 
			
			dhBWR_ActualizaSetLocal   //20170801 RCH Workaround problema con set local
			
			USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			BWR_SelectTableData 
		End if 
	Else 
		CD_Dlog (0;__ ("Seleccione previamente los registros que desea eliminar."))
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	End if 
Else 
	CD_Dlog (0;__ ("Usted no tiene los permisos necesarios para eliminar estos registros."))
End if 


