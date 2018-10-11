//%attributes = {}
  //BM_CalculaPromediosCurso

  //DECLARATIONS
C_LONGINT:C283($batchRecNum;$1;$id;$status)
C_TEXT:C284($error)

  //INITIALIZATION
$batchRecNum:=$1
  //MAIN CODE

MESSAGES OFF:C175
$succes:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	$curso:=[xShell_BatchRequests:48]Msg:2
	READ WRITE:C146([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
	If (Records in selection:C76([Cursos:3])=1)
		$succes:=CU_CalculaPromedios (Record number:C243([Cursos:3]))
	Else 
		$succes:=True:C214
	End if 
End if 

$0:=$succes