//%attributes = {}
  //UD_v20130730_ACT_Cantidad 
  //20130626 RCH NF CANTIDAD
  //En el trigger se asigna un 1 al campo si es que esta en 0.
If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_proc)
	$l_proc:=IT_UThermometer (1;0;"Inicializando datos de nuevo campo...")
	READ WRITE:C146([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]ID:1:=[ACT_Cargos:173]ID:1)
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	IT_UThermometer (-2;$l_proc)
End if 