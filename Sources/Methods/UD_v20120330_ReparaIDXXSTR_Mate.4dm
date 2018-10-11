//%attributes = {}
  //UD_v20120330_ReparaIDXXSTR_Mate

  // ----------------------------------------------------
  // Nombre usuario (OS): asepulveda
  // Fecha y hora: 30/03/12, 13:15:16
  // ----------------------------------------------------
  // Método: UD_v20120330_ReparaIDXXSTR_Mate
  // Descripción
  // Repara los Id de materias.
  //
  // Parámetros
  // ----------------------------------------------------

START TRANSACTION:C239
READ WRITE:C146([xxSTR_Materias:20])
C_LONGINT:C283($p;$i)
C_BOOLEAN:C305($b_go)
ARRAY LONGINT:C221($al_Recnum;0)
$p:=IT_UThermometer (1;0;"Verificando Materias")
QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]ID_Materia:16=0)
SELECTION TO ARRAY:C260([xxSTR_Materias:20];$al_Recnum)
For ($i;1;Size of array:C274($al_Recnum))
	GOTO RECORD:C242([xxSTR_Materias:20];$al_Recnum{$i})
	[xxSTR_Materias:20]ID_Materia:16:=SQ_SeqNumber (->[xxSTR_Materias:20]ID_Materia:16)
	$b_go:=Locked:C147([xxSTR_Materias:20])
	If (Not:C34($b_go))
		SAVE RECORD:C53([xxSTR_Materias:20])
	Else 
		CANCEL TRANSACTION:C241
		$i:=Size of array:C274($al_Recnum)+1
	End if 
End for 
IT_UThermometer (-2;$p)
If (Not:C34($b_go))
	VALIDATE TRANSACTION:C240
End if 
KRL_UnloadReadOnly (->[xxSTR_Materias:20])
