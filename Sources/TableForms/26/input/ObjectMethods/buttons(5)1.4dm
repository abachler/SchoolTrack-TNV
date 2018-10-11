WDW_OpenFormWindow (->[BU_Rutas_Recorridos:33];"input";-1;4)
FORM SET INPUT:C55([BU_Rutas_Recorridos:33];"input")
ADD RECORD:C56([BU_Rutas_Recorridos:33];*)
CLOSE WINDOW:C154
If (vTT_CrearRecSemana>0)
	Case of 
		: (vTT_CrearRecSemana=9)
			$t:=5
		: (vTT_CrearRecSemana=10)
			$t:=6
		: (vTT_CrearRecSemana=11)
			$t:=7
	End case 
	For ($i;2;$t)
		DUPLICATE RECORD:C225([BU_Rutas_Recorridos:33])
		[BU_Rutas_Recorridos:33]ID_Recorrido:1:=SQ_SeqNumber (->[BU_Rutas_Recorridos:33]ID_Recorrido:1)
		[BU_Rutas_Recorridos:33]Dia_Semana:6:=<>atSTR_BUDia{$i}
		[BU_Rutas_Recorridos:33]Dia_Semana_Num:12:=$i
		[BU_Rutas_Recorridos:33]Auto_UUID:13:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
		If ([BU_Rutas_Recorridos:33]Ida_o_vuelta:7=False:C215)
			[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+<>atSTR_BUDia{$i}+" "+"Salida"
		Else 
			[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+<>atSTR_BUDia{$i}+" "+"Entrada"
		End if 
		SAVE RECORD:C53([BU_Rutas_Recorridos:33])
		[BU_Rutas:26]Total_Recorridos:13:=[BU_Rutas:26]Total_Recorridos:13+1
		SAVE RECORD:C53([BU_Rutas:26])
	End for 
End if 
KRL_UnloadReadOnly (->[BU_Rutas_Recorridos:33])
BU_Refresh_Recorridos (1;[BU_Rutas:26]ID:12)
$er:=Size of array:C274(alBU_IdRecorrido)
If ($er>0)
	_O_ENABLE BUTTON:C192(bDel)
	_O_ENABLE BUTTON:C192(bPrintItems)
	
Else 
	
	_O_DISABLE BUTTON:C193(bDel)
	_O_DISABLE BUTTON:C193(bPrintItems)
End if 
