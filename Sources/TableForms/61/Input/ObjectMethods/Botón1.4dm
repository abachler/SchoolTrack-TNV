If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : DupliHandler
	  //Autor: Alberto Bachler
	  //Creada el 29/8/96 a 9:30 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($0)
$0:=0

saved:=BBL_dcSave 
If (saved>=0)
	$id:=[BBL_Items:61]Numero:1
	DUPLICATE RECORD:C225([BBL_Items:61])
	[BBL_Items:61]Numero:1:=SQ_SeqNumber (->[BBL_Items:61]Numero:1)
	[BBL_Items:61]Copias:24:=0
	[BBL_Items:61]Copias_disponibles:43:=0
	[BBL_Items:61]Copias_reservadas:44:=0
	[BBL_Items:61]Use_number:40:=0
	[BBL_Items:61]UltimoNumeroDeCopia:49:=0
	[BBL_Items:61]Lugares:51:=""
	[BBL_Items:61]Auto_UUID:52:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
	$dupliID:=[BBL_Items:61]Numero:1
	SAVE RECORD:C53([BBL_Items:61])
	
	QUERY:C277([BBL_RegistrosAnaliticos:74];[BBL_RegistrosAnaliticos:74]ID:1=$id)
	READ WRITE:C146([BBL_RegistrosAnaliticos:74])
	CREATE SET:C116([BBL_RegistrosAnaliticos:74];"Duplis")
	For ($i;1;Records in selection:C76([BBL_RegistrosAnaliticos:74]))
		USE SET:C118("Duplis")
		GOTO SELECTED RECORD:C245([BBL_RegistrosAnaliticos:74];$i)
		READ WRITE:C146([BBL_RegistrosAnaliticos:74])
		DUPLICATE RECORD:C225([BBL_RegistrosAnaliticos:74])
		[BBL_RegistrosAnaliticos:74]ID:1:=$dupliID
		[BBL_RegistrosAnaliticos:74]ID_sub:8:=SQ_SeqNumber (->[BBL_RegistrosAnaliticos:74]ID_sub:8)
		[BBL_RegistrosAnaliticos:74]Auto_UUID:9:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
		SAVE RECORD:C53([BBL_RegistrosAnaliticos:74])
		UNLOAD RECORD:C212([BBL_RegistrosAnaliticos:74])
		READ ONLY:C145([BBL_RegistrosAnaliticos:74])
	End for 
	CLEAR SET:C117("Duplis")
	
	READ WRITE:C146([BBL_ItemMarcFields:205])
	QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Item:1=$id)
	CREATE SET:C116([BBL_ItemMarcFields:205];"Duplis")
	For ($i;1;Records in selection:C76([BBL_ItemMarcFields:205]))
		USE SET:C118("Duplis")
		GOTO SELECTED RECORD:C245([BBL_ItemMarcFields:205];$i)
		DUPLICATE RECORD:C225([BBL_ItemMarcFields:205])
		[BBL_ItemMarcFields:205]ID_Item:1:=$dupliID
		[BBL_ItemMarcFields:205]Auto_UUID:11:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
		SAVE RECORD:C53([BBL_ItemMarcFields:205])
	End for 
	KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
	
	READ WRITE:C146([BBL_FichasCatalograficas:81])
	QUERY:C277([BBL_FichasCatalograficas:81];[BBL_FichasCatalograficas:81]Nº de item:5=$id)
	CREATE SET:C116([BBL_FichasCatalograficas:81];"Duplis")
	For ($i;1;Records in selection:C76([BBL_FichasCatalograficas:81]))
		USE SET:C118("Duplis")
		GOTO SELECTED RECORD:C245([BBL_FichasCatalograficas:81];$i)
		DUPLICATE RECORD:C225([BBL_FichasCatalograficas:81])
		[BBL_FichasCatalograficas:81]Nº de item:5:=$dupliID
		[BBL_FichasCatalograficas:81]Auto_UUID:6:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
		SAVE RECORD:C53([BBL_FichasCatalograficas:81])
	End for 
	KRL_UnloadReadOnly (->[BBL_FichasCatalograficas:81])
	
	CD_Dlog (0;__ ("Registro duplicado exitosamente."))
	LOG_RegisterEvt ("Items duplicado por usuario.")
End if 