//%attributes = {}
  //SYS_EsServidorIntegraciones
  //20130413 RCH metodo creado para sabers si estamos ejecutando codigo sobre Condor
  //20130413 RCH Se testea usando nombre de maquina y nombre de usuario. No considere buena opcion comparar la MAC

C_TEXT:C284($t_currentMachineOwner;$t_currentMachine)
C_BOOLEAN:C305($0)

$t_currentMachine:=Current machine:C483
$t_currentMachineOwner:=Current system user:C484

If (($t_currentMachine="Condor") & ($t_currentMachineOwner="Condor-Admin") & (Not:C34(Is compiled mode:C492)))
	$0:=True:C214
Else 
	$0:=False:C215
End if 