//%attributes = {}
  //ACTcc_ReplaceAsignedMatrix

C_LONGINT:C283($matrixID2Replace;$1)
C_LONGINT:C283($matrixID2Asign;$2)
C_LONGINT:C283($annulation;$3)
$matrixID2Replace:=$1
$matrixID2Asign:=$2
$annulation:=$3

READ WRITE:C146([ACT_CuentasCorrientes:175])
If ($matrixID2Replace#0)
	QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$matrixID2Replace)
End if 

If ($annulation=1)
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];$aRecNums)
	For ($recnumIndex;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRecNums{$recNumIndex})
	End for 
Else 
	APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7:=$matrixID2Asign)
End if 
UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_CuentasCorrientes:175])
