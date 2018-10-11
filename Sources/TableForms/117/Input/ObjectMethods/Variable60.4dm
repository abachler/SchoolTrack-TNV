$saved:=BBLss_fSave 
If ($saved>=0)
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
	[BBL_Items:61]ID_Media:48:=[BBL_Subscripciones:117]ID_Media:26
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
	[BBL_Items:61]Copias_reservadas:44:=0
	SAVE RECORD:C53([BBL_Items:61])
	
	
	CREATE RECORD:C68([BBL_Registros:66])
	[BBL_Registros:66]Número_de_item:1:=[BBL_Items:61]Numero:1
	[BBL_Registros:66]Número_de_copia:2:=1
	[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
	[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
	[BBL_Registros:66]Proveedor:4:=[BBL_Subscripciones:117]Proveedor_nombre:10
	[BBL_Registros:66]Fecha_de_ingreso:5:=Current date:C33(*)
	[BBL_Registros:66]StatusID:34:=Disponible
	BBLreg_GeneraCodigoBarra 
	SAVE RECORD:C53([BBL_Registros:66])
	
	[BBL_Items:61]Copias:24:=1
	[BBL_Items:61]Copias_disponibles:43:=1
	SAVE RECORD:C53([BBL_Items:61])
	
	
	
	WDW_OpenFormWindow (->[BBL_Registros:66];"Periodicals";-1;4;__ ("Recepción de nuevo ejemplar");"wdwClose")
	FORM SET INPUT:C55([BBL_Registros:66];"Periodicals")
	MODIFY RECORD:C57([BBL_Registros:66];*)
	CLOSE WINDOW:C154
	
	If (ok=1)
		[BBL_Subscripciones:117]Ultima_recepcion:8:=Current date:C33(*)
		SAVE RECORD:C53([BBL_Registros:66])
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
	QUERY:C277([BBL_Items:61];[BBL_Items:61]Número_de_suscripción:41=[BBL_Subscripciones:117]ID:1)
	KRL_RelateSelection (->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Numero:1;"")
	AL_UpdateFields (xALP_SerialPub;2)
	AL_SetSort (xALP_SerialPub;-1)
	
	ALP_SetDefaultAppareance (xALP_SerialPub)
	ALP_SetAlternateLigneColor (xALP_SerialPub;Records in selection:C76([BBL_Items:61]))
	
	BWR_OnActivateFormEvent 
End if 
