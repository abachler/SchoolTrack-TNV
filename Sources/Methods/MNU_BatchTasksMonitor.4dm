//%attributes = {}
  //MNU_BatchTasksMonitor

If (USR_IsGroupMember_by_GrpID (-15001))
	$ProcID:=Process number:C372("BatchTasksMonitor")
	If ($ProcID>0)
		RESUME PROCESS:C320($ProcID)
		SHOW PROCESS:C325($ProcID)
		BRING TO FRONT:C326($ProcID)
	Else 
		$batchtasks:=New process:C317("BM_BatchTasksManager";Pila_256K;"BatchTasksMonitor")
	End if 
Else 
	CD_Dlog (0;__ ("Necesita pertenecer al grupo de Administradores para realizar esta operación."))
End if 