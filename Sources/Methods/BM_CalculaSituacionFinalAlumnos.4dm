//%attributes = {}
  //BM_CalculaSituacionFinalAlumnos

  //DECLARATIONS
C_LONGINT:C283($batchRecNum;$1;$id;$status)
C_TEXT:C284($error)
C_BOOLEAN:C305($0;$succes)

  //INITIALIZATION
$batchRecNum:=$1
  //MAIN CODE

vb_AsignaSituacionFinal:=False:C215

MESSAGES OFF:C175
$succes:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	
	$id:=Num:C11([xShell_BatchRequests:48]Msg:2)
	READ WRITE:C146([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$id)
	If (Records in selection:C76([Alumnos:2])=1)
		If (Find in array:C230(<>al_NumeroNivelesActivos;[Alumnos:2]nivel_numero:29)>0)
			$succes:=AL_CalculaSituacionFinal ($id)
		Else 
			$succes:=True:C214
		End if 
	Else 
		$succes:=True:C214
	End if 
End if 

$0:=$succes
KRL_UnloadAll 
