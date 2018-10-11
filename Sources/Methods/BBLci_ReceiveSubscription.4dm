//%attributes = {}
  // BBLci_ReceiveSubscription()
  // Por: Alberto Bachler: 17/09/13, 13:10:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

_O_C_INTEGER:C282($i)
C_TEXT:C284($t_parametro;$t_titulo)

If (False:C215)
	C_TEXT:C284(BBLci_ReceiveSubscription ;$1)
End if 

$t_parametro:=$1
$t_titulo:=$t_parametro+"@"

READ WRITE:C146([BBL_Subscripciones:117])
QUERY:C277([BBL_Subscripciones:117];[BBL_Subscripciones:117]Titulo:2=$t_titulo)
Case of 
	: (Records in selection:C76([BBL_Subscripciones:117])=0)
		OK:=CD_Dlog (0;__ ("Subscripción inexistente.\rPor favor cree la subscripción fuera del módulo de circulación."))
	: ((Records in selection:C76([BBL_Subscripciones:117])=1) & ($t_titulo#""))
		  //
	: ((Records in selection:C76([BBL_Subscripciones:117])>1) | ($t_titulo=""))
		SELECTION TO ARRAY:C260([BBL_Subscripciones:117]Clasificación:22;<>aText1;[BBL_Subscripciones:117]Titulo:2;<>aText2;[BBL_Subscripciones:117]ISSN:9;<>aText3)
		For ($i;1;Size of array:C274(<>aText1))
			<>aText1{$i}:=Replace string:C233(<>aText1{$i};"*";"")
		End for 
		ARRAY POINTER:C280(<>aChoicePtrs;3)
		<>aChoicePtrs{1}:=-><>aText1
		<>aChoicePtrs{2}:=-><>aText2
		<>aChoicePtrs{3}:=-><>aText3
		TBL_ShowChoiceList (0)
		If ((ok=1) & (choiceIdx>0))
			GOTO SELECTED RECORD:C245([BBL_Subscripciones:117];aIndex{choiceIdx})
		Else 
			REDUCE SELECTION:C351([BBL_Subscripciones:117];0)
		End if 
End case 

If (Record number:C243([BBL_Subscripciones:117])>=0)
	READ WRITE:C146([BBL_Items:61])
	READ WRITE:C146([BBL_Registros:66])
	aCpyBCode:=0
	CREATE RECORD:C68([BBL_Items:61])
	[BBL_Items:61]Numero:1:=SQ_SeqNumber (->[BBL_Items:61]Numero:1)
	[BBL_Items:61]Clasificacion:2:=[BBL_Subscripciones:117]Clasificación:22
	[BBL_Items:61]Primer_título:4:=[BBL_Subscripciones:117]Titulo:2
	[BBL_Items:61]Titulos:5:=[BBL_Subscripciones:117]Titulo:2
	[BBL_Items:61]Primer_editor:8:=[BBL_Subscripciones:117]Editor:20
	[BBL_Items:61]Editores:9:=[BBL_Subscripciones:117]Editor:20
	[BBL_Items:61]Lugar_de_edicion:12:=[BBL_Subscripciones:117]Lugar_edicion:23
	[BBL_Items:61]Media:15:=[BBL_Subscripciones:117]Media:25
	[BBL_Items:61]Regla:20:=[BBL_Subscripciones:117]Regla:24
	[BBL_Items:61]Serie_Nombre:26:=[BBL_Subscripciones:117]Titulo:2
	[BBL_Items:61]Serie_Frecuencia:29:=[BBL_Subscripciones:117]Periodicidad:3
	[BBL_Items:61]Serie_ISSN:31:=[BBL_Subscripciones:117]ISSN:9
	[BBL_Items:61]Creado_por:33:=<>tUSR_CurrentUser
	[BBL_Items:61]Modificado_por:34:=<>tUSR_CurrentUser
	[BBL_Items:61]Idioma:35:=[BBL_Subscripciones:117]Idioma:21
	[BBL_Items:61]Fecha_de_creacion:36:=Current date:C33(*)
	[BBL_Items:61]Fecha_de_modificacion:37:=Current date:C33
	[BBL_Items:61]Número_de_suscripción:41:=[BBL_Subscripciones:117]ID:1
	SAVE RECORD:C53([BBL_Items:61])
	
	CREATE RECORD:C68([BBL_Registros:66])
	[BBL_Registros:66]Número_de_item:1:=[BBL_Items:61]Numero:1
	[BBL_Registros:66]Número_de_copia:2:=1
	[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
	[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
	[BBL_Registros:66]Proveedor:4:=[BBL_Subscripciones:117]Proveedor_nombre:10
	[BBL_Registros:66]Fecha_de_ingreso:5:=Current date:C33(*)
	[BBL_Registros:66]StatusID:34:=Disponible
	[BBL_Registros:66]Comentario:11:=""
	[BBL_Registros:66]Código_de_barra:20:=""
	BBLreg_GeneraCodigoBarra 
	SAVE RECORD:C53([BBL_Registros:66])
	
	  //WDW_Open (550;280;0;-1984;"Recepción de nuevo ejemplar";"wdwClose")
	WDW_OpenFormWindow (->[BBL_Registros:66];"Periodicals";-1;8;__ ("Recepción de nuevo ejemplar"))
	FORM SET INPUT:C55([BBL_Registros:66];"Periodicals")
	MODIFY RECORD:C57([BBL_Registros:66];*)
	CLOSE WINDOW:C154
	
	If (ok=1)
		[BBL_Subscripciones:117]Ultima_recepcion:8:=Current date:C33(*)
		SAVE RECORD:C53([BBL_Subscripciones:117])
		  //BBLci_LogEntry2("- Suscripción: ";[BBL_Items]Primer_título+", Nº "+[BBL_Items]Serie_No+" de "+[BBL_Items]Serie_Fecha_de_publicación+" recibido";String(Current date(*);7))
		
	Else 
		DELETE RECORD:C58([BBL_Registros:66])
		DELETE RECORD:C58([BBL_Items:61])
	End if 
	READ ONLY:C145([BBL_Items:61])
	READ ONLY:C145([BBL_Registros:66])
	bBWR_SaveRecord:=0
	bBWR_Cancel:=0
	bBWR_Delete:=0
	<>bFirst:=0
	<>bPrevious:=0
	<>bNext:=0
	<>bLast:=0
	<>bInfo:=0
End if 

UNLOAD RECORD:C212([BBL_Subscripciones:117])
UNLOAD RECORD:C212([BBL_Registros:66])
UNLOAD RECORD:C212([BBL_Items:61])
  //BBLci_SwitchMode (1)
