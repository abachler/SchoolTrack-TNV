//%attributes = {}
  //MNU_ShowProcessesInfos

$ProcID:=Process number:C372("$ProcessesInfos")
If ($ProcID<=0)
	$pinfos:=New process:C317("KRL_ShowProcessesInformations";Pila_256K;"$ProcessesInfos")
Else 
	RESUME PROCESS:C320($ProcID)
	SHOW PROCESS:C325($ProcID)
	BRING TO FRONT:C326($ProcID)
End if 