//%attributes = {}
  //BM_CalculaPorcentajeAsistencia

  //DECLARATIONS
C_LONGINT:C283($batchID;$1;$id;$status)
C_TEXT:C284($error)
C_BOOLEAN:C305($0;$succes)

  //INITIALIZATION
$batchRecNum:=$1
  //MAIN CODE

MESSAGES OFF:C175
READ WRITE:C146([xShell_BatchRequests:48])
GOTO RECORD:C242([xShell_BatchRequests:48];$batchRecNum)

$id:=Num:C11([xShell_BatchRequests:48]Msg:2)

$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id)
If ($recNum>=0)
	$succes:=AL_TotalizaInasistencias ($id)
	Case of 
		: (<>vtXS_CountryCode="cl")
			AL_CalculaSituacionFinal ($id)
			
			
		Else 
			
	End case 
Else 
	$succes:=True:C214
End if 

$0:=$succes