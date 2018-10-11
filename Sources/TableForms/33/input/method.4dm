Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		vTT_CrearRecSemana:=0
		C_TEXT:C284(vt_SelJornada)
		C_TEXT:C284(vt_SelDia)
		C_LONGINT:C283(vl_selNumDia)
		C_TIME:C306(vd_SElHora)
		If (Is new record:C668([BU_Rutas_Recorridos:33]))
			[BU_Rutas_Recorridos:33]ID_Recorrido:1:=SQ_SeqNumber (->[BU_Rutas_Recorridos:33]ID_Recorrido:1)
			[BU_Rutas_Recorridos:33]Calle_Desde:8:=[BU_Rutas:26]Calle_Inicial:6
			[BU_Rutas_Recorridos:33]Calle_Hasta:9:=[BU_Rutas:26]Calle_Final:7
		Else 
			SET WINDOW TITLE:C213([BU_Rutas_Recorridos:33]Nombre:3)
		End if 
		LIST TO ARRAY:C288("STR_BUHoras";<>atSTR_BUHoras)
		ARRAY TEXT:C222(<>atSTR_BUDia;0)
		LOC_LoadList2Array ("XS_NombreDiasSemana";-><>atSTR_BUDia)  //EMA MOD:17/03/06
		LIST TO ARRAY:C288("cl_JornadaEscolar";<>atSTR_BUJornada)
		[BU_Rutas_Recorridos:33]ID_Ruta:2:=[BU_Rutas:26]ID:12
		
		vt_SelJornada:=[BU_Rutas_Recorridos:33]Jornada:4
		vl_selNumDia:=[BU_Rutas_Recorridos:33]Dia_Semana_Num:12
		vd_SElHora:=[BU_Rutas_Recorridos:33]Hora:5
		vt_DiasSemana:=[BU_Rutas_Recorridos:33]Dia_Semana:6
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
	: (Form event:C388=On Deactivate:K2:10)
		
		
End case 