//%attributes = {}
  // BBLdbu_InitLibraryDatabase()
  // Por: Alberto Bachler: 17/09/13, 13:20:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

OK:=CD_Dlog (0;__ ("Inicialización de registros de biblioteca.\r¿Desea eliminar los registros y las preferencias?");__ ("");__ ("Nada");__ ("Solo registros");__ ("Todo"))
If (Application type:C494=4D Remote mode:K5:5)
	GET PROCESS VARIABLE:C371(-1;<>vb_AvoidTriggerExecution;$b_AvoidTriggerExecution)
	DELAY PROCESS:C323(Current process:C322;15)
Else 
	$b_AvoidTriggerExecution:=<>vb_AvoidTriggerExecution
End if 
0xDev_AvoidTriggerExecution (True:C214)
If (OK>=2)
	0xDev_ClearTable (->[BBL_RegistrosAnaliticos:74])
	0xDev_ClearTable (->[BBL_Transacciones:59])
	0xDev_ClearTable (->[BBL_Index:70])
	0xDev_ClearTable (->[BBL_FichasCatalograficas:81])
	0xDev_ClearTable (->[BBL_Items:61])
	0xDev_ClearTable (->[BBL_Prestamos:60])
	0xDev_ClearTable (->[BBL_Lectores:72])
	0xDev_ClearTable (->[BBL_Registros:66])
	0xDev_ClearTable (->[BBL_Reservas:115])
	0xDev_ClearTable (->[BBL_Subscripciones:117])
	0xDev_ClearTable (->[BBL_Thesaurus:68])
	0xDev_ClearTable (->[BBL_ItemMarcFields:205])
End if 
If (OK=3)
	0xDev_ClearTable (->[xxBBL_Preferencias:65])
	0xDev_ClearTable (->[xxBBL_ReglasParaItems:69])
	0xDev_ClearTable (->[xxBBL_ReglasParaUsuarios:64])
End if 



QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1="GEN")
If (Records in selection:C76([xxBBL_ReglasParaItems:69])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
	[xxBBL_ReglasParaItems:69]Codigo_regla:1:="GEN"
	[xxBBL_ReglasParaItems:69]Nombre Regla:2:="Genérica"
	[xxBBL_ReglasParaItems:69]DiasPrestamo:3:=14
	[xxBBL_ReglasParaItems:69]Dias_gracia:4:=3
	[xxBBL_ReglasParaItems:69]Multa_diaria:5:=0
	[xxBBL_ReglasParaItems:69]Max_renovacione:6:=1
	[xxBBL_ReglasParaItems:69]Reserva_anticipación:7:=2
	SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
	UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
End if 

QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1="SYS")
If (Records in selection:C76([xxBBL_ReglasParaItems:69])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
	[xxBBL_ReglasParaItems:69]Codigo_regla:1:="SYS"
	[xxBBL_ReglasParaItems:69]Nombre Regla:2:="Sistema"
	SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
	UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
End if 

QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="GEN")
If (Records in selection:C76([xxBBL_ReglasParaUsuarios:64])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaUsuarios:64])
	[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:="GEN"
	[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:="Genérica"
	[xxBBL_ReglasParaUsuarios:64]Max_Prestamos:3:=2
	[xxBBL_ReglasParaUsuarios:64]Max_Vencidos:4:=1
	[xxBBL_ReglasParaUsuarios:64]Max_Reservas:5:=1
	[xxBBL_ReglasParaUsuarios:64]Dias_Prestamo:8:=14
	SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
	UNLOAD RECORD:C212([xxBBL_ReglasParaUsuarios:64])
End if 

QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="SYS")
If (Records in selection:C76([xxBBL_ReglasParaUsuarios:64])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaUsuarios:64])
	[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:="SYS"
	[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:="Sistema"
	SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
	UNLOAD RECORD:C212([xxBBL_ReglasParaUsuarios:64])
End if 


If (Records in table:C83([xxBBL_Preferencias:65])=0)
	CREATE RECORD:C68([xxBBL_Preferencias:65])
	[xxBBL_Preferencias:65]Registro_BarCodeConPrefijo:32:=True:C214
	[xxBBL_Preferencias:65]Dias prestamo:9:=14
	[xxBBL_Preferencias:65]Dias gracia:11:=0
	[xxBBL_Preferencias:65]Multa diaria:10:=0
	[xxBBL_Preferencias:65]DiasReserva:20:=2
	[xxBBL_Preferencias:65]MaxRenovaciones:21:=1
	[xxBBL_Preferencias:65]AutoCreatCpy:24:=True:C214
	[xxBBL_Preferencias:65]CharsToIndex:25:=2
	[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=Field:C253(->[BBL_Lectores:72]ID:1)
	[xxBBL_Preferencias:65]Lector_PrefijoCodigoBarra:34:="LEC"
	[xxBBL_Preferencias:65]Registro_PrefijoCodigoBarra:23:="REG"
	[xxBBL_Preferencias:65]Usa_MARC:38:=False:C215
	SAVE RECORD:C53([xxBBL_Preferencias:65])
	BBL_LeePrefsCodigosBarra 
	UNLOAD RECORD:C212([xxBBL_Preferencias:65])
End if 



BBLsys_LoadSystemUsers 
BBL_LeeConfiguracion 

0xDev_AvoidTriggerExecution ($b_AvoidTriggerExecution)

