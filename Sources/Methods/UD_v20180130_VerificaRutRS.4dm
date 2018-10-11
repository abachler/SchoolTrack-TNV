//%attributes = {}
  //UD_v20180130_VerificaRutRS
  //Corrige problema, introducido el 20180113, con rut de RS que se almacenaba con formato

ARRAY LONGINT:C221($al_recordNumberRS;0)
C_LONGINT:C283($l_indice)

READ ONLY:C145([ACT_RazonesSociales:279])
ALL RECORDS:C47([ACT_RazonesSociales:279])
LONGINT ARRAY FROM SELECTION:C647([ACT_RazonesSociales:279];$al_recordNumberRS;"")

For ($l_indice;1;Size of array:C274($al_recordNumberRS))
	READ WRITE:C146([ACT_RazonesSociales:279])
	GOTO RECORD:C242([ACT_RazonesSociales:279];$al_recordNumberRS{$l_indice})
	[ACT_RazonesSociales:279]RUT:3:=Replace string:C233(Replace string:C233([ACT_RazonesSociales:279]RUT:3;".";"");"-";"")
	SAVE RECORD:C53([ACT_RazonesSociales:279])
	KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
End for 